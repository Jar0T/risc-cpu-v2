----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
-- 
-- Create Date:     15:15:54 05/29/2025 
-- Design Name: 
-- Module Name:     program_counter - Behavioral 
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

entity program_counter is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_en : in std_logic;
        i_we : in std_logic;
        i_pc : in unsigned(31 downto 0);
        o_pc : out unsigned(31 downto 0);
        o_pc_plus_4 : out unsigned(31 downto 0)
    );
end program_counter;

architecture Behavioral of program_counter is

    signal s_pc, s_pc_plus_4 : unsigned(31 downto 0) := (others => '0');

begin
    
    o_pc <= s_pc;
    o_pc_plus_4 <= s_pc_plus_4;

    s_pc_plus_4 <= s_pc + to_unsigned(4, s_pc'length);

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_pc <= (others => '0');
                s_pc_plus_4 <= (others => '0');
            else
                if i_en = '1' then
                    if i_we = '1' then
                        s_pc <= i_pc;
                    else
                        s_pc <= s_pc_plus_4;
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;

