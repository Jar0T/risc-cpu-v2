----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jar0T
-- 
-- Create Date:     12:02:36 06/17/2025 
-- Design Name: 
-- Module Name:     memory_readback - Behavioral
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

entity memory_readback is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_read : in std_logic;
        i_funct3 : in std_logic_vector(2 downto 0);
        i_addr_low : in std_logic_vector(1 downto 0);
        i_data : in std_logic_vector(31 downto 0);
        o_data : out std_logic_vector(31 downto 0)
    );
end memory_readback;

architecture Behavioral of memory_readback is

    signal s_data : std_logic_vector(31 downto 0) := (others => '0');

begin

    o_data <= s_data;

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_data <= (others => '0');
            else
                if i_read = '1' then
                    case i_funct3 is
                        when "000" => -- LB
                            case i_addr_low is
                                when "00" => s_data <= std_logic_vector(resize(signed(i_data(7 downto 0)), s_data'length));
                                when "01" => s_data <= std_logic_vector(resize(signed(i_data(15 downto 8)), s_data'length));
                                when "10" => s_data <= std_logic_vector(resize(signed(i_data(23 downto 16)), s_data'length));
                                when "11" => s_data <= std_logic_vector(resize(signed(i_data(31 downto 24)), s_data'length));
                                when others =>
                            end case;
                        when "001" => -- LH
                            case i_addr_low(1) is
                                when '0' => s_data <= std_logic_vector(resize(signed(i_data(15 downto 0)), s_data'length));
                                when '1' => s_data <= std_logic_vector(resize(signed(i_data(31 downto 16)), s_data'length));
                                when others =>
                            end case;
                        when "010" => -- LW
                            s_data <= i_data;
                        when "100" => -- LBU
                            case i_addr_low is
                                when "00" => s_data <= std_logic_vector(resize(unsigned(i_data(7 downto 0)), s_data'length));
                                when "01" => s_data <= std_logic_vector(resize(unsigned(i_data(15 downto 8)), s_data'length));
                                when "10" => s_data <= std_logic_vector(resize(unsigned(i_data(23 downto 16)), s_data'length));
                                when "11" => s_data <= std_logic_vector(resize(unsigned(i_data(31 downto 24)), s_data'length));
                                when others =>
                            end case;
                        when "101" => -- LHU
                            case i_addr_low(1) is
                                when '0' => s_data <= std_logic_vector(resize(unsigned(i_data(15 downto 0)), s_data'length));
                                when '1' => s_data <= std_logic_vector(resize(unsigned(i_data(31 downto 16)), s_data'length));
                                when others =>
                            end case;
                        when others =>
                    end case;
                end if;
            end if;
        end if;
    end process;

end Behavioral;

