----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2024 14:45:04
-- Design Name: 
-- Module Name: input_handler - Behavioral
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

entity input_handler is

    Port ( 
            clk_i : in STD_LOGIC;
            sw_i : in STD_LOGIC_VECTOR (7 downto 0);
            btn_i : in STD_LOGIC_VECTOR (3 downto 0);
            screen_rst_o : out STD_LOGIC := '0';
            singen_rst_o : out STD_LOGIC := '0';
            x_freq_o : out STD_LOGIC_VECTOR (7 downto 0) := "0000000";
            y_freq_o : out STD_LOGIC_VECTOR (7 downto 0) := "0000000";
            x_offset_o : out STD_LOGIC_VECTOR (7 downto 0) := "0000000";
            y_offset_o : out STD_LOGIC_VECTOR (7 downto 0) := "0000000"
         );
         
end input_handler;

architecture Behavioral of input_handler is
    
    -- TYPES
    type uint_vector is array (NATURAL range <>) of NATURAL;
    
    -- CONSTANTS
    constant C_btn_delay : NATURAL := 100000;  -- delay to stabilize buttons signal, 1ms in clock cycles (100MHz)
    constant C_btn_num : NATURAL := 4;
    
    ---- BTNL ->AN3 (3) , BTNC ->AN2 (2) , BTNR ->AN1 (1) , BTND ->AN0 (0)
    constant C_btn_BTNL : NATURAL := 3;
    constant C_btn_BTNC : NATURAL := 2;
    constant C_btn_BTNR : NATURAL := 1;
    constant C_btn_BTND : NATURAL := 0;

    -- SIGNALS    
    signal btns_fetched : STD_LOGIC_VECTOR(3 downto 0)  := "0000";
    signal btns_stable : STD_LOGIC_VECTOR(3 downto 0)   := "0000";

begin

    BUTTONS_STABILIZER:
    process (clk_i) is
        variable delays_cntr : uint_vector (C_btn_num-1 to 0) := (0, 0, 0, 0);
    begin
        if rising_edge(clk_i) then
        
            btns_fetched <= btn_i;
            
            for i in 0 to C_btn_num-1 loop
            
                if (btns_fetched(i) = btns_stable(i)) then
                    delays_cntr(i) := 0;
                else
                    delays_cntr(i) := delays_cntr(i) + 1;
                end if;
                
                if (delays_cntr(i) = C_btn_delay) then
                    btns_stable(i) <= btns_fetched(i);
                    delays_cntr(i) := 0;
                end if;
                
            end loop;
            
        end if;
    end process;
    
    
    RESET_HANDLER:
    process (clk_i) is
    begin
        if rising_edge(clk_i) then
        
            if (btns_stable(C_btn_BTND) = '1') then -- button BTND
                screen_rst_o <= '1';    -- clear screen
                singen_rst_o <= '1';    -- reset DDS generator
            
            else
                screen_rst_o <= '0';
                singen_rst_o <= '0';

            end if;
        end if;
    end process;
    
    
    X_FREQUENCY_HANDLER:
    process (clk_i) is
    begin
        if rising_edge(clk_i) then
        
            if (btns_stable(C_btn_BTNL) = '1') then -- button BTNL
                x_freq_o <= sw_i;   -- set frequency of X channel
            
            end if;
        end if;
    end process;


    Y_FREQUENCY_HANDLER:
    process (clk_i) is
    begin
        if rising_edge(clk_i) then
        
            if (btns_stable(C_btn_BTNC) = '1') then -- button BTNC
                y_freq_o <= sw_i;   -- set frequency of Y channel
            
            end if;
        end if;
    end process;
    
    
    Y_OFFSET_HANDLER:
    process (clk_i) is
    begin
        if rising_edge(clk_i) then
        
            if (btns_stable(C_btn_BTNR) = '1') then -- button BTNR
                y_offset_o <= sw_i;   -- set offset of Y channel
            
            end if;
        end if;
    end process;

end Behavioral;