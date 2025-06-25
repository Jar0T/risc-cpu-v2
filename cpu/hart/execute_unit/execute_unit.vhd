----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jar0T
-- 
-- Create Date:     21:54:26 06/24/2025 
-- Design Name: 
-- Module Name:     execute_unit - Behavioral 
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

entity execute_unit is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_valid : in std_logic;
        o_valid : out std_logic;
        i_funct4 : in std_logic_vector(3 downto 0);
        i_funct3 : in std_logic_vector(2 downto 0);
        i_a : in std_logic_vector(31 downto 0);
        i_b : in std_logic_vector(31 downto 0);
        i_rs1 : in std_logic_vector(31 downto 0);
        i_rs2 : in std_logic_vector(31 downto 0);
        o_y : out std_logic_vector(31 downto 0);
        o_cmp_resut : out std_logic
    );
end execute_unit;

architecture RTL of execute_unit is

    component alu is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_func : in std_logic_vector(3 downto 0);
        i_a : in std_logic_vector(31 downto 0);
        i_b : in std_logic_vector(31 downto 0);
        o_y : out std_logic_vector(31 downto 0)
    );
    end component;
    
    component comparator is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_rs1 : in std_logic_vector(31 downto 0);
        i_rs2 : in std_logic_vector(31 downto 0);
        i_funct3 : in std_logic_vector(2 downto 0);
        o_result : out std_logic
    );
    end component;
    
    signal s_valid : std_logic := '0';

begin

    o_valid <= s_valid;

    i_alu : alu port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_func => i_funct4,
        i_a => i_a,
        i_b => i_b,
        o_y => o_y
    );
    
    i_comparator : comparator port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_rs1 => i_rs1,
        i_rs2 => i_rs2,
        i_funct3 => i_funct3,
        o_result => o_cmp_resut
    );
    
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

end RTL;

