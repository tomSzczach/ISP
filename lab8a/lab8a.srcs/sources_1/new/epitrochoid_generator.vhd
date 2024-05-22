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

entity epitrochoid_generator is

    Port ( 
            clk_i : in STD_LOGIC;
            gen_rst_i : in STD_LOGIC;
            ch1_freq_i : in STD_LOGIC_VECTOR (7 downto 0);
            ch2_freq_i : in STD_LOGIC_VECTOR (7 downto 0);
            A_amp_i : in STD_LOGIC_VECTOR (7 downto 0);
            B_amp_i : in STD_LOGIC_VECTOR (7 downto 0);
            x_pos_o : out NATURAL := 0;
            y_pos_o : out NATURAL := 0;
            is_pos_valid_o : out STD_LOGIC := '0'
         );
         
end epitrochoid_generator;

architecture Behavioral of epitrochoid_generator is

    -- COMPONENTS
    COMPONENT sincosgen
        Port (
                  aclk : IN STD_LOGIC;                                      -- clock
                  aclken : IN STD_LOGIC;                                    -- Active-High clock enable. Stop generator by 0 (signal must be 1 while changing config)
                  aresetn : IN STD_LOGIC;                                   -- Active-Low synchronous clear. Always takes priority over aclken. aresetn must be driven Low for a minimum of two cycles to reset the core.
                  s_axis_config_tvalid : IN STD_LOGIC;                      -- enable config + enable config for 1st channel
                  s_axis_config_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);   -- phase is (31 downto 16), frequency is (15 downto 0)
                  s_axis_config_tlast : IN STD_LOGIC;                       -- enable config for 2nd channel
                  m_axis_data_tvalid : OUT STD_LOGIC;                       -- if (m_axis_data_tdata is valid) then '1'
                  m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);    -- significant bits are (10 downto 0)
                  event_s_config_tlast_missing : OUT STD_LOGIC;             -- left open
                  event_s_config_tlast_unexpected : OUT STD_LOGIC           -- left open
             );
    END COMPONENT;
    
    -- TYPES --
    type GENERATOR_RESET_STATE is (
                        IDLE,
                        RESET,
                        SET_CHANNEL_1,
                        SET_CHANNEL_2,
                        SET_AMPLITUDES
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
    
    function F_transform(
        A_amp: STD_LOGIC_VECTOR (7 downto 0);
        ch1_fun: STD_LOGIC_VECTOR(10 DOWNTO 0);
        B_amp: STD_LOGIC_VECTOR (7 downto 0);
        ch2_fun: STD_LOGIC_VECTOR(10 DOWNTO 0)
    ) return INTEGER
    is
        variable ch1_transformed : UNSIGNED(18 downto 0) := (others => '0');
        variable ch2_transformed : UNSIGNED(18 downto 0) := (others => '0');
        variable p : SIGNED(18 downto 0) := (others => '0');
        variable p_vga : INTEGER := 0;
    begin
        ch1_transformed := unsigned(A_amp) * unsigned(signed(ch1_fun) + 1024);  -- value : ch1' = A*(ch1+1024)            | range : [0,A*2048]
        ch2_transformed := unsigned(B_amp) * unsigned(signed(ch2_fun) + 1024);  -- value : ch2' = B*(ch1+1024)            | range : [0,B*2048]                   
        
        ch1_transformed := "0000000000" & ch1_transformed(18 downto 10);         -- value : ch1' = (A/1024)*(ch1+1024)     | range : [0,2*A]
        ch2_transformed := "0000000000" & ch2_transformed(18 downto 10);         -- value : ch2' = (B/1024)*(ch1+1024)     | range : [0,2*B]
        
        p := signed(ch1_transformed - ch2_transformed);                          -- value : p' = ch1'-ch2'                 | range : [0,2*(A-B)]
        p := 192 + p - ( signed("0" & A_amp) - signed("0" & B_amp) );            -- value : p' = 192+(ch1'-ch2')-(A-B)      | range : [192-(A-B),192+(A-B)]
        
        p_vga := TO_INTEGER(p);        
        --  range : [ MAX( 0,192-(A-B) ) , MIN( 383,192+(A-B) ) ]
        
        return (p_vga);
    end function F_transform;
   
   
    -- SIGNALS --    
    signal reset_state : GENERATOR_RESET_STATE := C_init_reset_state;
    signal data_state : GENERATOR_DATA_STATE := C_init_data_state;
   
    signal is_gen_working : STD_LOGIC := '1';
    signal isnt_gen_reset :  STD_LOGIC := '1';
    signal gen_config_ch1_en : STD_LOGIC := '0';
    signal gen_config_ch2_en : STD_LOGIC := '0';
    signal gen_config_data : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
    signal is_data_valid :  STD_LOGIC := '0';
    signal data : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    
    signal is_pos_valid : STD_LOGIC := '0';
    signal is_xy_valid : STD_LOGIC := '0';
    
    signal data_ch1 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    alias cos_ch1: STD_LOGIC_VECTOR is data_ch1(10 DOWNTO 0);
    alias sin_ch1: STD_LOGIC_VECTOR is data_ch1(26 DOWNTO 16);
    
    signal data_ch2 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    alias cos_ch2: STD_LOGIC_VECTOR is data_ch2(10 DOWNTO 0);
    alias sin_ch2: STD_LOGIC_VECTOR is data_ch2(26 DOWNTO 16);
    
    signal A_amp : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal B_amp : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    
    signal x_pos : INTEGER := 0;
    signal y_pos : INTEGER := 0;

begin

    dds_generator : sincosgen
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
                             
                    if gen_rst_i = '1' then
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
                    gen_config_data <= "00000000" & ch1_freq_i;
                    reset_state <= SET_CHANNEL_2;
                    
                when SET_CHANNEL_2 =>
                    gen_config_ch2_en <= '1';
                    gen_config_data <= "00000000" & ch2_freq_i;
                    reset_state <= SET_AMPLITUDES;
                    
                when SET_AMPLITUDES =>
                    A_amp <= A_amp_i;
                    B_amp <= B_amp_i;
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
                        is_pos_valid <= '0';
                        data_ch1 <= data;
                        data_state <= DATA_CHANNEL_2;
                    
                    when DATA_CHANNEL_2 =>
                        is_pos_valid <= '1';
                        data_ch2 <= data;
                        data_state <= DATA_CHANNEL_1;
                    
                    when others => data_state <= C_init_data_state;
                    
                end case;          
            
            else
                data_state <= C_init_data_state;
                is_pos_valid <= '0';
                
            end if;        
        end if;
    end process;
    
    
    POSITION_TRANSFORMATOR:
    process (clk_i)
    begin
        if rising_edge (clk_i) then
        
            if (is_pos_valid = '1') then
            
                x_pos <= F_transform(
                    A_amp,
                    cos_ch1,  -- cos from channel 1
                    B_amp,
                    cos_ch2   -- cos from channel 2
                    );
                    
                y_pos <= F_transform(
                    A_amp,
                    sin_ch1,  -- sin from channel 1
                    B_amp,
                    sin_ch2   -- sin from channel 2
                    );

                is_xy_valid <= '1';  
            
            else
                x_pos <= 0;
                y_pos <= 0;
                is_xy_valid <= '0';
                
            end if;        
        end if;
    end process;
    
    
    POSITION_VALIDATOR:
    process (clk_i)
    begin
        if rising_edge (clk_i) then
        
            if (is_xy_valid = '1') then
                    
                if (0 <= x_pos) and (x_pos <= 383) and (0 <= y_pos) and (y_pos <= 383) then 
                    x_pos_o <= x_pos;
                    y_pos_o <= y_pos;
                    is_pos_valid_o <= '1';
                else
                    x_pos_o <= 0;
                    y_pos_o <= 0;
                    is_pos_valid_o <= '0';
                end if;    
            
            else
                x_pos_o <= 0;
                y_pos_o <= 0;
                is_pos_valid_o <= '0';
                
            end if;        
        end if;
    end process;    

end Behavioral;
