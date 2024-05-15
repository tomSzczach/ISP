----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2024 22:57:00
-- Design Name: 
-- Module Name: lissajous_generator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lissajous_generator is

    Port ( 
            clk_i : in STD_LOGIC;
            singen_rst_i : in STD_LOGIC;
            x_freq_i : in STD_LOGIC_VECTOR (7 downto 0);
            y_freq_i : in STD_LOGIC_VECTOR (7 downto 0);
            x_offset_i : in STD_LOGIC_VECTOR (7 downto 0);
            y_offset_i : in STD_LOGIC_VECTOR (7 downto 0);
            x_pos_o : out NATURAL := 0;
            y_pos_o : out NATURAL := 0;
            is_pos_valid_o : out STD_LOGIC := '0'
         );
         
end lissajous_generator;

architecture Behavioral of lissajous_generator is

    -- COMPONENTS
    COMPONENT singen
        Port (
                  aclk : IN STD_LOGIC;                                      -- clock
                  aclken : IN STD_LOGIC;                                    -- Active-High clock enable. Stop generator by 0 (signal must be 1 while changing config)
                  aresetn : IN STD_LOGIC;                                   -- Active-Low synchronous clear. Always takes priority over aclken. aresetn must be driven Low for a minimum of two cycles to reset the core.
                  s_axis_config_tvalid : IN STD_LOGIC;                      -- enable config + enable config for 1st channel
                  s_axis_config_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);   -- phase is (31 downto 16), frequency is (15 downto 0)
                  s_axis_config_tlast : IN STD_LOGIC;                       -- enable config for 2nd channel
                  m_axis_data_tvalid : OUT STD_LOGIC;                       -- if (m_axis_data_tdata is valid) then '1'
                  m_axis_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);    -- significant bits are (10 downto 0)
                  event_s_config_tlast_missing : OUT STD_LOGIC;             -- left open
                  event_s_config_tlast_unexpected : OUT STD_LOGIC           -- left open
             );
    END COMPONENT;
    
    -- TYPES --
    type GENERATOR_RESET_STATE is (
                        IDLE,
                        RESET,
                        SET_CHANNEL_1,
                        SET_CHANNEL_2
                    );
                    
    type GENERATOR_DATA_STATE is (
                    DATA_CHANNEL_1,
                    DATA_CHANNEL_2
                );
                    
    -- CONSTANTS
    constant C_init_reset_state : GENERATOR_RESET_STATE := IDLE;
    constant C_init_data_state : GENERATOR_DATA_STATE := DATA_CHANNEL_1;
    constant C_gen_reset_time : NATURAL := 2; -- in clock cycles - Low for a minimum of two cycles to guarantee that there is no violation of the AXI4-Stream protocol (DDS Compiler v6.0 29 PG141 January 21, 2021 www.xilinx.com Chapter 3: Designing with the Core on the core outputs)
   
    -- FUNCTIONS
    function F_transform_x(x_gen: STD_LOGIC_VECTOR(10 DOWNTO 0)) return NATURAL
    is
        variable x_scaled : SIGNED(12 downto 0) := (others => '0');
        variable x_scaled_translated : SIGNED(12 downto 0) := (others => '0');
        variable x_vga : NATURAL := 0;
    begin
        x_scaled := signed(x_gen(10) & "00" & x_gen(9 downto 0));        -- value : x' = x              | range : [-1024,1024]
        x_scaled := x_scaled + x_scaled + x_scaled;                      -- value : x' = 3x        
        x_scaled := "0000" & x_scaled(12 downto 4);                     -- value : x' = 3x/16           | range : [-192,192]
        
        x_scaled_translated := x_scaled + 192;                          -- value : x' = (3x/16)+192     | range : [0,384]
        
        x_vga := TO_INTEGER(unsigned(x_scaled_translated));
        
        return (x_vga);
    end function F_transform_x;
    
    function F_transform_y(y_gen: STD_LOGIC_VECTOR(10 DOWNTO 0)) return NATURAL
    is
        variable y_scaled : SIGNED(12 downto 0) := (others => '0');
        variable y_scaled_translated : SIGNED(12 downto 0) := (others => '0');
        variable y_vga : NATURAL := 0;
    begin
        y_scaled := signed(y_gen(10) & "00" & y_gen(9 downto 0));        -- value : y' = y              | range : [-1024,1024]
        y_scaled := y_scaled + y_scaled + y_scaled;                      -- value : y' = 3y        
        y_scaled := "0000" & y_scaled(12 downto 4);                     -- value : y' = 3y/16           | range : [-192,192]
        
        y_scaled_translated := -y_scaled;                               -- value : y' = -3y/16          | range : [192,-192]
        y_scaled_translated := y_scaled_translated + 192;               -- value : y' = (-3x/16)+192    | range : [384,0]
        
        y_vga := TO_INTEGER(unsigned(y_scaled_translated));
        
        return (y_vga);
    end function F_transform_y;
   
    -- SIGNALS --    
    signal reset_state : GENERATOR_RESET_STATE := C_init_reset_state;
    signal data_state : GENERATOR_DATA_STATE := C_init_data_state;
   
    signal is_gen_working : STD_LOGIC := '1';
    signal isnt_gen_reset :  STD_LOGIC := '1';
    signal gen_config_ch1_en : STD_LOGIC := '0';
    signal gen_config_ch2_en : STD_LOGIC := '0';
    signal gen_config_data : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    signal is_data_valid :  STD_LOGIC := '0';
    signal data : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');

