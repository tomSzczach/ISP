----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2024 18:27:49
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
    Port ( sw_i : in STD_LOGIC_VECTOR (7 downto 0);
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0) := "0111";
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is
     signal parity_check_result : STD_LOGIC := '0';
begin

    parity_checker: process(sw_i) is
        variable partial_result : STD_LOGIC;
    begin
        partial_result := '0';
        for i in 0 to 7 loop
            partial_result := partial_result xor sw_i(i);
        end loop;
        parity_check_result <= partial_result;
    end process parity_checker;

    answer_encoder: process(parity_check_result) is
    begin
        case parity_check_result is
            when '0' => led7_seg_o <= "01100001";  -- E
            when '1' => led7_seg_o <= "00000011";  -- O
            when others => led7_seg_o <= "11111101";  -- -
        end case;
    end process answer_encoder;

end Behavioral;
