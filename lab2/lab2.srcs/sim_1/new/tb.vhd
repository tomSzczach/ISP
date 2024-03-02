----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.03.2024 02:19:27
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
           led_o : out STD_LOGIC_VECTOR (2 downto 0));
end component top;

component bounce is
    Port ( in_i : in STD_LOGIC;
           out_o : out STD_LOGIC);
end component bounce;


signal clk_i : STD_LOGIC := '0';
signal rst_i : STD_LOGIC := '0';
signal led_o : STD_LOGIC_VECTOR (2 downto 0);

signal clk_dirty : STD_LOGIC;
signal rst_dirty : STD_LOGIC;

begin

bounce_clk_model: bounce port map (
    in_i => clk_i,
    out_o => clk_dirty);

bounce_rst_model: bounce port map (
    in_i => rst_i,
    out_o => rst_dirty);

dut: top port map (
    clk_i => clk_dirty,
    rst_i => rst_dirty,
    led_o => led_o);

clk_i <= not clk_i after 50 ms; -- 10 Hz

rst_sim: process
    begin
        wait for 100 ms;
        rst_i <= '1';
        wait for 100 ms;
        rst_i <= '0';
        
        wait for 400 ms;
        rst_i <= '1';
        wait for 100 ms;
        rst_i <= '0';
        
        wait;
    end process;

end Behavioral;
