----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2024 19:35:55
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

     -- COMPONENTS --
    COMPONENT top IS
       PORT (
                clk_i : in STD_LOGIC;
                sw_i : in STD_LOGIC_VECTOR (7 downto 0);
                btn_i : in STD_LOGIC_VECTOR (3 downto 0);
                red_o : out STD_LOGIC_VECTOR (3 downto 0);
                green_o : out STD_LOGIC_VECTOR (3 downto 0);
                blue_o : out STD_LOGIC_VECTOR (3 downto 0);
                hsync_o : out STD_LOGIC;
                vsync_o : out STD_LOGIC
            );
    END COMPONENT top;
    
    -- SIGNALS --
    signal clk : STD_LOGIC := '0';
    signal sw : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal btn : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    
    signal red : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal green : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal blue : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    
    signal hsync : STD_LOGIC := '1';
    signal vsync : STD_LOGIC := '1';

begin

    dut: top port map (
        clk_i => clk,
        sw_i => sw,
        btn_i => btn,
        red_o => red,
        green_o => green,
        blue_o => blue,
        hsync_o => hsync,
        vsync_o => vsync
    );
    
    -- clock simulation
    clk <= not clk after 5 ns; -- T = 10 ns | f = 100 MHz

end Behavioral;
