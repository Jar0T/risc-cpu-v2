--------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jar0T
--
-- Create Date:     15:15:27 06/18/2025
-- Design Name:   
-- Module Name:     /home/jarek/sources/rv32i/vhdl/risc-cpu-v2/cpu/hart/branch_unit/comparator_tb.vhd
-- Project Name:    risc-cpu-v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comparator
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

entity comparator_tb is
end comparator_tb;

architecture behavior of comparator_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component comparator
    port(
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_rs1 : in std_logic_vector(31 downto 0);
        i_rs2 : in std_logic_vector(31 downto 0);
        i_funct3 : in std_logic_vector(2 downto 0);
        o_result : out std_logic
        );
    end component;

    --Inputs
    signal i_clk : std_logic := '0';
    signal i_reset : std_logic := '0';
    signal i_rs1 : std_logic_vector(31 downto 0) := (others => '0');
    signal i_rs2 : std_logic_vector(31 downto 0) := (others => '0');
    signal i_funct3 : std_logic_vector(2 downto 0) := (others => '0');

    --Outputs
    signal o_result : std_logic;

    -- Clock period definitions
    constant i_clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: comparator Port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_rs1 => i_rs1,
        i_rs2 => i_rs2,
        i_funct3 => i_funct3,
        o_result => o_result
        );

    -- Clock process definitions
    i_clk_process :process
    begin
        wait for i_clk_period/2;
        i_clk <= not i_clk;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- BEQ
        i_funct3 <= "000";
        i_rs1 <= X"44332211";
        i_rs2 <= X"44332211";
        wait for i_clk_period;
        i_rs1 <= X"44332211";
        i_rs2 <= X"11223344";
        wait for i_clk_period;
        
        -- BNE
        i_funct3 <= "001";
        i_rs1 <= X"44332211";
        i_rs2 <= X"44332211";
        wait for i_clk_period;
        i_rs1 <= X"44332211";
        i_rs2 <= X"11223344";
        wait for i_clk_period;
        
        -- BLT
        i_funct3 <= "100";
        i_rs1 <= X"FFFFFF11";
        i_rs2 <= X"FFFFFF22";
        wait for i_clk_period;
        i_rs1 <= X"FFFFFF11";
        i_rs2 <= X"00000011";
        wait for i_clk_period;
        i_rs1 <= X"00000011";
        i_rs2 <= X"00000022";
        wait for i_clk_period;
        i_rs1 <= X"FFFFFF22";
        i_rs2 <= X"FFFFFF11";
        wait for i_clk_period;
        i_rs1 <= X"00000011";
        i_rs2 <= X"FFFFFF11";
        wait for i_clk_period;
        i_rs1 <= X"00000022";
        i_rs2 <= X"00000011";
        wait for i_clk_period;
        i_rs1 <= X"00000000";
        i_rs2 <= X"00000000";
        wait for i_clk_period;
        
        -- BGE
        i_funct3 <= "101";
        i_rs1 <= X"FFFFFF11";
        i_rs2 <= X"FFFFFF22";
        wait for i_clk_period;
        i_rs1 <= X"FFFFFF11";
        i_rs2 <= X"00000011";
        wait for i_clk_period;
        i_rs1 <= X"00000011";
        i_rs2 <= X"00000022";
        wait for i_clk_period;
        i_rs1 <= X"FFFFFF22";
        i_rs2 <= X"FFFFFF11";
        wait for i_clk_period;
        i_rs1 <= X"00000011";
        i_rs2 <= X"FFFFFF11";
        wait for i_clk_period;
        i_rs1 <= X"00000022";
        i_rs2 <= X"00000011";
        wait for i_clk_period;
        i_rs1 <= X"00000000";
        i_rs2 <= X"00000000";
        wait for i_clk_period;
        
        -- BLTU
        i_funct3 <= "110";
        i_rs1 <= X"FFFFFF11";
        i_rs2 <= X"FFFFFF22";
        wait for i_clk_period;
        i_rs1 <= X"FFFFFF11";
        i_rs2 <= X"00000011";
        wait for i_clk_period;
        i_rs1 <= X"00000011";
        i_rs2 <= X"00000022";
        wait for i_clk_period;
        i_rs1 <= X"FFFFFF22";
        i_rs2 <= X"FFFFFF11";
        wait for i_clk_period;
        i_rs1 <= X"FFFFFF11";
        i_rs2 <= X"00000011";
        wait for i_clk_period;
        i_rs1 <= X"00000022";
        i_rs2 <= X"00000011";
        wait for i_clk_period;
        i_rs1 <= X"00000000";
        i_rs2 <= X"00000000";
        wait for i_clk_period;
        
        -- BGEU
        i_funct3 <= "111";
        i_rs1 <= X"FFFFFF11";
        i_rs2 <= X"FFFFFF22";
        wait for i_clk_period;
        i_rs1 <= X"FFFFFF11";
        i_rs2 <= X"00000011";
        wait for i_clk_period;
        i_rs1 <= X"00000011";
        i_rs2 <= X"00000022";
        wait for i_clk_period;
        i_rs1 <= X"FFFFFF22";
        i_rs2 <= X"FFFFFF11";
        wait for i_clk_period;
        i_rs1 <= X"FFFFFF11";
        i_rs2 <= X"00000011";
        wait for i_clk_period;
        i_rs1 <= X"00000022";
        i_rs2 <= X"00000011";
        wait for i_clk_period;
        i_rs1 <= X"00000000";
        i_rs2 <= X"00000000";
        wait for i_clk_period;

        wait;
    end process;

end;
