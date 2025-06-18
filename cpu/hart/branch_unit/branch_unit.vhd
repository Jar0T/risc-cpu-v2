----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jar0T
-- 
-- Create Date:     11:27:39 06/18/2025 
-- Design Name: 
-- Module Name:     branch_unit - Behavioral 
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

entity branch_unit is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_jump : in std_logic;
        i_branch : in std_logic;
        i_take_branch : in std_logic;
        i_branch_addr : in std_logic_vector(31 downto 0);
        o_branch_addr : out std_logic_vector(31 downto 0);
        o_pc_select : out std_logic
    );
end branch_unit;

architecture Behavioral of branch_unit is

    signal s_branch_addr : std_logic_vector(31 downto 0) := (others => '0');
    signal s_pc_select : std_logic := '0';

begin

    o_branch_addr <= s_branch_addr;
    o_pc_select <= s_pc_select;

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_branch_addr <= (others => '0');
                s_pc_select <= '0';
            else
                if (i_branch = '1' and i_take_branch = '1') or i_jump = '1' then
                    s_branch_addr <= i_branch_addr;
                    s_pc_select <= '1';
                else
                    s_pc_select <= '0';
                end if;
            end if;
        end if;
    end process;

end Behavioral;

