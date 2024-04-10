----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.04.2024 03:04:17
-- Design Name: 
-- Module Name: rs232_port_output_service - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rs232_port_output_service is

    Generic (   
                clk_freq : INTEGER := 100000000;    -- clock frequency in Hz (default: 100 MHz)
                trans_speed : INTEGER := 9600       -- transmission speed in bps in RXD_i (default: 9600 bps)
            );
            
    Port ( 
            clk_i : in STD_LOGIC;
            rst_i : in STD_LOGIC;
            TXD_o : out STD_LOGIC := '1';
            send_ASCII_i : in STD_LOGIC_VECTOR (7 downto 0);
            send_ASCII_request_i : in STD_LOGIC;
            send_ASCII_enable_o : out STD_LOGIC := '1'
         );
         
end rs232_port_output_service;


architecture Behavioral of rs232_port_output_service is

    -- CONSTANTS
    constant bit_duration : INTEGER := clk_freq/trans_speed;    -- single bit duration time in number of clock cycles (default: 10416 cycles)
    constant SDU_length : INTEGER := 10;                        -- [start bit | 8-bit data | stop bit]
    constant bit_idx_start : INTEGER := 0;
    constant bit_idx_last_data : INTEGER := 8;                  -- SDU_length-2
    constant bit_idx_stop : INTEGER := 9;                       -- SDU_length-1
    
    constant TXD_signal_idle : STD_LOGIC := '1';                -- if no data is transmitting, should be high state in TxD
    
    -- TYPES
    type TRANSMISSION_STATE_ENUM is (NO_DATA, START, DATA, STOP);
    
    -- SIGNALS
    signal transmission_state : TRANSMISSION_STATE_ENUM := NO_DATA;
    
    signal bit_duration_cnt : INTEGER range 1 to bit_duration;
    signal bit_idx_cnt : INTEGER range 0 to SDU_length-1;
    
    signal testoutput : CHARACTER;
    
    signal SDU_reg : STD_LOGIC_VECTOR(0 to SDU_length-1) := (others => '0');

begin

    TRANSMISSION_STATE_CONTROLLER:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            transmission_state <= NO_DATA;
            
        elsif rising_edge(clk_i) then
                
            if (bit_duration_cnt = bit_duration) then
            
                if (transmission_state = START) and (bit_idx_cnt = bit_idx_start) then
                    transmission_state <= DATA;
                    
                elsif (transmission_state = DATA) and (bit_idx_cnt = bit_idx_last_data) then 
                    transmission_state <= STOP;
                    
                elsif (transmission_state = STOP) and (bit_idx_cnt = bit_idx_stop) then 
                    transmission_state <= NO_DATA;
                    
                end if;
            end if;
            
            if (send_ASCII_request_i = '1') and (transmission_state = NO_DATA) then 
                transmission_state <= START;
                testoutput <= CHARACTER'VAL(TO_INTEGER(UNSIGNED(send_ASCII_i)));
                
            end if;
        end if;
    end process;
    
    SENDING_ENABLE_CONTROLLER:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            send_ASCII_enable_o <= '1';
            
        elsif rising_edge(clk_i) then
                
            if (send_ASCII_request_i = '0') and (transmission_state = NO_DATA) then
                send_ASCII_enable_o <= '1';
                
            else 
                send_ASCII_enable_o <= '0';

            end if;
        end if;
    end process;
    
    BIT_DURATION_COUNTER:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            bit_duration_cnt <= 1;
            
        elsif rising_edge(clk_i) then
        
            if (transmission_state = NO_DATA) then
                bit_duration_cnt <= 1;
                
            elsif (bit_duration_cnt = bit_duration) then
                bit_duration_cnt <= 1;
                
            else
                bit_duration_cnt <= bit_duration_cnt + 1;
                
            end if;
        end if;
    end process;
    
    BIT_INDEX_COUNTER:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            bit_idx_cnt <= 0;
            
        elsif rising_edge(clk_i) then
            
            if (bit_duration_cnt = bit_duration) then
            
                if (transmission_state = START) or (transmission_state = DATA) then
                    bit_idx_cnt <= bit_idx_cnt + 1;
                    
                else
                    bit_idx_cnt <= 0;
                    
                end if;
            end if;
        end if;
    end process;
    
    SDU_REG_SETTER:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            SDU_reg <= (others => '0');
        
        elsif rising_edge(clk_i) then
        
            if (send_ASCII_request_i = '1') then
                SDU_reg <= (
                            '0',                -- start bit
                            send_ASCII_i(0),    
                            send_ASCII_i(1),
                            send_ASCII_i(2),
                            send_ASCII_i(3),
                            send_ASCII_i(4),
                            send_ASCII_i(5),
                            send_ASCII_i(6),
                            send_ASCII_i(7),
                            '1'                 -- stop bit
                       );
                       
            end if;
        end if;
    end process;
    
    SDU_TRANSMITTER:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            TXD_o <= TXD_signal_idle;
            
        elsif rising_edge(clk_i) then
                
            if (transmission_state = NO_DATA) then
                TXD_o <= TXD_signal_idle;
                
            else 
                TXD_o <= SDU_reg(bit_idx_cnt);

            end if;
        end if;
    end process;

end Behavioral;
