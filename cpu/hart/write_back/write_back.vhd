----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
-- 
-- Create Date:     15:06:54 06/05/2025 
-- Design Name: 
-- Module Name:     write_back - Behavioral 
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

library work;
use work.hart_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity write_back is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_we : in std_logic;
        i_result_select : in t_result_select;
        i_alu : in std_logic_vector(31 downto 0);
        i_memory : in std_logic_vector(31 downto 0);
        i_immediate : in std_logic_vector(31 downto 0);
        i_pc_plus_4 : in std_logic_vector(31 downto 0);
        o_data : out std_logic_vector(31 downto 0);
        o_we : out std_logic
    );
end write_back;

architecture Behavioral of write_back is

    signal s_data : std_logic_vector(31 downto 0) := (others => '0');
    signal s_we : std_logic := '0';

begin

    o_data <= s_data;
    o_we <= s_we;

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_data <= (others => '0');
                s_we <= '0';
            else
                s_we <= i_we;
                case i_result_select is
                    when ALU => s_data <= i_alu;
                    when MEMORY => s_data <= i_memory;
                    when IMMEDIATE => s_data <= i_immediate;
                    when PC_PLUS_4 => s_data <= i_pc_plus_4;
                end case;
            end if;
        end if;
    end process;

end Behavioral;

