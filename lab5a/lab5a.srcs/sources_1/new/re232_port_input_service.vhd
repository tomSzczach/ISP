----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2024 17:46:11
-- Design Name: 
-- Module Name: re232_port_input_service - Behavioral
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

entity rs232_port_input_service is

    Generic (   
                clk_freq : INTEGER := 100000000;    -- clock frequency in Hz (default: 100 MHz)
                trans_speed : INTEGER := 9600       -- transmission speed in bps in RXD_i (default: 9600 bps)
            );
                    
    Port (
            clk_i : in STD_LOGIC;
            rst_i : in STD_LOGIC;
            RXD_i : in STD_LOGIC;
            recv_ASCII_o : out STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
            recv_ASCII_enable_o : out STD_LOGIC := '0'
         );
       
end rs232_port_input_service;


architecture Behavioral of rs232_port_input_service is

    -- CONSTANTS
    constant bit_duration : INTEGER := clk_freq/trans_speed;    -- single bit duration time in number of clock cycles (default: 10416 cycles)
    constant SDU_length : INTEGER := 10;                        -- [start bit | 8-bit data | stop bit]
    constant bit_idx_start : INTEGER := 0;
    constant bit_idx_last_data : INTEGER := 8;                  -- SDU_length-2
    constant bit_idx_stop : INTEGER := 9;                       -- SDU_length-1
    
    -- TYPES
    type TRANSMISSION_STATE_ENUM is (NO_DATA, START, DATA, STOP);

    -- SIGNALS
    signal RXD_sync : STD_LOGIC := '0';
    
    signal SDU_reg : STD_LOGIC_VECTOR(SDU_length-1 downto 0) := (others => '0');
    
    signal transmission_state : TRANSMISSION_STATE_ENUM := NO_DATA;
    
    signal bit_duration_cnt : INTEGER range 1 to bit_duration;
    signal bit_idx_cnt : INTEGER range 0 to SDU_length-1;
        
begin

    RXD_SYNCHRONIZER:
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            RXD_sync <= RXD_i;
        end if;
    end process;
    
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
            
            if (RXD_sync = '0') and (transmission_state = NO_DATA) then 
                transmission_state <= START;
                
            end if;
        end if;
    end process;
    
    BIT_DURATION_COUNTER:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            bit_duration_cnt <= 1;
            
        elsif rising_edge(clk_i) then
        
            if (RXD_sync = '0') and (transmission_state = NO_DATA) then
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
            
                if (transmission_state = STOP) then
                    bit_idx_cnt <= 0;
                    
                elsif (transmission_state = START) or (transmission_state = DATA) then
                    bit_idx_cnt <= bit_idx_cnt + 1;
                    
                end if;
            end if;
        end if;
    end process;
    
    RECEIVED_DATA_TO_SDU_REGISTER_WRITER:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            SDU_reg <= (others => '0');

        elsif rising_edge(clk_i) then
        
            if (bit_duration_cnt = bit_duration/2) and (transmission_state /= NO_DATA) then
                SDU_reg(bit_idx_cnt) <= RXD_sync;
                
            end if;
        end if;
    end process;
    
    ASCII_DATA_FROM_SDU_REGISTER_TO_OUTPUT_SENDER:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            recv_ASCII_o <= (others => '0');
            recv_ASCII_enable_o <= '0';
            
        elsif rising_edge(clk_i) then
        
            if (bit_duration_cnt = bit_duration/2) and (transmission_state = STOP) then
                recv_ASCII_enable_o <= '1';
                recv_ASCII_o <= SDU_reg(8 downto 1);
                
            else
                recv_ASCII_enable_o <= '0';
                
            end if;
        end if;
    end process;

end Behavioral;
