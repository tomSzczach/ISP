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
--use IEEE.NUMERIC_STD.ALL;

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
    signal x : NATURAL;
    signal y : NATURAL;
    
    signal r : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal g : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal b : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    
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

begin

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
            col_idx_o => x,
            row_idx_o => y
        );
        
    driver:
    process (clk_i)
        variable cnt : natural range 0 to 100000000 := 0;
    begin
        if rising_edge (clk_i) then
        
            if cnt = 0 then
                if r = "1111" then
                    r <= "0000";
                    g <= "1111";
                elsif g = "1111" then
                    g <= "0000";
                    b <= "1111";
                elsif b = "1111" then
                    b <= "0000";
                    r <= "1111";
                else
                    r <= "1111";
                end if;
            end if;
            
            if cnt = 100000000 then
                cnt := 0;
            else
                cnt := cnt + 1;
            end if;
            
        end if;
    end process;
        
end Behavioral;
