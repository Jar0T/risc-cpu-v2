----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
-- 
-- Create Date:     10:23:26 06/03/2025 
-- Design Name: 
-- Module Name:     mock_instr_mem - Behavioral 
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

entity mock_instr_mem is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_addr : in unsigned(8 downto 0);
        i_en : in std_logic;
        o_instr : out std_logic_vector(31 downto 0);
        o_valid : out std_logic
    );
end mock_instr_mem;

architecture Behavioral of mock_instr_mem is

    type t_instr_rom is array(0 to 511) of std_logic_vector(31 downto 0);
    signal s_instr_rom : t_instr_rom := (
        0 => X"003e80b7",
        1 => X"00208133",
        2 => X"0010c133",
        others => (others => '0')
    );
    signal s_instr, s_instr_delay : std_logic_vector(31 downto 0) := (others => '0');
    signal s_valid, s_valid_delay : std_logic := '0';

begin

    o_instr <= s_instr_delay;
    o_valid <= s_valid_delay;

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_instr <= (others => '0');
                s_instr_delay <= (others => '0');
                s_valid <= '0';
                s_valid_delay <= '0';
            else
                if i_en = '1' then
                    s_instr <= s_instr_rom(to_integer(i_addr));
                    s_valid <= '1';
                end if;
                s_instr_delay <= s_instr;
                s_valid_delay <= s_valid;
            end if;
        end if;
    end process;

end Behavioral;

