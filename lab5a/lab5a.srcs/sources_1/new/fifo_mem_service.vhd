----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2024 21:07:55
-- Design Name: 
-- Module Name: fifo_mem_service - Behavioral
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

entity fifo_mem_service is

    Port (
            clk_i : in STD_LOGIC;
            rst_i : in STD_LOGIC;
            writing_to_buffer : in STD_LOGIC;
            data_to_write : in STD_LOGIC_VECTOR (7 downto 0);
            reading_from_buffer_enable : in STD_LOGIC;
            buffer_is_reading : out STD_LOGIC := '0';
            data_to_read : out STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
            is_overflow : out STD_LOGIC := '0'
         );
           
end fifo_mem_service;

architecture Behavioral of fifo_mem_service is

    -- CONSTANTS
    constant C_fifo_max_depth : INTEGER := 64;
    constant C_read_frame : INTEGER := 18;
    constant C_read_trigger_on_size : INTEGER := 18;
    constant C_read_trigger_on_value : STD_LOGIC_VECTOR(7 DOWNTO 0) := X"0D"; -- xOD = 13 = enter scan code
        
    -- TYPES
    subtype T_DATA_ITEMS_COUNTER is INTEGER range 0 to C_fifo_max_depth;
    
    type T_READ_STATE is (IDLE, PREPARING_TO_READ, READING);

    -- SIGNALS
    signal is_empty : STD_LOGIC := '1';
    signal is_full : STD_LOGIC := '0';
    
    signal read_enable : STD_LOGIC := '0';
    signal read_data_out : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    signal read_state : T_READ_STATE := IDLE;
    
    signal write_enable : STD_LOGIC := '0';
    signal write_data_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    
    signal data_items_cnt : T_DATA_ITEMS_COUNTER := 0;
    signal data_items_inc : STD_LOGIC := '0';
    signal data_items_dec : STD_LOGIC := '0';
    
    signal value_triggers_cnt : T_DATA_ITEMS_COUNTER := 0;
    signal value_triggers_inc : STD_LOGIC := '0';
    signal value_triggers_dec : STD_LOGIC := '0';

    -- COMPONENTS
    COMPONENT fifo_mem
      PORT (
        clk : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        rd_en : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        full : OUT STD_LOGIC;
        empty : OUT STD_LOGIC 
      );
    END COMPONENT;

begin

    data_buffer : fifo_mem
      PORT MAP (
        clk => clk_i,
        din => write_data_in,
        wr_en => write_enable,
        rd_en => read_enable,
        dout => read_data_out,
        full => is_full,
        empty => is_empty
      );


    --  memory is full? /\ new data arrived?  ->  set overflow signal
    --  memory is not full?  ->  reset overflow signal
    OVERFLOW_GUARD:
    process (clk_i, rst_i)
    begin
        if rst_i = '1' then
            is_overflow <= '0';
        
        elsif rising_edge(clk_i) then
            
            if is_full = '1' and writing_to_buffer = '1' then
                is_overflow <= '1';
            end if;
            
            if is_full = '0' then
                is_overflow <= '0';
            end if;
            
        end if;
    end process;

    --  new data arrived? /\ memory is not full?  ->  write the data /\ increment the number of data items in memory /\ (*)
    -- (*) value of arrived data is 13 (= enter has pressed)?  ->  increment the number of value triggers
    DATA_WRITER:
    process (clk_i, rst_i)
    begin
        if rst_i = '1' then
            write_enable <= '0';
            write_data_in <= (others => '0');
            
        elsif rising_edge(clk_i) then
            write_enable <= '0';
            data_items_inc <= '0';
            value_triggers_inc <= '0';
            
            if writing_to_buffer = '1' and is_full = '0' then
                write_enable <= '1';
                write_data_in <= data_to_write;
                data_items_inc <= '1';
                
                if data_to_write = C_read_trigger_on_value then
                    value_triggers_inc <= '1';
                end if;
            end if;
        end if;
    end process;
    
    ---- Read Latency (From Rising Edge of Read Clock): 1 
    -- read_state is IDLE)? /\ buffer is allowed to read /\ [are unhandled value triggers? \/ size trigger?]  ->  set read_state to PREPARING_TO_READ
    -- read_state is PREPARING_TO_READ? /\ read_enable is '0'?  ->  set read_enable to '1'
    -- read_state is PREPARING_TO_READ? /\ read latency time passed?  ->  set read_state to READING 
    -- read_state is READING?  ->  read item
    -- read_state is READING? /\ has read item with value C_read_trigger_on_value?  ->  read item /\ set read_enable to '0' /\ set read_state to IDLE 
    -- read_state is READING? /\ has read C_read_frame items?  ->  read item /\ set read_enable to '0' /\ set read_state to IDLE 
    DATA_READER:
    process (clk_i, rst_i)
        variable read_items_cnt : INTEGER range 0 to C_read_frame := 0;
    begin
        if rst_i = '1' then
            read_items_cnt := 0;
            read_enable <= '0';
            read_state <= IDLE;
            buffer_is_reading <= '0';
            
        elsif rising_edge(clk_i) then
            data_items_dec <= '0';
            value_triggers_dec <= '0';
        
            case read_state is
            
                when IDLE =>
                    buffer_is_reading <= '0';
                    
                    if reading_from_buffer_enable = '1' then
                    
                        if value_triggers_cnt > 0 or data_items_cnt >= C_read_trigger_on_size then
                            read_state <= PREPARING_TO_READ;
                            
                        end if;
                    end if;
                    
                when PREPARING_TO_READ =>
                    read_enable <= '1';
                    -- read latency = 1 clock period
                    read_state <= READING;
                    
                when READING =>
                    buffer_is_reading <= '1';
                    data_to_read <= read_data_out;
                    data_items_dec <= '0';
                    read_items_cnt := read_items_cnt + 1;
                    
                    if read_data_out = C_read_trigger_on_value then
                        value_triggers_dec <= '1';
                        
                    end if;
                    
                    if (read_data_out = C_read_trigger_on_value) or (read_items_cnt = C_read_frame) then
                        read_enable <= '0';
                        read_items_cnt := 0;
                        read_state <= IDLE;
                        
                    end if;
                    
            end case;
        end if;
    end process;
    
    -- data item has written to memory?  ->  increment number of data items 'data_items_cnt'
    -- data item has read to memory?  ->  decrement number of data items 'data_items_cnt'
    DATA_ITEMS_COUNTER:
    process (clk_i, rst_i)
    begin
        if rst_i = '1' then
            data_items_cnt <= 0;
            
        elsif rising_edge(clk_i) then
            
            if data_items_inc = '1' then
                data_items_cnt <= data_items_cnt + 1;
            end if;
            
            if data_items_dec = '1' then
                data_items_cnt <= data_items_cnt - 1;
            end if;
        
        end if;
    end process;
    
    -- data of value 'C_read_trigger_on_value' has written to memory?  ->  increment number of value triggers in memory 'value_triggers_cnt'
    -- data of value 'C_read_trigger_on_value' has read to memory?  ->  decrement number of value triggers in memory 'value_triggers_cnt'
    VALUE_TRIGGERS_COUNTER:
    process (clk_i, rst_i)
    begin
        if rst_i = '1' then
            value_triggers_cnt <= 0;
            
        elsif rising_edge(clk_i) then
            
            if value_triggers_inc = '1' then
                value_triggers_cnt <= value_triggers_cnt + 1;
            end if;
            
            if value_triggers_dec = '1' then
                value_triggers_cnt <= value_triggers_cnt - 1;
            end if;
        
        end if;
    end process;
    

end Behavioral;