begin

    dds_generator : singen
    PORT MAP (
        aclk => clk_i,
        aclken => is_gen_working,
        aresetn => isnt_gen_reset,
        s_axis_config_tvalid => gen_config_ch1_en,
        s_axis_config_tdata => gen_config_data,
        s_axis_config_tlast => gen_config_ch2_en,
        m_axis_data_tvalid => is_data_valid,
        m_axis_data_tdata => data,
        event_s_config_tlast_missing => open,
        event_s_config_tlast_unexpected => open      
    );


    GENERATOR_RESET_HANDLER:
    process (clk_i)
        variable rst_time : NATURAL range 0 to C_gen_reset_time := C_gen_reset_time;
    begin
        if rising_edge (clk_i) then
        
            case reset_state is
            
                when IDLE =>
                    gen_config_ch1_en <= '0';
                    gen_config_ch2_en <= '0';
                    isnt_gen_reset <= '1';      
                             
                    if singen_rst_i = '1' then
                        reset_state <= RESET;
                        rst_time := C_gen_reset_time;
                    end if;
                    
                when RESET =>                   
                    if rst_time = 0 then
                        reset_state <= SET_CHANNEL_1;
                        isnt_gen_reset <= '1';
                        
                    else
                        isnt_gen_reset <= '0';
                        rst_time := rst_time - 1;
                        
                    end if;
                
                when SET_CHANNEL_1 =>
                    gen_config_ch1_en <= '1';
                    gen_config_data <= "00000000" & x_offset_i & "00000000" & x_freq_i;
                    reset_state <= SET_CHANNEL_2;
                    
                when SET_CHANNEL_2 =>
                    gen_config_ch2_en <= '1';
                    gen_config_data <= "00000000" & y_offset_i & "00000000" & y_freq_i;
                    reset_state <= IDLE;
                    
                when others => reset_state <= C_init_reset_state;
                
            end case;
        end if;
    end process;
    
    
    GENERATOR_DATA_HANDLER:
    process (clk_i)
    begin
        if rising_edge (clk_i) then
        
            if (is_data_valid = '1') then
            
                case data_state is 
                    
                    when DATA_CHANNEL_1 =>
                        x_pos_o <= F_transform_x(data(10 DOWNTO 0));
                        is_pos_valid_o <= '0';
                        data_state <= DATA_CHANNEL_2;
                    
                    when DATA_CHANNEL_2 =>
                        y_pos_o <= F_transform_y(data(10 DOWNTO 0));
                        is_pos_valid_o <= '1';
                        data_state <= DATA_CHANNEL_1;
                    
                    when others => data_state <= C_init_data_state;
                    
                end case;          
            
            else
                data_state <= C_init_data_state;
                data_ch1_o <= (others => '0');
                data_ch2_o <= (others => '0');
                data_valid_o <= '0';
                
            end if;        
        end if;
    end process;

end Behavioral;
