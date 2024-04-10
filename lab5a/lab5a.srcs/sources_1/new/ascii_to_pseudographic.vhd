----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.04.2024 20:58:57
-- Design Name: 
-- Module Name: ascii_to_pseudographic - Behavioral
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
use IEEE.std_logic_arith.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ascii_to_pseudographic is

    Port (
            clk_i : in STD_LOGIC;
            data_from_buffer_i : in STD_LOGIC_VECTOR (7 downto 0);
            is_buffer_empty_i : in STD_LOGIC;
            send_enable_i : in STD_LOGIC;
            send_request_o : out STD_LOGIC := '0';
            data_to_send_o : out STD_LOGIC_VECTOR (7 downto 0);
            read_from_buffer_enable_o : out STD_LOGIC := '0'        
         );
         
end ascii_to_pseudographic;

architecture Behavioral of ascii_to_pseudographic is

    -- TYPES
    subtype T_ASCII is STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    type T_PRINT_FRAME is array (NATURAL range <>) of T_ASCII;
    type T_STATE is (
                        IDLE,
                        PREPARING_TO_READ,
                        READING,
                        PREPARING_ITERS,
                        GETTING_ITEM_ROW,
                        SENDING_ITEM_ROW_ELEMENT,
                        SENDING_CR,
                        SENDING_LF,
                        UPDATING_ITERS
                    );
    
    -- CONSTANTS
    constant ASCII_CR : T_ASCII := X"0D";       -- xOD = 13 = carriage return
    constant ASCII_LF : T_ASCII := X"0A";       -- xOA = 10 = line feed
    constant ASCII_space : T_ASCII := X"20";    -- x20 = 32 = space
    constant ASCII_asterisk : T_ASCII := X"2A"; -- x2A = 42 = *
    
    constant C_print_trigger_on_value : STD_LOGIC_VECTOR(7 DOWNTO 0) := ASCII_CR;
    
    constant C_print_frame_maxsize : INTEGER := 18; 
    constant C_font_cols_number : INTEGER := 8; 
    constant C_font_rows_number : INTEGER := 16;

    -- FUNCTIONS
    function set_print_sign
    (
        font_bit: STD_LOGIC;
        ascii_code: T_ASCII
    )
    return T_ASCII
    is
        variable data_to_send : STD_LOGIC_VECTOR(7 DOWNTO 0);
    begin
        if (font_bit = '0') then
            data_to_send := ASCII_space;
        else
            if (ascii_code < X"20") or (ascii_code > X"7F") then   -- ascii_code < 32 || 127 < ascii_code
                data_to_send := ASCII_asterisk;
            else
                data_to_send := ascii_code;
            end if;
        end if;
        return (data_to_send);
    end function set_print_sign;
    
    
    -- SIGNALS    
    signal print_frame : T_PRINT_FRAME (0 to C_print_frame_maxsize-1) := (others => (others => '0'));
    signal print_frame_size : INTEGER range 0 to C_print_frame_maxsize := 0;
    
    signal address : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
    signal pseudographic_font_row : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

    signal state : T_STATE := IDLE;
    
    signal item_iter : INTEGER range 0 to C_print_frame_maxsize-1;
    signal row_iter : INTEGER range 0 to C_font_rows_number-1;
    signal col_iter : INTEGER range 0 to C_font_cols_number-1;
    
    -- < temporal workaround >
    signal is_empty_row_enter : STD_LOGIC := '0';
    signal empty_row_cnt : INTEGER := 0;
    -- </ temporal workaround >

    
    -- COMPONENTS
    COMPONENT char_mem
      PORT (
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
      );
    END COMPONENT;

begin
    
    font_lib : char_mem
    PORT MAP (
        clka => clk_i,
        addra => address,
        douta => pseudographic_font_row
    );
    
    -- PROCESSES
    CONVERTER:
    process (clk_i)
