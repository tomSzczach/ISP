----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2024 01:39:49
-- Design Name: 
-- Module Name: VGA_driver - Behavioral
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

entity VGA_driver is

    Port ( 
            clk_i : in STD_LOGIC;
            x_i : in NATURAL;
            y_i : in NATURAL;
            read_data_i : in STD_LOGIC_VECTOR (0 downto 0);
            read_address_o : out STD_LOGIC_VECTOR (17 downto 0) := (others => '0');
            r_o : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
            g_o : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
            b_o : out STD_LOGIC_VECTOR (3 downto 0) := "0000"
         );
         
end VGA_driver;

architecture Behavioral of VGA_driver is

    -- TYPES --
    type DRIVER_STATE is (
                        SET_ADDRESS,
                        GET_DATA
                    );

    -- CONSTANTS --
    
    constant C_screen_inner_width : NATURAL :=      384; --[px]
    constant C_screen_inner_height : NATURAL :=     384; --[px]
    
    constant C_screen_padding_left : NATURAL :=     128; --[px]
    constant C_screen_padding_top : NATURAL :=       48; --[px]
    
    constant C_x_start : NATURAL :=     C_screen_padding_left;
    constant C_x_stop : NATURAL :=      C_screen_padding_left + C_screen_inner_width;
    
    constant C_y_start : NATURAL :=     C_screen_padding_top;
    constant C_y_stop : NATURAL :=      C_screen_padding_top + C_screen_inner_height;
    
    constant C_init_state : DRIVER_STATE := SET_ADDRESS;
    
    
    -- SIGNALS --    
    signal state : DRIVER_STATE := C_init_state;
    
    signal is_valid_inner_screen_pixel : STD_LOGIC := '0';

begin

    INNER_SCREEN_PIXEL_MEMORY_ADDRESS_HANDLER:
    process (clk_i)
        variable inner_x : NATURAL range 0 to C_screen_inner_width-1 := 0;
        variable inner_y : NATURAL range 0 to C_screen_inner_height-1 := 0;
        variable address : NATURAL range 0 to 147455 := 0; -- RAM depth = 147456 = 384*384  => addresses range is [0,147455]
    begin
        if rising_edge (clk_i) then
        
            if (state = SET_ADDRESS) then
            
                if (C_x_start <= x_i and x_i < C_x_stop) and (C_y_start <= y_i and y_i < C_y_stop) then
                    inner_x := x_i - C_x_start;
                    inner_y := y_i - C_y_start;
                    is_valid_inner_screen_pixel <= '1';               
                
                else
                    inner_x := 0;
                    inner_y := 0;
                    is_valid_inner_screen_pixel <= '0';
                    
                end if;
                
                address := (inner_y * 384) + inner_x;
                read_address_o <= STD_LOGIC_VECTOR( TO_UNSIGNED( address, read_address_o'length ));
            
            end if;        
        end if;
    end process;
    
    
    SCREEN_PIXEL_DATA_HANDLER:
    process (clk_i)
    begin
        if rising_edge (clk_i) then
        
            if (state = GET_DATA) then
            
                if (is_valid_inner_screen_pixel = '1') and (read_data_i = "1") then
                    r_o <= "1111";
                    g_o <= "1111";
                    b_o <= "1111";
                            
                else
                    r_o <= "0000";
                    g_o <= "0000";
                    b_o <= "0000";
                
                end if;
            end if;        
        end if;
    end process;
    
    
    STATE_MACHINE:
    process (clk_i)
    begin
        if rising_edge (clk_i) then
        
            case state is
            
                when SET_ADDRESS =>
                    state <= GET_DATA;
                
                when GET_DATA =>
                    state <= SET_ADDRESS;
                
            end case;
        end if;
    end process;
    

end Behavioral;
