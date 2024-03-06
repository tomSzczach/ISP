----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2024 00:52:08
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
    Generic ( clk_div_factor : integer := 100000 ); -- division factor of the system clock frequency
    Port ( clk_i : in STD_LOGIC; -- 100 MHz
           rst_i : in STD_LOGIC; -- async reset on '1' => switch on all segments
           digit_i : in STD_LOGIC_VECTOR (31 downto 0); -- AN3(31-24), AN2(23-16), AN1(15-8), AN0(7-0)
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0); -- AN3(3), AN2(2), AN1(1), AN0(0)
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)); -- u(7), ur(6), dr(5), d(4), dl(3), ur(2), m(1), dot(0)
end display;

architecture Behavioral of display is
    -- TYPES
    type LED_enumerator is (AN3, AN2, AN1, AN0, ALL_LEDS, NO_LEDS);
    
    -- FUNCTIONS
    function set_digit(state: LED_enumerator) return std_logic_vector is
        variable led7_an : std_logic_vector(3 downto 0);
    begin
        case state is 
           when AN3 => led7_an := "0111";
           when AN2 => led7_an := "1011";
           when AN1 => led7_an := "1101";
           when AN0 => led7_an := "1110";
           when ALL_LEDS => led7_an := "0000";
           when NO_LEDS => led7_an := "1111";
           when others => led7_an := "1111";
        end case;
        return (led7_an);
    end function set_digit;
    
    function set_value(state: LED_enumerator; data: std_logic_vector(31 downto 0)) return std_logic_vector is
        variable led7_seg : std_logic_vector(7 downto 0);
    begin
        case state is 
           when AN3 => led7_seg := data(31 downto 24);
           when AN2 => led7_seg := data(23 downto 16);
           when AN1 => led7_seg := data(15 downto 8);
           when AN0 => led7_seg := data(7 downto 0);
           when ALL_LEDS => led7_seg := "00000000";
           when NO_LEDS => led7_seg := "11111111";
           when others => led7_seg := "11111111";
        end case;
        return (led7_seg);
    end function set_value;
    
    -- SIGNALS
    signal current_LED : LED_enumerator := NO_LEDS;
    signal mux_clk : STD_LOGIC := '0';
    signal clk_freq_div_cnt : integer := 0;
    
begin

    -- manage the multiplexing frequency ( default is 1 kHz = period 1 ms)
    clk_freq_divider: process (clk_i, rst_i) is
    begin
        if rst_i = '1' then
            clk_freq_div_cnt <= 0;
        elsif rising_edge(clk_i) then
            clk_freq_div_cnt <= clk_freq_div_cnt + 1;
            
            if (clk_freq_div_cnt = clk_div_factor - 1) then
                clk_freq_div_cnt <= 0;
                mux_clk <= '0';
            end if;
            if (clk_freq_div_cnt = clk_div_factor/2 - 1) then
                mux_clk <= '1';
            end if;
        end if;
    end process clk_freq_divider;
    

    -- switch state of 'led7_an_o'
    digit_switch: process(mux_clk, rst_i) is
    begin
        if rst_i = '1' then
            current_LED <= ALL_LEDS;
        elsif mux_clk = '1' then
            case current_LED is
                when AN3 => current_LED <= AN2;
                when AN2 => current_LED <= AN1;
                when AN1 => current_LED <= AN0;
                when AN0 => current_LED <= AN3;
                when others => current_LED <= AN3;
            end case;
        end if;
    end process digit_switch;
    
    -- set data output for 'led7_an_o' and 'led7_seg_o' based on 'current_LED'
    output_data_setter: process(current_LED) is 
    begin
        led7_an_o <= set_digit(current_LED);
        led7_seg_o <= set_value(current_LED, digit_i);
    end process output_data_setter;


end Behavioral;
