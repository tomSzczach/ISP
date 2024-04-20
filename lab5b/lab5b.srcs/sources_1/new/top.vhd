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
    Port ( clk_i : in STD_LOGIC;
           sw_i : in STD_LOGIC_VECTOR (7 downto 0);
           btn_i : in STD_LOGIC_VECTOR (3 downto 0);
           red_o : out STD_LOGIC;
           green_o : out STD_LOGIC;
           blue_o : out STD_LOGIC;
           hsync_o : out STD_LOGIC;
           vsync_o : out STD_LOGIC);
end top;

architecture Behavioral of top is

begin


end Behavioral;
