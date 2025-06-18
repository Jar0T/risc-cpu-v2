--------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jar0T
--
-- Create Date:     12:18:10 06/18/2025
-- Design Name:   
-- Module Name:     /home/jarek/sources/rv32i/vhdl/risc-cpu-v2/cpu/hart/branch_unit/branch_unit_tb.vhd
-- Project Name:    risc-cpu-v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: branch_unit
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

entity branch_unit_tb is
end branch_unit_tb;

architecture behavior of branch_unit_tb is 

    -- Component Declaration for the Unit Under Test (UUT)
    component branch_unit
    Port(
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_jump : in std_logic;
        i_branch : in std_logic;
        i_take_branch : in std_logic;
        i_branch_addr : in std_logic_vector(31 downto 0);
        o_branch_addr : out std_logic_vector(31 downto 0);
        o_pc_select : out std_logic
        );
    end component;

    --Inputs
    signal i_clk : std_logic := '0';
    signal i_reset : std_logic := '0';
    signal i_jump : std_logic := '0';
    signal i_branch : std_logic := '0';
    signal i_take_branch : std_logic := '0';
    signal i_branch_addr : std_logic_vector(31 downto 0) := (others => '0');

    --Outputs
    signal o_branch_addr : std_logic_vector(31 downto 0);
    signal o_pc_select : std_logic;

    -- Clock period definitions
    constant i_clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: branch_unit Port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_jump => i_jump,
        i_branch => i_branch,
        i_take_branch => i_take_branch,
        i_branch_addr => i_branch_addr,
        o_branch_addr => o_branch_addr,
        o_pc_select => o_pc_select
        );

    -- Clock process definitions
    i_clk_process :process
    begin
        i_clk <= not i_clk;
        wait for i_clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- insert stimulus here
        i_reset <= '1';
        wait for i_clk_period;
        i_reset <= '0';
        wait for i_clk_period;
        
        i_branch_addr <= X"00000011";
        i_jump <= '1';
        wait for i_clk_period;
        i_jump <= '0';
        i_branch_addr <= X"00000022";
        i_branch <= '1';
        wait for i_clk_period;
        i_branch_addr <= X"00000033";
        i_take_branch <= '1';
        wait for i_clk_period;
        i_branch_addr <= X"00000044";
        i_branch <= '0';
        wait for i_clk_period;
        i_reset <= '1';
        wait for i_clk_period;
        i_jump <= '0';
        i_branch <= '0';
        i_take_branch <= '0';
        i_reset <= '0';
        wait for i_clk_period;

        wait;
    end process;

end;
