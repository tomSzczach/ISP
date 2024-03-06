----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2024 02:22:38
-- Design Name: 
-- Module Name: encoder_and_memory - Behavioral
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

entity encoder_and_memory is
    Port ( clk_i : in STD_LOGIC; -- 100 MHz
           btn_i : in STD_LOGIC_VECTOR (3 downto 0); -- BTNL ->AN3 (3) , BTNC ->AN2 (2) , BTNR ->AN1 (1) , BTND ->AN0 (0)
           sw_i : in STD_LOGIC_VECTOR (7 downto 0); -- DP AN3 (7) , DP AN2 (6) , DP AN1 (5) , DP AN0 (4) , 4-bit value (3-0)
           digit_o : out STD_LOGIC_VECTOR (31 downto 0)); -- AN3(31-24), AN2(23-16), AN1(15-8), AN0(7-0)
end encoder_and_memory;

architecture Behavioral of encoder_and_memory is
    -- TYPES
    type int_vector is array (0 to 3) of integer;

    -- CONSTANTS
    constant btn_delay_const : integer := 100000;  -- opóŸnienie syg. stabilnego w cyklach zegara (1ms)
    constant num_of_digits : integer := 4;
    
    -- FUNCTIONS
    function seven_seg(data_in: std_logic_vector(3 downto 0)) return std_logic_vector is
        variable tmp : std_logic_vector(6 downto 0);
    begin
        case data_in is 
           when "0000" => tmp := "0000001";   -- 0
           when "0001" => tmp := "1001111";   -- 1
           when "0010" => tmp := "0010010";   -- 2
           when "0011" => tmp := "0000110";   -- 3
           when "0100" => tmp := "1001100";   -- 4
           when "0101" => tmp := "0100100";   -- 5
           when "0110" => tmp := "0100000";   -- 6
           when "0111" => tmp := "0001111";   -- 7
           when "1000" => tmp := "0000000";   -- 8
           when "1001" => tmp := "0000100";   -- 9
           when "1010" => tmp := "0001000";   -- A
           when "1011" => tmp := "1100000";   -- b
           when "1100" => tmp := "0110001";   -- C
           when "1101" => tmp := "1000010";   -- d
           when "1110" => tmp := "0110000";   -- E
           when "1111" => tmp := "0111000";   -- F
           when others => tmp := "1111110";   -- -
        end case;
        return (tmp);
    end function seven_seg;

    -- SIGNALS
    signal digit : std_logic_vector(3 downto 0);
    
    signal btns_fetched : std_logic_vector(3 downto 0);
    signal btns_new : std_logic_vector(3 downto 0);
    signal btns_current : std_logic_vector(3 downto 0); -- stabilny sygna³ przycisku (out)
begin
    
    ---- dwa przerzutniki synchronizuj¹ce + uk³ad likwidacji drgañ zestyków
    sync_btns: process (clk_i) is
        variable delays_cntr : int_vector := (0, 0, 0, 0);
    begin
        if rising_edge(clk_i) then
            btns_fetched <= btn_i;
            btns_new <= btns_fetched;
            
            for i in 0 to num_of_digits-1 loop
                if (btns_new(i) = btns_current(i)) then
                    delays_cntr(i) := 0;
                else
                    delays_cntr(i) := delays_cntr(i) + 1;
                end if;
            end loop;
            
            for i in 0 to num_of_digits-1 loop
                if (delays_cntr(i) = btn_delay_const) then
                    btns_current(i) <= btns_new(i);
                    delays_cntr(i) := 0;
                end if;
            end loop;
        end if;
    end process;
    
    -- save current digit
    digit <= sw_i(3 downto 0);
    
    -- set digit
    loop_digits_and_set_value_if_needed: process(btns_current) is
    begin
        if (btns_current(0) = '1') then -- set digit at AN0
            digit_o(7 downto 1) <= seven_seg(digit);
        end if;
        if (btns_current(1) = '1') then -- set digit at AN1
            digit_o(15 downto 9) <= seven_seg(digit);
        end if;
        if (btns_current(2) = '1') then -- set digit at AN2
            digit_o(23 downto 17) <= seven_seg(digit);
        end if;
        if (btns_current(3) = '1') then -- set digit at AN3      
            digit_o(31 downto 25) <= seven_seg(digit);
        end if;
    end process;
    
    -- set dot
    digit_o(24) <= sw_i(7); -- at AN3 
    digit_o(16) <= sw_i(6); -- at AN2
    digit_o(8) <= sw_i(5); -- at AN1 
    digit_o(0) <= sw_i(4); -- at AN0 

end Behavioral;
