----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2024 18:19:25
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is

    Port (
            clk_i : in STD_LOGIC;
            sw_i : in STD_LOGIC_VECTOR (7 downto 0);
            btn_i : in STD_LOGIC_VECTOR (3 downto 0);
            red_o : out STD_LOGIC_VECTOR (3 downto 0);
            green_o : out STD_LOGIC_VECTOR (3 downto 0);
            blue_o : out STD_LOGIC_VECTOR (3 downto 0);
            hsync_o : out STD_LOGIC;
            vsync_o : out STD_LOGIC
         );
         
end top;

architecture Behavioral of top is

    -- SIGNALS --
    signal col_idx : NATURAL;
    signal row_idx : NATURAL;
    
    signal r : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal g : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal b : STD_LOGIC_VECTOR (3 downto 0) := "0000";
        
    signal read_address : STD_LOGIC_VECTOR (17 downto 0) := (others => '0');
    signal read_data : STD_LOGIC_VECTOR (0 downto 0) := "0";
    
    signal write_enable : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal write_address : STD_LOGIC_VECTOR (17 downto 0) := (others => '0');
    signal write_data : STD_LOGIC_VECTOR (0 downto 0) := "0";
    
    signal x_freq : STD_LOGIC_VECTOR (7 downto 0) := "0000000";
    signal y_freq : STD_LOGIC_VECTOR (7 downto 0) := "0000000";
    signal x_offset : STD_LOGIC_VECTOR (7 downto 0) := "0000000";
    signal y_offset : STD_LOGIC_VECTOR (7 downto 0) := "0000000";
    
    signal screen_rst : STD_LOGIC := '0';
    signal singen_rst : STD_LOGIC := '0';
    
    signal data_ch1 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
    signal data_ch2 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
    signal data_valid : STD_LOGIC := '0';
    
    -- COMPONENTS --
    COMPONENT VGA_controller
        Port ( 
                clk_i : in STD_LOGIC;
                r_i : in STD_LOGIC_VECTOR (3 downto 0);
                g_i : in STD_LOGIC_VECTOR (3 downto 0);
                b_i : in STD_LOGIC_VECTOR (3 downto 0);
                r_o : out STD_LOGIC_VECTOR (3 downto 0);
                g_o : out STD_LOGIC_VECTOR (3 downto 0);
                b_o : out STD_LOGIC_VECTOR (3 downto 0);
                hsync_o : out STD_LOGIC;
                vsync_o : out STD_LOGIC;
                col_idx_o : out NATURAL;
                row_idx_o : out NATURAL
             );
    END COMPONENT;
    
    COMPONENT video_mem
        Port (
                clka : IN STD_LOGIC;
                wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
                addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
                dina : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
                clkb : IN STD_LOGIC;
                addrb : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
                doutb : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
             );
    END COMPONENT;
    
    COMPONENT VGA_driver
        Port ( 
                clk_i : in STD_LOGIC;
                x_i : in NATURAL;
                y_i : in NATURAL;
                read_data_i : in STD_LOGIC_VECTOR (0 downto 0);
                read_address_o : out STD_LOGIC_VECTOR (17 downto 0);
                r_o : out STD_LOGIC_VECTOR (3 downto 0);
                g_o : out STD_LOGIC_VECTOR (3 downto 0);
                b_o : out STD_LOGIC_VECTOR (3 downto 0)
             );
    END COMPONENT;
    
    COMPONENT input_handler
        Port ( 
                clk_i : in STD_LOGIC;
                sw_i : in STD_LOGIC_VECTOR (7 downto 0);
                btn_i : in STD_LOGIC_VECTOR (3 downto 0);
                screen_rst_o : out STD_LOGIC;
                singen_rst_o : out STD_LOGIC;
                x_freq_o : out STD_LOGIC_VECTOR (7 downto 0);
                y_freq_o : out STD_LOGIC_VECTOR (7 downto 0);
                x_offset_o : out STD_LOGIC_VECTOR (7 downto 0);
                y_offset_o : out STD_LOGIC_VECTOR (7 downto 0)
             );
    END COMPONENT;
    
    COMPONENT lissajous_generator
        Port ( 
                clk_i : in STD_LOGIC;
                singen_rst_i : in STD_LOGIC;
                x_freq_i : in STD_LOGIC_VECTOR (7 downto 0);
                y_freq_i : in STD_LOGIC_VECTOR (7 downto 0);
                x_offset_i : in STD_LOGIC_VECTOR (7 downto 0);
                y_offset_i : in STD_LOGIC_VECTOR (7 downto 0);
                data_ch1_o : out STD_LOGIC_VECTOR(10 DOWNTO 0);
                data_ch2_o : out STD_LOGIC_VECTOR(10 DOWNTO 0);
                data_valid_o : out STD_LOGIC
             );
    END COMPONENT;

begin

    memory : video_mem
        PORT MAP (
            clka => clk_i,
            wea => write_enable,
            addra => write_address,
            dina => write_data,
            clkb => clk_i,
            addrb => read_address,
            doutb => read_data
        );

    controller : VGA_controller
        PORT MAP (
            clk_i => clk_i,
            r_i => r,
            g_i => g,
            b_i => b,
            r_o => red_o,
            g_o => green_o,
            b_o => blue_o,
            hsync_o => hsync_o,
            vsync_o => vsync_o,
            col_idx_o => col_idx,
            row_idx_o => row_idx
        );
        
    driver : VGA_driver
        PORT MAP (
            clk_i => clk_i,
            x_i => col_idx,
            y_i => row_idx,
            read_data_i => read_data,
            read_address_o => read_address,
            r_o => r,
            g_o => g,
            b_o => b
        );
        
    input: input_handler
        PORT MAP (
            clk_i => clk_i,
            sw_i => sw_i,
            btn_i => btn_i,
            screen_rst_o => screen_rst,
            singen_rst_o => singen_rst,
            x_freq_o => x_freq,
            y_freq_o => y_freq,
            x_offset_o => x_offset,
            y_offset_o => y_offset
        );
        
    generator: lissajous_generator
        PORT MAP ( 
            clk_i => clk_i,
            singen_rst_i => singen_rst,
            x_freq_i => x_freq,
            y_freq_i => y_freq,
            x_offset_i => x_offset,
            y_offset_i => y_offset,
            data_ch1_o => data_ch1,
            data_ch2_o => data_ch2,
            data_valid_o => data_valid
         );
         
    
    
    
    
    filler:
    process (clk_i)
        variable addr : natural range 0 to 147455 := 0;
    begin
        if rising_edge (clk_i) then
            write_enable <= "1";
            write_address <= STD_LOGIC_VECTOR( TO_UNSIGNED( addr, write_address'length));
            write_data <= "1";
            
            if addr = 147455 then
                addr := 0;
            else
                addr := addr + 1;
                
            end if;
        end if;
    end process;
    
--    driver_rgb_fullscreen:
--    process (clk_i)
--        variable cnt : natural range 0 to 100000000 := 0;
--    begin
--        if rising_edge (clk_i) then
        
--            if cnt = 0 then
--                if r = "1111" then
--                    r <= "0000";
--                    g <= "1111";
--                elsif g = "1111" then
--                    g <= "0000";
--                    b <= "1111";
--                elsif b = "1111" then
--                    b <= "0000";
--                    r <= "1111";
--                else
--                    r <= "1111";
--                end if;
--            end if;
            
--            if cnt = 100000000 then
--                cnt := 0;
--            else
--                cnt := cnt + 1;
--            end if;
            
--        end if;
--    end process;
        
end Behavioral;
