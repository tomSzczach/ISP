----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2024 01:04:55
-- Design Name: 
-- Module Name: VGA_controller - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_controller is

    Generic (   
                clk_freq :      NATURAL := 100000000;   -- clock frequency in Hz (default: 100 MHz)
                pixel_freq :    NATURAL :=  25000000    -- pixel frequency in Hz (default: 25 MHz)
            );
            
    Port ( 
            clk_i : in STD_LOGIC;
            r_i : in STD_LOGIC_VECTOR (3 downto 0);
            g_i : in STD_LOGIC_VECTOR (3 downto 0);
            b_i : in STD_LOGIC_VECTOR (3 downto 0);
            r_o : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
            g_o : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
            b_o : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
            hsync_o : out STD_LOGIC := '1';
            vsync_o : out STD_LOGIC := '1';
            col_idx_o : out NATURAL := 0;
            row_idx_o : out NATURAL := 0
         );
         
end VGA_controller;

architecture Behavioral of VGA_controller is

    -- TYPES --
    type H_STATE is (
                        H_BACK_PORCH,
                        H_SCREEN_DATA,
                        H_FRONT_PORCH,
                        H_SYNC
                    );
    type V_STATE is (
                        V_BACK_PORCH,
                        V_SCREEN_DATA,
                        V_FRONT_PORCH,
                        V_SYNC
                    );
                    

    -- CONSTANTS --
    
    -- default: 100MHz/25MHz = 4 clk_i cycles
    constant C_pixel_duration : NATURAL := clk_freq/pixel_freq; -- [clock cycles]  
    
    constant C_h_back_porch_duration : NATURAL :=    48; -- [C_pixel_duration]
    constant C_h_screen_data_duration : NATURAL :=  640; -- [C_pixel_duration]
    constant C_h_front_porch_duration : NATURAL :=   16; -- [C_pixel_duration]
    constant C_h_sync_duration : NATURAL :=          96; -- [C_pixel_duration]
    
    -- each line takes (48+640+16+96) = 800 pixel clock cycles
    constant C_line_duration : NATURAL :=           800 * C_pixel_duration; -- [clock cycles]  
    
    constant C_v_back_porch_duration : NATURAL :=    33; -- [C_line_duration]
    constant C_v_screen_data_duration : NATURAL :=  480; -- [C_line_duration]
    constant C_v_front_porch_duration : NATURAL :=   10; -- [C_line_duration]
    constant C_v_sync_duration : NATURAL :=           2; -- [C_line_duration]
    
    -- each screen takes (33+480+10+2) = 525 lines = 525*800 pixel clock cycles = 420 000 pixel clock cycles
    --constant C_screen_duration : NATURAL :=         525; -- [C_line_duration]
    
    constant C_cnt_rst : NATURAL := 1;
    constant C_h_init_state : H_STATE := H_BACK_PORCH;
    constant C_v_init_state : V_STATE := V_SYNC;


    -- SIGNALS --    
    signal h : H_STATE := C_h_init_state;
    signal v : V_STATE := C_v_init_state;
    
    signal h_cnt : NATURAL := C_cnt_rst;
    signal v_cnt : NATURAL := C_cnt_rst;
    
    signal pixel_clk : STD_LOGIC := '0';
    signal line_clk : STD_LOGIC := '0';

