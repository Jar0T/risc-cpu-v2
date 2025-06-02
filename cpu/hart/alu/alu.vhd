----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
-- 
-- Create Date:     23:20:40 06/01/2025 
-- Design Name: 
-- Module Name:     alu - Behavioral 
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

entity alu is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_func : in std_logic_vector(3 downto 0);
        i_a : in signed(31 downto 0);
        i_b : in signed(31 downto 0);
        o_y : out signed(31 downto 0)
    );
end alu;

architecture Behavioral of alu is

    signal s_result : signed(31 downto 0) := (others => '0');
    
    signal s_addition : signed(31 downto 0) := (others => '0');
    signal s_subtraction : signed(31 downto 0) := (others => '0');
    signal s_shift_left_logical : unsigned(31 downto 0) := (others => '0');
    signal s_set_less_than : signed(31 downto 0) := (others => '0');
    signal s_set_less_than_unsigned : signed(31 downto 0) := (others => '0');
    signal s_xor : signed(31 downto 0) := (others => '0');
    signal s_shift_right_logical : unsigned(31 downto 0) := (others => '0');
    signal s_shift_right_arithmetic : signed(31 downto 0) := (others => '0');
    signal s_or : signed(31 downto 0) := (others => '0');
    signal s_and : signed(31 downto 0) := (others => '0');
    
    signal s_shift_amount : integer range 0 to 31 := 0;

begin

    o_y <= s_result;
    
    s_shift_amount <= to_integer(unsigned(i_b(4 downto 0)));
    
    s_addition <= i_a + i_b;
    s_subtraction <= i_a - i_b;
    s_shift_left_logical <= shift_left(unsigned(i_a), s_shift_amount);
    s_set_less_than <= to_signed(1, s_result'length) when i_a < i_b else to_signed(0, s_result'length);
    s_set_less_than_unsigned <= to_signed(1, s_result'length) when unsigned(i_a) < unsigned(i_b) else to_signed(0, s_result'length);
    s_xor <= i_a xor i_b;
    s_shift_right_logical <= shift_right(unsigned(i_a), s_shift_amount);
    s_shift_right_arithmetic <= shift_right(i_a, s_shift_amount);
    s_or <= i_a or i_b;
    s_and <= i_a and i_b;

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_result <= (others => '0');
            else
                case i_func is
                    when "0000" => s_result <= s_addition;
                    when "1000" => s_result <= s_subtraction;
                    when "0001" => s_result <= signed(s_shift_left_logical);
                    when "0010" => s_result <= s_set_less_than;
                    when "0011" => s_result <= s_set_less_than_unsigned;
                    when "0100" => s_result <= s_xor;
                    when "0101" => s_result <= signed(s_shift_right_logical);
                    when "1101" => s_result <= s_shift_right_arithmetic;
                    when "0110" => s_result <= s_or;
                    when "0111" => s_result <= s_and;
                    when others => s_result <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end Behavioral;

