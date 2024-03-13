----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2024 23:19:08
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

entity rs232_port_monitor is
    Generic (   clk_freq : integer := 100000000; 
                    -- clock frequency in Hz (default: 100 MHz)
                trans_speed : integer := 9600 );
                    -- transmission speed in bps in RXD_i (default: 9600 bps)
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           RXD_i : in STD_LOGIC;
           digit_o : out STD_LOGIC_VECTOR (31 downto 0)
       );
end rs232_port_monitor;

architecture Behavioral of rs232_port_monitor is

    -- CONSTANTS
    constant bit_duration : integer := clk_freq/trans_speed;
                -- single bit duration time in number of clock cycles (default: 10416 cycles)
    constant SDU_length : integer := 10;
                -- [start bit | 8-bit data | stop bit]
    constant start_bit_idx : integer := 0;
    constant last_data_bit_idx : integer := 8;
    constant stop_bit_idx : integer := 9;
    
    -- TYPES
    type RECV_STATE is (NO_DATA, START, DATA, STOP);
    
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
    signal RXD_sync_reg : STD_LOGIC := '0';
    signal RXD_sync : STD_LOGIC := '0';
    
    signal curr_recv_state : RECV_STATE := STOP;
    signal bit_time_cnt : integer range 1 to bit_duration;
    
    signal SDU_reg : STD_LOGIC_VECTOR(SDU_length-1 downto 0) := (others => '0');
    signal bit_cnt : integer range 0 to SDU_length-1;
    
    signal digit_reg : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    
begin

    RXD_synchronized_registered:
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            RXD_sync_reg <= RXD_i;
        end if;
    end process;
    
    RXD_synchronized:
    RXD_sync <= RXD_sync_reg;
    
    state_detector:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            curr_recv_state <= NO_DATA;
            
        elsif rising_edge(clk_i) then
                
            if (bit_time_cnt = bit_duration) then
                if (curr_recv_state = START) and (bit_cnt = start_bit_idx) then
                    curr_recv_state <= DATA;
                elsif (curr_recv_state = DATA) and (bit_cnt = last_data_bit_idx) then
                    curr_recv_state <= STOP;
                elsif (curr_recv_state = STOP) and (bit_cnt = stop_bit_idx) then
                    curr_recv_state <= NO_DATA;
                end if;
            end if;
            
            if (RXD_sync = '0') and (curr_recv_state = NO_DATA) then
                curr_recv_state <= START;
            end if;
            
        end if;
    end process;
    
    bit_timer:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            bit_time_cnt <= 1;
            
        elsif rising_edge(clk_i) then
        
            if (bit_time_cnt = bit_duration) then
                bit_time_cnt <= 1;
            else
                bit_time_cnt <= bit_time_cnt + 1;
            end if;
            
        end if;
    end process;
    
    bit_counter:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            bit_cnt <= 0;
            
        elsif rising_edge(clk_i) then
            
            if (bit_time_cnt = bit_duration) then
                if (curr_recv_state = STOP) then
                    bit_cnt <= 0;
                elsif (curr_recv_state = START) or (curr_recv_state = DATA) then
                    bit_cnt <= bit_cnt + 1;
                end if;
            end if;
            
        end if;
    end process;
    
    recv_data_to_SDU_reg_writer:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            SDU_reg <= (others => '0');

        elsif rising_edge(clk_i) then
            if (bit_time_cnt = bit_duration/2) and (curr_recv_state /= NO_DATA) then
                SDU_reg(bit_cnt) <= RXD_sync;
            end if;
            
        end if;
    end process;
    
    SDU_reg_ASCII_data_to_digit_reg_writer:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            digit_reg <= (others => '0');
            
        elsif rising_edge(clk_i) then
            if (bit_time_cnt = bit_duration/2) and (curr_recv_state = STOP) then
                digit_reg(15 downto 9) <= seven_seg(SDU_reg(8 downto 5));
                digit_reg(7 downto 1) <= seven_seg(SDU_reg(4 downto 1));
            end if;
        
        end if;
    end process;
    
    send_digit_to_output:
    digit_o <= digit_reg;

end Behavioral;
