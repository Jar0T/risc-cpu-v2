----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
-- 
-- Create Date:     22:26:48 06/12/2025 
-- Design Name: 
-- Module Name:     memory_setup - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_setup is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_read : in std_logic;
        i_write : in std_logic;
        i_funct3 : in std_logic_vector(1 downto 0);
        i_rs2 : in std_logic_vector(31 downto 0);
        i_addr : in std_logic_vector(31 downto 0);
        o_en : out std_logic;
        o_we : out std_logic_vector(3 downto 0);
        o_data : out std_logic_vector(31 downto 0);
        o_addr : out std_logic_vector(31 downto 0)
     );
end memory_setup;

architecture Behavioral of memory_setup is

    signal s_en : std_logic := '0';
    signal s_we : std_logic_vector(3 downto 0) := (others => '0');
    signal s_data : std_logic_vector(31 downto 0) := (others => '0');
    signal s_addr : std_logic_vector(31 downto 0) := (others => '0');

begin

    o_en <= s_en;
    o_we <= s_we;
    o_data <= s_data;
    o_addr <= s_addr;
    
    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_en <= '0';
                s_we <= (others => '0');
                s_data <= (others => '0');
                s_addr <= (others => '0');
            else
                s_en <= i_read or i_write;
                
                case i_funct3 is
                    when "00" => -- SB
                        case i_addr(1 downto 0) is
                            when "00" =>
                                s_we <= "0001";
                                s_data(7 downto 0) <= i_rs2(7 downto 0);
                            when "01" =>
                                s_we <= "0010";
                                s_data(15 downto 8) <= i_rs2(7 downto 0);
                            when "10" =>
                                s_we <= "0100";
                                s_data(23 downto 16) <= i_rs2(7 downto 0);
                            when "11" =>
                                s_we <= "1000";
                                s_data(31 downto 24) <= i_rs2(7 downto 0);
                        end case;
                    when "01" => -- SH
                        case i_addr(1) is
                            when "0" =>
                                s_we <= "0011";
                                s_data(15 downto 0) <= i_rs2(15 downto 0);
                            when "1" =>
                                s_we <= "1100";
                                s_data(31 downto 16) <= i_rs2(15 downto 0);
                        end case;
                    when "10" => -- SW
                        s_we <= "1111";
                        s_data <= i_rs2;
                    when others =>
                end case;
            end if;
        end if;
    end process;

end Behavioral;

