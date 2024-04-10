----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2024 15:34:56
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
           RXD_i : in STD_LOGIC;
           TXD_o : out STD_LOGIC;
           ld0 : out STD_LOGIC;
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
    end component top;
    
    -- SIGNALS
    signal clk_i : STD_LOGIC := '0';
    signal RXD_i : STD_LOGIC := '1';
    signal TXD_o : STD_LOGIC;
    signal ld0 : STD_LOGIC;
    signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
    signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);
    
    -- CONSTANTS
    constant bit_time_duration : time := 104us; -- 104 us ~ 1/9600 s
    constant SDU_length : integer := 10;
    
    constant RXD_data_F : STD_LOGIC_VECTOR (0 to SDU_length-1) := "0011000101"; -- F = 70 = x46 = 0100 0110 => 0 0110 0010 1
    constant RXD_data_O : STD_LOGIC_VECTOR (0 to SDU_length-1) := "0111100101"; -- O = 79 = x4F = 0100 1111 => 0 1111 0010 1
    constant RXD_data_enter : STD_LOGIC_VECTOR (0 to SDU_length-1) := "0101100001"; -- <enter> = 13 = x0D = 0000 1101 => 0 1011 0000 1
begin

    dut: top port map (
        clk_i => clk_i,
        RXD_i => RXD_i,
        TXD_o => TXD_o,
        ld0 => ld0,
        led7_an_o => led7_an_o,
        led7_seg_o => led7_seg_o);
    
    -- clock simulation
    clk_i <= not clk_i after 5 ns; -- T = 10 ns | f = 100 MHz
    
    -- RXD simulation
    sim_RXD: process
    begin
        wait for 100ns;
        
--        -- F
--        for i in 0 to SDU_length-1 loop
--            RXD_i <= RXD_data_F(i);
--            wait for bit_time_duration;
--        end loop;
                
--        -- O
--        for i in 0 to SDU_length-1 loop
--            RXD_i <= RXD_data_O(i);
--            wait for bit_time_duration;
--        end loop;
                
        -- <enter>
        for i in 0 to SDU_length-1 loop
            RXD_i <= RXD_data_enter(i);
            wait for bit_time_duration;
        end loop;
                
        wait;
    end process;
    

end Behavioral;
