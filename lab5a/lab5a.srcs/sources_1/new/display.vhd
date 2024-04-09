----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2024 17:46:11
-- Design Name: 
-- Module Name: display - Behavioral
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

entity display is

    Generic (   
                clk_freq : INTEGER := 100000000; -- clock frequency in Hz (default: 100 MHz)
                work_freq : INTEGER := 1000      -- working frequency in Hz of the display component (default: 1 kHz)
            );
            
    Port ( 
            clk_i : in STD_LOGIC;                                        -- 100 MHz
            rst_i : in STD_LOGIC;                                        -- async reset on '1' => switch on all segments
            hex_value_i : in STD_LOGIC_VECTOR (15 downto 0);             -- (15-12) -> AN3(7-1), (11-8) -> AN2(7-1), (7-4) -> AN1(7-1),(3-0) -> AN0(7-1)
            dots_i : in STD_LOGIC_VECTOR (3 downto 0);                   -- (3) -> AN3(0), (2) -> AN2(0), (1) -> AN1(0), (0) -> AN0(0)
            enabling_flags_i : in STD_LOGIC_VECTOR (3 downto 0);         -- if(3) -> AN3 is ON, if(2) -> AN2 is ON, if(1) -> AN1 is ON, if(0) -> AN0 is ON
            led7_an_o : out STD_LOGIC_VECTOR (3 downto 0) := "0000";     -- AN3(3), AN2(2), AN1(1), AN0(0)
            led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0) := "00000000" -- u(7), ur(6), dr(5), d(4), dl(3), ur(2), m(1), dot(0)
         );
         
end display;

architecture Behavioral of display is

    -- TYPES
    type LED_enumerator is (AN3, AN2, AN1, AN0, ALL_LEDS, NO_LEDS);
    
    -- FUNCTIONS
    function seven_seg
    (
        data_in: STD_LOGIC_VECTOR(3 downto 0);
        enable_flag: STD_LOGIC
    )
    return STD_LOGIC_VECTOR
    is
        variable tmp : STD_LOGIC_VECTOR(6 downto 0);
    begin
        if (enable_flag = '1') then
            case data_in is 
               when "0000" => tmp := "1111110";   -- 0
               when "0001" => tmp := "0110000";   -- 1
               when "0010" => tmp := "1101101";   -- 2
               when "0011" => tmp := "1111001";   -- 3
               when "0100" => tmp := "0110011";   -- 4
               when "0101" => tmp := "1011011";   -- 5
               when "0110" => tmp := "1011111";   -- 6
               when "0111" => tmp := "1110000";   -- 7
               when "1000" => tmp := "1111111";   -- 8
               when "1001" => tmp := "1111011";   -- 9
               when "1010" => tmp := "1110111";   -- A
               when "1011" => tmp := "0011111";   -- b
               when "1100" => tmp := "1001110";   -- C
               when "1101" => tmp := "0111101";   -- d
               when "1110" => tmp := "1001111";   -- E
               when "1111" => tmp := "1000111";   -- F
               when others => tmp := "0000001";   -- -
            end case;
        else
            tmp := "0000000";
        end if;
        return (tmp);
    end function seven_seg;
    
    
    function set_digit
    (
        state: LED_enumerator
    )
    return STD_LOGIC_VECTOR
    is
        variable led7_an : STD_LOGIC_VECTOR(3 downto 0);
    begin
        case state is
           when AN3 => led7_an := "1000";
           when AN2 => led7_an := "0100";
           when AN1 => led7_an := "0010";
           when AN0 => led7_an := "0001";
           when ALL_LEDS => led7_an := "1111";
           when NO_LEDS => led7_an := "0000";
           when others => led7_an := "0000";
        end case;
        return (led7_an);
    end function set_digit;
    
    
    function set_value
    (
        state: LED_enumerator;
        hex_value: STD_LOGIC_VECTOR(15 downto 0);
        dots : STD_LOGIC_VECTOR (3 downto 0);  
        enabling_flags : STD_LOGIC_VECTOR (3 downto 0)
    )
    return STD_LOGIC_VECTOR
    is
        variable led7_seg : STD_LOGIC_VECTOR(7 downto 0);
    begin
        case state is
           when AN3 => led7_seg := seven_seg(hex_value(15 downto 12), enabling_flags(3)) & dots(3);
           when AN2 => led7_seg := seven_seg(hex_value(11 downto 8), enabling_flags(2)) & dots(2);
           when AN1 => led7_seg := seven_seg(hex_value(7 downto 4), enabling_flags(1)) & dots(1);
           when AN0 => led7_seg := seven_seg(hex_value(3 downto 0), enabling_flags(0)) & dots(0);
           when ALL_LEDS => led7_seg := "11111111";
           when NO_LEDS => led7_seg := "00000000";
           when others => led7_seg := "00000000";
        end case;
        return (led7_seg);
    end function set_value;
    
    
    -- SIGNALS
    signal current_LED : LED_enumerator := NO_LEDS;
    signal clk_freq_div_cnt : INTEGER := 0;
    signal work_freq_clk_enable : STD_LOGIC := '0';
    
begin

    -- manage the multiplexing frequency ( default is 1 kHz = period 1 ms)
    CLOCK_FREQUENCY_DIVIDER:
    process (clk_i, rst_i)
    begin
        if rst_i = '1' then
            clk_freq_div_cnt <= 0;
        elsif rising_edge(clk_i) then
            if (clk_freq_div_cnt = clk_freq/work_freq) then
                clk_freq_div_cnt <= 0;
                work_freq_clk_enable <= '1';
            else
                clk_freq_div_cnt <= clk_freq_div_cnt + 1;
                work_freq_clk_enable <= '0';
            end if;
        end if;
    end process;
    
    -- switch state of 'led7_an_o'
    DIGIT_SWITCH:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            current_LED <= ALL_LEDS;
        elsif rising_edge(clk_i) and work_freq_clk_enable = '1' then
            case current_LED is
                when AN3 => current_LED <= AN2;
                when AN2 => current_LED <= AN1;
                when AN1 => current_LED <= AN0;
                when AN0 => current_LED <= AN3;
                when others => current_LED <= AN3;
            end case;
        end if;
    end process;
    
    -- set data output for 'led7_an_o' and 'led7_seg_o' based on 'current_LED'
    OUTPUT_DATA_SETTER:
    process(current_LED) 
    begin
        led7_an_o <= not set_digit(current_LED);
        led7_seg_o <= not set_value(current_LED, hex_value_i, dots_i, enabling_flags_i);
    end process;

end Behavioral;
