----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jar0T
-- 
-- Create Date:     13:52:49 06/18/2025
-- Design Name:
-- Module Name:     comparator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_rs1 : in std_logic_vector(31 downto 0);
        i_rs2 : in std_logic_vector(31 downto 0);
        i_funct3 : in std_logic_vector(2 downto 0);
        o_result : out std_logic
    );
end comparator;

architecture Behavioral of comparator is

    signal s_result : std_logic := '0';
    signal s_equal, s_less_than, s_less_than_unsigned : std_logic := '0';

begin

    o_result <= s_result;
    
    s_equal <= '1' when i_rs1 = i_rs2 else '0';
    s_less_than <= '1' when signed(i_rs1) < signed(i_rs2) else '0';
    s_less_than_unsigned <= '1' when unsigned(i_rs1) < unsigned(i_rs2) else '0';
    
    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_result <= '0';
            else
                case i_funct3 is
                    when "000" => s_result <= s_equal;
                    when "001" => s_result <= not s_equal;
                    when "100" => s_result <= s_less_than;
                    when "101" => s_result <= not s_less_than;
                    when "110" => s_result <= s_less_than_unsigned;
                    when "111" => s_result <= not s_less_than_unsigned;
                    when others =>
                end case;
            end if;
        end if;
    end process;

end Behavioral;

