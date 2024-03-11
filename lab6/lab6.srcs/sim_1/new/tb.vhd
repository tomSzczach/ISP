----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2024 20:22:16
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

component top is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           button_i : in STD_LOGIC;
           led: out STD_LOGIC_VECTOR (15 downto 0));
           --led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           --led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
           --- button_i : in STD_LOGIC_VECTOR (3 downto 0);
end component top;

signal clk_i,rst_i,button_i: STD_LOGIC := '0';
--signal button_i :  STD_LOGIC_VECTOR (3 downto 0);
signal led: STD_LOGIC_VECTOR (15 downto 0);

begin
   uut: top port map (
   clk_i => clk_i,
   rst_i => rst_i,
   led => led,
   button_i => button_i);

clk_i <= not clk_i after 5 ns;

    stim: process
    begin
        rst_i <= '1';
        wait for 20 ns;
        rst_i <= '0';
    
        loop
            wait for 100 ns;
            button_i <= '1';
            wait for 100 ns;
            button_i <= '0';
        end loop;      
     end process;
end Behavioral;
