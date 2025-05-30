--------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
--
-- Create Date:     15:24:08 05/29/2025
-- Design Name:   
-- Module Name:     /home/jarot/sources/rv32i/risc-cpu-v2/cpu/program_counter/program_counter_tb.vhd
-- Project Name:    risc-cpu-v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: program_counter
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
 
entity program_counter_tb is
end program_counter_tb;

architecture behavior of program_counter_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component program_counter
    port(
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_en : in std_logic;
        i_we : in std_logic;
        i_pc : in unsigned(31 downto 0);
        o_pc : out unsigned(31 downto 0)
        );
    end component;

    --Inputs
    signal i_clk : std_logic := '0';
    signal i_reset : std_logic := '0';
    signal i_en : std_logic := '0';
    signal i_we : std_logic := '0';
    signal i_pc : unsigned(31 downto 0) := (others => '0');

    --Outputs
    signal o_pc : unsigned(31 downto 0);

    -- Clock period definitions
    constant i_clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: program_counter port map (
        i_clk => i_clk,
        i_reset => i_reset,
        i_en => i_en,
        i_we => i_we,
        i_pc => i_pc,
        o_pc => o_pc
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
        wait for i_clk_period * 10;
        i_en <= '1';
        wait for i_clk_period * 10;
        i_reset <= '1';
        wait for i_clk_period * 5;
        i_en <= '0';
        wait for i_clk_period * 5;
        i_reset <= '0';
        wait for i_clk_period * 10;
        i_pc <= to_unsigned(256, i_pc'length);
        wait for i_clk_period;
        i_we <= '1';
        wait for i_clk_period;
        i_en <= '1';
        wait for i_clk_period;
        i_en <= '0';
        wait for i_clk_period;
        i_we <= '0';
        wait for i_clk_period * 10;
        i_en <= '1';

        wait;
    end process;

end;
