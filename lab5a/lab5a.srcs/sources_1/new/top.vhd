----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2024 02:22:04
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
           RXD_i : in STD_LOGIC;
           TXD_o : out STD_LOGIC;
           ld0 : out STD_LOGIC;
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

    -- SIGNALS
    signal rst_off : STD_LOGIC := '0';
    signal recv_ASCII : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal recv_ASCII_enable : STD_LOGIC := '0';
    signal display_hex_value : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    
    -- COMPONENTS
    COMPONENT rs232_port_input_service
      PORT ( 
        clk_i : IN STD_LOGIC;
        rst_i : IN STD_LOGIC;
        RXD_i : IN STD_LOGIC;
        recv_ASCII_o : OUT STD_LOGIC_VECTOR (7 downto 0);
        recv_ASCII_enable_o : OUT STD_LOGIC
      );
    END COMPONENT;
    
    COMPONENT display
      PORT ( 
        clk_i : in STD_LOGIC;                               
        rst_i : in STD_LOGIC;                               
        hex_value_i : in STD_LOGIC_VECTOR (15 downto 0);   
        dots_i : in STD_LOGIC_VECTOR (3 downto 0);         
        enabling_flags_i : in STD_LOGIC_VECTOR (3 downto 0);  
        led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);      
        led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)  
      );
    END COMPONENT;

begin

    input_service : rs232_port_input_service
      PORT MAP (
        clk_i => clk_i,
        rst_i => rst_off,
        RXD_i => RXD_i,
        recv_ASCII_o => recv_ASCII,
        recv_ASCII_enable_o => recv_ASCII_enable
      );
      
    display_service : display
      PORT MAP (
        clk_i => clk_i,                             
        rst_i => rst_off,                               
        hex_value_i => display_hex_value,  
        dots_i => "0000",        
        enabling_flags_i => "0011", 
        led7_an_o => led7_an_o,     
        led7_seg_o => led7_seg_o 
      );


end Behavioral;
