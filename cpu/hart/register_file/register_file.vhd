----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
-- 
-- Create Date:     18:26:12 05/30/2025 
-- Design Name: 
-- Module Name:     register_file - Behavioral 
-- Project Name:    risc-cpu-v2
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_file is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_addr_a : in integer range 0 to 31;
        i_addr_b : in integer range 0 to 31;
        i_addr_d : in integer range 0 to 31;
        o_data_a : out std_logic_vector(31 downto 0);
        o_data_b : out std_logic_vector(31 downto 0);
        i_data_d : in std_logic_vector(31 downto 0);
        i_we_d : in std_logic;
        i_valid : in std_logic;
        o_valid : out std_logic
    );
end register_file;

architecture Behavioral of register_file is

    type t_register_file is array(1 to 31) of std_logic_vector(31 downto 0);
    signal s_register_file : t_register_file := (others => (others => '0'));
    
    signal s_data_a, s_data_b : std_logic_vector(31 downto 0) := (others => '0');
    
    signal s_valid : std_logic := '0';

begin

    o_data_a <= s_data_a;
    o_data_b <= s_data_b;
    
    o_valid <= s_valid;
    
    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_valid <= '0';
            else
                s_valid <= i_valid;
            end if;
        end if;
    end process;

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_data_a <= (others => '0');
                s_data_b <= (others => '0');
            else
                if i_valid = '1' then
                    if i_addr_a = 0 then
                        s_data_a <= (others => '0');
                    else
                        s_data_a <= s_register_file(i_addr_a);
                    end if;
                
                    if i_addr_b = 0 then
                        s_data_b <= (others => '0');
                    else
                        s_data_b <= s_register_file(i_addr_b);
                    end if;
                end if;
                
                if i_we_d = '1' then
                    if i_addr_d = 0 then
                    else
                        s_register_file(i_addr_d) <= i_data_d;
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;

