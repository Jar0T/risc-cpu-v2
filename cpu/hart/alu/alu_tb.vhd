--------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
--
-- Create Date:     00:48:23 06/02/2025
-- Design Name:   
-- Module Name:     /home/jarek/sources/rv32i/vhdl/risc-cpu-v2/cpu/hart/alu/alu_tb.vhd
-- Project Name:    risc-cpu-v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
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
use ieee.numeric_std.all;

entity alu_tb is
end alu_tb;

architecture behavior of alu_tb is

    -- Component Declaration for the Unit Under Test (UUT)

    component alu
    Port(
         i_clk : in std_logic;
         i_reset : in std_logic;
         i_func : in std_logic_vector(3 downto 0);
         i_a : in signed(31 downto 0);
         i_b : in signed(31 downto 0);
         o_y : out signed(31 downto 0)
        );
    end component;

    --Inputs
    signal i_clk : std_logic := '0';
    signal i_reset : std_logic := '0';
    signal i_func : std_logic_vector(3 downto 0) := (others => '0');
    signal i_a : signed(31 downto 0) := (others => '0');
    signal i_b : signed(31 downto 0) := (others => '0');

    --Outputs
    signal o_y : signed(31 downto 0);

    -- Clock period definitions
    constant i_clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: alu Port map (
        i_clk => i_clk,
        i_reset => i_reset,
        i_func => i_func,
        i_a => i_a,
        i_b => i_b,
        o_y => o_y
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
        i_func <= "0100";
        i_a <= X"AAAA_AAAA";
        i_b <= X"5555_5555";
        wait;
    end process;

end;
