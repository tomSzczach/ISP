----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2024 20:08:38
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
           rst_i : in STD_LOGIC;
           button_i : in STD_LOGIC_VECTOR (3 downto 0);          
           --button_i : in STD_LOGIC;          
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is
    
    -- TYPES
    type int_vector is array (Natural range <>) of integer;
    
    -- CONSTANTS
    constant btn_delay_const : integer := 20000;
        -- op�nienie (0.2ms) syg. stabilnego liczone w cyklach zegara (100MHz)
    constant mode_change_time_const : integer := 150000;                    -- current value is for testing purposes
        -- czas trwania wci�ni�cia BTNL (1.5ms), aby zmieni� tryb prac          -- change before release on production       
    constant focused_digit_blink_period_const : integer := 100000;          -- current value is for testing purposes
        -- okres migania (1ms) cyfry, kt�ra jest sfokusowana                    -- change before release on production 
    constant edit_mode : std_logic := '1';    
    

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
    
    -- COMPONENTS
    component kcpsm6 
        generic(                 hwbuild : std_logic_vector(7 downto 0) := X"00";
                        interrupt_vector : std_logic_vector(11 downto 0) := X"3FF";
                 scratch_pad_memory_size : integer := 64);
        port (                   address : out std_logic_vector(11 downto 0);
                             instruction : in std_logic_vector(17 downto 0);
                             bram_enable : out std_logic;
                                 in_port : in std_logic_vector(7 downto 0);
                                out_port : out std_logic_vector(7 downto 0);
                                 port_id : out std_logic_vector(7 downto 0);
                            write_strobe : out std_logic;
                          k_write_strobe : out std_logic;
                             read_strobe : out std_logic;
                               interrupt : in std_logic;
                           interrupt_ack : out std_logic;
                                   sleep : in std_logic;
                                   reset : in std_logic;
                                     clk : in std_logic);
    end component;
  
    component program_ext                             
        generic(             C_FAMILY : string := "S6"; 
                    C_RAM_SIZE_KWORDS : integer := 1;
                 C_JTAG_LOADER_ENABLE : integer := 0);
        Port (      address : in std_logic_vector(11 downto 0);
                instruction : out std_logic_vector(17 downto 0);
                     enable : in std_logic;
                        rdl : out std_logic;                    
                        clk : in std_logic);
    end component;
    
    component display is
        Port ( clk_i : in STD_LOGIC;
               rst_i : in STD_LOGIC;
               digit_i : in STD_LOGIC_VECTOR (31 downto 0);
               led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
               led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
           );
    end component display;
    
    -- SIGNALS
    signal digit_i : STD_LOGIC_VECTOR (31 downto 0) := (others => '1');
    
    signal button_sync_i : STD_LOGIC_VECTOR (button_i'range) := (others => '0');
    signal button_stable_i : STD_LOGIC_VECTOR (button_i'range) := (others => '0');
    
    signal working_mode : STD_LOGIC := '0';
    
    signal is_blink : STD_LOGIC := '0';
    signal focus_flags : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    
    signal AN0_val : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal AN1_val : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal AN2_val : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal AN3_val : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    
    --
    -- Signals for connection of KCPSM6 and Program Memory.
    --
    signal         address : std_logic_vector(11 downto 0);
    signal     instruction : std_logic_vector(17 downto 0);
    signal     bram_enable : std_logic;
    signal         in_port : std_logic_vector(7 downto 0);
    signal        out_port : std_logic_vector(7 downto 0);
    signal         port_id : std_logic_vector(7 downto 0);
    signal    write_strobe : std_logic;
    signal  k_write_strobe : std_logic;
    signal     read_strobe : std_logic;
    signal       interrupt : std_logic;
    signal   interrupt_ack : std_logic;
    signal    kcpsm6_sleep : std_logic;
    signal    kcpsm6_reset : std_logic;

    --
    -- Some additional signals are required if your system also needs to reset KCPSM6. 
    --
    signal       cpu_reset : std_logic;
    signal             rdl : std_logic; 
 
begin

    processor: kcpsm6
        generic map (                 hwbuild => X"00", 
                             interrupt_vector => X"7FF",
                      scratch_pad_memory_size => 64)
        port map(      address => address,
                   instruction => instruction,
                   bram_enable => bram_enable,
                       port_id => port_id,
                  write_strobe => write_strobe,
                k_write_strobe => open, --dla OUT
                      out_port => out_port,
                   read_strobe => open, --DLA urz�dze� IO
                       in_port => in_port,
                     interrupt => '0',
                 interrupt_ack => open,
                         sleep => '0',
                         reset => rst_i,
                           clk => clk_i);
                                         
    program_rom: program_ext                   --Name to match your PSM file
        generic map(             C_FAMILY => "7S",   --Family 'S6', 'V6' or '7S'
                        C_RAM_SIZE_KWORDS => 2,      --Program size '1', '2' or '4'
                     C_JTAG_LOADER_ENABLE => 0)      --Include JTAG Loader when set to '1' 
        port map(      address => address,      
                   instruction => instruction,
                        enable => bram_enable,
                           rdl =>  open,
                           clk => clk_i);                      
    
    comp_display: display port map(
        clk_i => clk_i,
        rst_i => rst_i,
        digit_i => digit_i,
        led7_an_o => led7_an_o,
        led7_seg_o => led7_seg_o
    );
    
    
    BUTTON_STABILIZER:
    process(clk_i, rst_i) is 
        variable delay_cntr : int_vector (button_i'range) := (others => 0);
    begin
        if rst_i = '1' then
            delay_cntr := (others => 0);
            button_sync_i <= (others => '0');
            button_stable_i <= (others => '0');
            
        elsif rising_edge (clk_i) then
            button_sync_i <= button_i;
            
            for i in button_i'range loop
                if (button_sync_i(i) = button_stable_i(i)) then
                    delay_cntr(i) := 0;
                else
                    delay_cntr(i) := delay_cntr(i) + 1;
                end if;
            end loop;
            
            for i in button_i'range loop
                if (delay_cntr(i) = btn_delay_const) then
                    button_stable_i(i) <= button_sync_i(i);
                    delay_cntr(i) := 0;
                end if;
            end loop;
        
        end if;
    end process;
    
    -- There are 2 working modes described by
    -- '0' = display mode
    -- '1' = edit mode
    -- Mode is change on button(3) press lasting 0.5s
    MODE_SWITCH:
    process(clk_i, rst_i) is
        variable press_cntr : INTEGER := 0;
    begin
        if rst_i = '1' then
            press_cntr := 0;
            working_mode <= '0';
        
        elsif rising_edge (clk_i) then
            
            if button_stable_i(3) = '1' then
                press_cntr := press_cntr + 1;                
            else
                press_cntr := 0;                
            end if;
            
            if press_cntr = mode_change_time_const then
                working_mode <= not working_mode;
                press_cntr := 0;
            end if;
            
        end if;
    end process;
    
    -- Switch on/off after every focused_digit_blink_period_const/2 time
    BLINKING_TIME_COUNTER:
    process(clk_i, rst_i)
        variable blink_cntr : INTEGER := 0;
    begin
        if rst_i = '1' then
            blink_cntr := 0;
            is_blink <= '0';
            
        elsif rising_edge (clk_i) then
        
            -- increment counter
            if blink_cntr = focused_digit_blink_period_const-1 then
                blink_cntr := 0;                
            else
                blink_cntr := blink_cntr + 1;                
            end if;
            
            -- toggle state
            if (blink_cntr = 0) or (blink_cntr = focused_digit_blink_period_const/2) then
                is_blink <= not is_blink;    
            end if;
        
        end if;
    end process;
    
    
    INPUT_PORTS:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            in_port <= (others => '0');
            
        elsif rising_edge (clk_i) then
            in_port <= ( 
                7 => working_mode,
                3 => button_stable_i(3),
                2 => button_stable_i(2), 
                1 => button_stable_i(1), 
                0 => button_stable_i(0),
                others => '0'
            );
            
        end if;
    end process input_ports;
    
  
    OUTPUT_PORTS:
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            digit_i <= (others => '1');
            AN0_val <= (others => '0');
            AN1_val <= (others => '0');
            AN2_val <= (others => '0');
            AN3_val <= (others => '0');
            focus_flags <= (others => '0');
            
        elsif rising_edge (clk_i) then

            -- 'write_strobe' is used to qualify all writes to general output ports.
            if write_strobe = '1' then
            
                -- Write to output_port_w at port address 01 hex
                if port_id(0) = '1' then
                    AN0_val <= out_port(3 downto 0);
                    
                    if working_mode = edit_mode and is_blink = '1' and focus_flags(0) = '1' then
                        digit_i(7 downto 1) <= (others => '1');
                    else 
                        digit_i(7 downto 1) <= seven_seg(AN0_val); -- AN0 (najbardziej po prawej)
                    end if;
    
                end if;
        
                -- Write to output_port_x at port address 02 hex
                if port_id(1) = '1' then  
                    AN1_val <= out_port(3 downto 0);      
                    
                    if working_mode = edit_mode and is_blink = '1' and focus_flags(1) = '1' then
                        digit_i(15 downto 9) <= (others => '1');
                    else    
                        digit_i(15 downto 9) <= seven_seg(AN1_val); -- AN1 (drugi od prawej)
                    end if;
                    
                end if;
        
                -- Write to output_port_y at port address 04 hex
                if port_id(2) = '1' then
                    AN2_val <= out_port(3 downto 0);
                    
                    if working_mode = edit_mode and is_blink = '1' and focus_flags(2) = '1' then
                        digit_i(23 downto 17) <= (others => '1');
                    else 
                        digit_i(23 downto 17) <= seven_seg(AN2_val); -- AN2 (drugi od levej)
                    end if;
                
                end if;
        
                -- Write to output_port_z at port address 08 hex
                if port_id(3) = '1' then
                    AN3_val <= out_port(3 downto 0);
                    
                    if working_mode = edit_mode and is_blink = '1' and focus_flags(3) = '1' then
                        digit_i(31 downto 25) <= (others => '1');
                    else 
                        digit_i(31 downto 25) <= seven_seg(AN3_val); -- AN3 (najbardziej po lewej)
                    end if;
               
                end if;
                
                -- Write to output_port at port address 16 hex
                if port_id(4) = '1' then
                    focus_flags <= out_port(3 downto 0);                    
                end if;
                              
            end if;
        end if; 
    end process output_ports;
    
end Behavioral;