begin

    SCREEN_DATA_HANDLER:
    process (clk_i)
    begin
        if rising_edge (clk_i) then
            
            if (h = H_SCREEN_DATA) and (v = V_SCREEN_DATA) then
                col_idx_o <= h_cnt;
                row_idx_o <= v_cnt;
                r_o <= r_i;
                g_o <= g_i;
                b_o <= b_i;
                
            else
                col_idx_o <= 0;
                row_idx_o <= 0;
                r_o <= "0000";
                g_o <= "0000";
                b_o <= "0000";
            
            end if;
        end if;
    end process;
    

    H_SYNC_HANDLER:
    process (clk_i)
    begin
        if rising_edge (clk_i) then
            
            if (h = H_SYNC) then
                hsync_o <= '0';
                
            else
                hsync_o <= '1';
            
            end if;
        end if;
    end process;
    
    
    V_SYNC_HANDLER:
    process (clk_i)
    begin
        if rising_edge (clk_i) then
            
            if (v = V_SYNC) then
                vsync_o <= '0';
                
            else
                vsync_o <= '1';
            
            end if;
        end if;
    end process;

    PIXEL_FREQ_CLOCK:
    process (clk_i)
        variable cnt : NATURAL range 0 to C_pixel_duration-1 := C_pixel_duration-1;
    begin
        if rising_edge (clk_i) then
        
            if (cnt = 0) then
                pixel_clk <= '1';
                cnt := C_pixel_duration-1;
                
            else
                pixel_clk <= '0';
                cnt := cnt - 1;
                
            end if;
        end if;
    end process;
    
    
    LINE_FREQ_CLOCK:
    process (clk_i)
        variable cnt : NATURAL range 0 to C_line_duration-1 := C_line_duration-1;
    begin
        if rising_edge (clk_i) then
        
            if (cnt = 0) then
                line_clk <= '1';
                cnt := C_line_duration-1;
                
            else
                line_clk <= '0';
                cnt := cnt - 1;
                
            end if;
        end if;
    end process;


    H_STATE_MACHINE:
    process (clk_i)
    begin
        if rising_edge (clk_i) then
        
            if (pixel_clk = '1') then
            
                case h is
                
                    when H_BACK_PORCH =>
                        if (h_cnt = C_h_back_porch_duration) then
                            h <= H_SCREEN_DATA;
                            h_cnt <= C_cnt_rst;
                        else
                            h_cnt <= h_cnt + 1;
                        end if;
                    
                    when H_SCREEN_DATA =>
                        if (h_cnt = C_h_screen_data_duration) then
                            h <= H_FRONT_PORCH;
                            h_cnt <= C_cnt_rst;
                        else
                            h_cnt <= h_cnt + 1;
                        end if;
                    
                    when H_FRONT_PORCH =>
                        if (h_cnt = C_h_front_porch_duration) then
                            h <= H_SYNC;
                            h_cnt <= C_cnt_rst;
                        else
                            h_cnt <= h_cnt + 1;
                        end if;
                    
                    when H_SYNC =>
                        if (h_cnt = C_h_sync_duration) then
                            h <= H_BACK_PORCH;
                            h_cnt <= C_cnt_rst;
                        else
                            h_cnt <= h_cnt + 1;
                        end if;
                    
                end case;
            end if;
        end if;
    end process;
    
    
    V_STATE_MACHINE:
    process (clk_i)
    begin
        if rising_edge (clk_i) then
        
            if (line_clk = '1') then
            
                case v is
                    
                    when V_BACK_PORCH =>
                        if (v_cnt = C_v_back_porch_duration) then
                            v <= V_SCREEN_DATA;
                            v_cnt <= C_cnt_rst;
                        else
                            v_cnt <= v_cnt + 1;
                        end if;
                    
                    when V_SCREEN_DATA =>
                        if (v_cnt = C_v_screen_data_duration) then
                            v <= V_FRONT_PORCH;
                            v_cnt <= C_cnt_rst;
                        else
                            v_cnt <= v_cnt + 1;
                        end if;
                    
                    when V_FRONT_PORCH =>
                        if (v_cnt = C_v_front_porch_duration) then
                            v <= V_SYNC;
                            v_cnt <= C_cnt_rst;
                        else
                            v_cnt <= v_cnt + 1;
                        end if;
                    
                    when V_SYNC =>
                        if (v_cnt = C_v_sync_duration) then
                            v <= V_BACK_PORCH;
                            v_cnt <= C_cnt_rst;
                        else
                            v_cnt <= v_cnt + 1;
                        end if;
                     
                end case;
            end if;
        end if;
    end process;

end Behavioral;
