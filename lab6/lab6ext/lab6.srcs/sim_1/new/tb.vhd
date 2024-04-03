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

    -- COMPONENTS
    component top is
        Port ( clk_i : in STD_LOGIC;
               rst_i : in STD_LOGIC;
               button_i : in STD_LOGIC_VECTOR (3 downto 0);
               led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
               led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
    end component top;

    -- SIGNALS
    signal clk_i,rst_i: STD_LOGIC := '0';
    signal button_i :  STD_LOGIC_VECTOR (3 downto 0):= "0000";
    signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
    signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);

    -- PROCEDURES
    procedure test_value_incrementation
    (
        signal button_i : out STD_LOGIC_VECTOR (3 downto 0)
    ) is
    begin
        button_i <= "0010";
        wait for 1 ms;
        button_i <= "0000";
        wait for 1 ms;
    end procedure;
    
    procedure test_value_decrementation
    (
        signal button_i : out STD_LOGIC_VECTOR (3 downto 0)
    ) is
    begin
        button_i <= "0001";
        wait for 1 ms;
        button_i <= "0000";
        wait for 1 ms;
    end procedure;
    
    procedure test_shift_focus_to_the_right
    (
        signal button_i : out STD_LOGIC_VECTOR (3 downto 0)
    ) is
    begin
        button_i <= "0100";
        wait for 1 ms;
        button_i <= "0000";
        wait for 1 ms;
    end procedure;
    
    procedure test_shift_focus_to_the_left
    (
        signal button_i : out STD_LOGIC_VECTOR (3 downto 0)
    ) is
    begin
        button_i <= "1000";
        wait for 1 ms;
        button_i <= "0000";
        wait for 1 ms;
    end procedure;
    
    procedure test_mode_switching
    (
        signal button_i : out STD_LOGIC_VECTOR (3 downto 0)
    ) is
    begin
        button_i <= "1000";
        wait for 2 ms;
        button_i <= "0000";
        wait for 1 ms;
    end procedure;
    
    procedure test_reset
    (
        signal rst_i : out STD_LOGIC
    ) is
    begin
        rst_i <= '1';
        wait for 20 ns;
        rst_i <= '0';
        wait for 100 ns;
    end procedure;

begin

   uut: top port map (
   clk_i => clk_i,
   rst_i => rst_i,
   led7_an_o => led7_an_o,
   led7_seg_o => led7_seg_o,
   button_i => button_i);

    -- 100MHz CLOCK SMULATION
    clk_i <= not clk_i after 5 ns;

    -- TEST
    stim: process
    begin
        
        test_reset (rst_i);                         -- reset                0000
        test_value_incrementation (button_i);       -- ++                   0000
        test_shift_focus_to_the_left (button_i);    -- <<                   0000
        test_mode_switching (button_i);             -- set edit mode        0000    AN1 is blinking
        test_value_incrementation (button_i);       -- ++                   0010    AN1 is blinking               
        test_value_incrementation (button_i);       -- ++                   0020    AN1 is blinking 
        test_shift_focus_to_the_left (button_i);    -- <<                   0020    AN2 is blinking 
        test_value_decrementation (button_i);       -- --                   0f20    AN2 is blinking
        test_shift_focus_to_the_right (button_i);   -- >>                   0f20    AN1 is blinking 
        test_value_incrementation (button_i);       -- ++                   0f30    AN1 is blinking 
        test_mode_switching (button_i);             -- set display mode     0f30    AN2 is blinking by short time
        test_value_decrementation (button_i);       -- --                   0f30
        
        wait;
           
     end process;
end Behavioral;
