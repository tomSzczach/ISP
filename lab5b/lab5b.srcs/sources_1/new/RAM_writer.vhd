----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2024 03:12:13
-- Design Name: 
-- Module Name: RAM_writer - Behavioral
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

entity RAM_writer is

    Port ( 
            clk_i : in STD_LOGIC;
            screen_rst_i : in STD_LOGIC;
            x_i : in NATURAL;
            y_i : in NATURAL;
            data_valid_i : in STD_LOGIC;
            write_enable_o : out STD_LOGIC_VECTOR(0 DOWNTO 0);
            write_address_o : out STD_LOGIC_VECTOR(17 DOWNTO 0);
            write_data_o : out STD_LOGIC_VECTOR(0 DOWNTO 0)
         );
         
end RAM_writer;

architecture Behavioral of RAM_writer is
    
    -- TYPES --                   
    type W_STATE is (
                    RESET,
                    NORMAL_WRITE
                );

    -- CONSTANTS --
    constant C_init_state : W_STATE := RESET;
    constant C_RAM_depth : NATURAL :=      147456;      -- RAM depth = 147456 = 384*384  => addresses range is [0,147455]
    
    -- SIGNALS
    signal state : W_STATE := C_init_state;
    
    
begin

    RAM_WRITING_HANDLER:
    process (clk_i)
        variable address : NATURAL range 0 to C_RAM_depth-1 := 0; 
    begin
        if rising_edge(clk_i) then
        
            case state is 
                    
                when RESET =>
                    write_address_o <= STD_LOGIC_VECTOR( TO_UNSIGNED( address, write_address_o'length ));
                    write_data_o <= "0";
                    write_enable_o <= "1";
                    
                    if (address < C_RAM_depth-1) then
                        address := address + 1;
                        
                    else
                        state <= NORMAL_WRITE;
                        address := 0;
                        
                    end if;
                
                when NORMAL_WRITE =>
                    write_enable_o <= "0";
                    
                    if (screen_rst_i = '1') then
                        state <= RESET;
                        address := 0;
                    
                    elsif (data_valid_i = '1') then
                        address := (y_i * 384) + x_i;
                        write_address_o <= STD_LOGIC_VECTOR( TO_UNSIGNED( address, write_address_o'length ));
                        write_data_o <= "1";
                        write_enable_o <= "1";
                        
                    end if;                    
                
                when others => state <= C_init_state;
                
            end case;  
            
        end if;
    end process;


end Behavioral;