--        variable item_iter : INTEGER range 0 to C_print_frame_maxsize-1;
--        variable row_iter : INTEGER range 0 to C_font_rows_number-1;
--        variable col_iter : INTEGER range 0 to C_font_cols_number-1;
        variable is_send_request : STD_LOGIC := '0';

        variable read_fifo_latency_cnt : INTEGER := 0;
        variable read_rom_latency_cnt : INTEGER := 0;
        
    begin
        if rising_edge(clk_i) then
            
            case state is
            
                when IDLE =>                    
                    if (is_buffer_empty_i = '0') then
                        state <= PREPARING_TO_READ;
                    end if;
                    
                    
                when PREPARING_TO_READ =>
                    read_from_buffer_enable_o <= '1';
                    
                    if (read_fifo_latency_cnt = 1) then
                        state <= READING;   -- read latency = 1 clock cycle
                        read_fifo_latency_cnt := 0;
                    else 
                        read_fifo_latency_cnt := read_fifo_latency_cnt + 1;
                    end if;
                    
                    
                when READING =>
                    if (data_from_buffer_i = C_print_trigger_on_value) then     -- read data has value of 13 (enter)
                        read_from_buffer_enable_o <= '0';
                        
                        -- < temporal workaround >
                        if (print_frame_size = 0) then
                            is_empty_row_enter <= '1';
                            empty_row_cnt <= 0;
                            is_send_request := '0';
                            send_request_o <= '0';
                            state <= SENDING_CR;
                        else
                        -- </ temporal workaround >
                            state <= PREPARING_ITERS;
                        end if;
                        
                    else
                        print_frame(print_frame_size) <= data_from_buffer_i;
                        print_frame_size <= print_frame_size + 1;
                        
                        if (print_frame_size = C_print_frame_maxsize-1) then      -- already has read C_print_frame_maxsize(=18) items
                            read_from_buffer_enable_o <= '0';
                            state <= PREPARING_ITERS;
                            
                        elsif (is_buffer_empty_i = '1') then
                            read_from_buffer_enable_o <= '0';
                            state <= IDLE;
                            
                        end if;
                    end if;


                when PREPARING_ITERS =>
                    item_iter <= 0;
                    row_iter <= 0;
                    col_iter <= 0;
                    state <= GETTING_ITEM_ROW;
                    

                when GETTING_ITEM_ROW =>
                    address <= print_frame(item_iter) & conv_std_logic_vector(row_iter, 4);
                    
                    if (read_rom_latency_cnt = 1) then
                        state <= SENDING_ITEM_ROW_ELEMENT;   -- read latency = 1 clock cycle
                        read_rom_latency_cnt := 0;
                    else 
                        read_rom_latency_cnt := read_rom_latency_cnt + 1;
                    end if;
                    

                when SENDING_ITEM_ROW_ELEMENT =>
                    if (is_send_request = '0') and (send_enable_i = '1') then
                        send_request_o <= '1';
                        data_to_send_o <= set_print_sign( pseudographic_font_row((C_font_cols_number-1)-col_iter), print_frame(item_iter) );
                        is_send_request := '1';
                        
                    elsif (is_send_request = '1') then
                        is_send_request := '0';
                        send_request_o <= '0';
                        
                        if (col_iter = C_font_cols_number-1) and (item_iter = print_frame_size-1) then
                            state <= SENDING_CR;
                        else
                            state <= UPDATING_ITERS;
                            
                        end if; 
                    end if;
                    
                    
                when SENDING_CR =>
                    if (is_send_request = '0') and (send_enable_i = '1') then
                        send_request_o <= '1';
                        data_to_send_o <= ASCII_CR;
                        is_send_request := '1';
                        
                    elsif (is_send_request = '1') then
                        is_send_request := '0';
                        send_request_o <= '0';
                        state <= SENDING_LF;

                    end if;
                    
                    
                when SENDING_LF =>
                    if (is_send_request = '0') and (send_enable_i = '1') then
                        send_request_o <= '1';
                        data_to_send_o <= ASCII_LF;
                        is_send_request := '1';
                        
                    elsif (is_send_request = '1') then
                        is_send_request := '0';
                        send_request_o <= '0';
                        
                        -- < temporal workaround >
                        if (is_empty_row_enter = '1') then
                            if (empty_row_cnt = C_font_rows_number-1) then
                                is_empty_row_enter <= '0';
                                empty_row_cnt <= 0;
                                state <= IDLE;
                                
                            else
                                empty_row_cnt <= empty_row_cnt + 1;
                                state <= SENDING_CR;
                                
                            end if;
                        else
                        -- </ temporal workaround >
                            state <= UPDATING_ITERS;
                        
                        end if;
                    end if;
                    
                    
                when UPDATING_ITERS =>
                    if (row_iter = C_font_rows_number-1) and (item_iter = print_frame_size-1) and (col_iter = C_font_cols_number-1) then
                        row_iter <= 0;
                        item_iter <= 0;
                        col_iter <= 0;
                        print_frame_size <= 0;
                        state <= IDLE;
                        
                    else    --  row item col
                        if (item_iter = print_frame_size-1) and (col_iter = C_font_cols_number-1) then
                            row_iter <= (row_iter + 1) mod C_font_rows_number; 
                        end if;
                        
                        if (col_iter = C_font_cols_number-1) then
                            item_iter <= (item_iter + 1) mod print_frame_size; 
                        end if;
                        
                        col_iter <= (col_iter + 1) mod C_font_cols_number;
                        
                        state <= GETTING_ITEM_ROW;
                        
                    end if;
            end case;
        end if;
    end process;


end Behavioral;
-- if (print_frame_iter = print_frame_size-1) then -> IDLE