----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2024 01:56:54
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

    -- COMPONENTS
    component top is
        Port ( clk_i : in STD_LOGIC;
               rst_i : in STD_LOGIC;
               RXD_i : in STD_LOGIC;
               led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
               led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
    end component top;
    
    -- CONSTANTS
    constant bit_time_duration : time := 104us; -- 104 us ~ 1/9600 s
    constant SDU_length : integer := 10;
    constant RXD_data : STD_LOGIC_VECTOR (0 to SDU_length-1) := "0110010101";
    
    -- SIGNALS
    signal clk_i : STD_LOGIC := '0';
    signal rst_i : STD_LOGIC := '0';
    signal RXD_i : STD_LOGIC := '1';
    signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
    signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);

begin

    dut: top port map (
        clk_i => clk_i,
        rst_i => rst_i,
        RXD_i => RXD_i,
        led7_an_o => led7_an_o,
        led7_seg_o => led7_seg_o);
               
    clk_i <= not clk_i after 5 ns; -- T = 10 ns | f = 100 MHz
    
    sim_RXD: process
    begin
    
        rst_i <= '1';
        wait for 1 ms;
        rst_i <= '0';
        
        -- t * 100%
        for i in 0 to SDU_length-1 loop
            RXD_i <= RXD_data(i);
            wait for bit_time_duration;
        end loop;
        
        wait for 4 ms;
        
        -- t * 96%
        for i in 0 to SDU_length-1 loop
            RXD_i <= RXD_data(i);
            wait for bit_time_duration * 0.96;
        end loop;
        
        wait for 4 ms;
        
        -- t * 104%
        for i in 0 to SDU_length-1 loop
            RXD_i <= RXD_data(i);
            wait for bit_time_duration * 1.04;
        end loop;
        
        wait;
    end process;

end Behavioral;
