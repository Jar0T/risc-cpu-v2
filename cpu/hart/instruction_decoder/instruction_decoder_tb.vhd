--------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jar0T
--
-- Create Date:     21:29:22 06/22/2025
-- Design Name:   
-- Module Name:     instruction_decoder_tb.vhd
-- Project Name:    risc-cpu-v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: instruction_decoder
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

library work;
use work.hart_pkg.all;

entity instruction_decoder_tb is
end instruction_decoder_tb;

architecture behavior of instruction_decoder_tb is 

    -- Component Declaration for the Unit Under Test (UUT)
 
    component instruction_decoder
    port(
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_valid : in std_logic;
        i_instruction : in std_logic_vector(31 downto 0);
        o_imm : out std_logic_vector(31 downto 0);
        o_control_signals : out t_control_signals;
        o_valid : out std_logic
        );
    end component;

    --Inputs
    signal i_clk : std_logic := '0';
    signal i_reset : std_logic := '0';
    signal i_valid : std_logic := '0';
    signal i_instruction : std_logic_vector(31 downto 0) := (others => '0');

    --Outputs
    signal o_imm : std_logic_vector(31 downto 0);
    signal o_control_signals : t_control_signals;
    signal o_valid : std_logic;

    -- Clock period definitions
    constant i_clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: instruction_decoder port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_valid => i_valid,
        i_instruction => i_instruction,
        o_imm => o_imm,
        o_control_signals => o_control_signals,
        o_valid => o_valid
        );

    -- Clock process definitions
    i_clk_process :process
    begin
        i_clk <= '0';
        wait for i_clk_period/2;
        i_clk <= '1';
        wait for i_clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- insert stimulus here
        wait for i_clk_period / 2;
        i_instruction <= X"00000013";
        i_valid <= '0';
        wait for i_clk_period * 4.1;
        i_valid <= '1';
        wait for i_clk_period * 0.9;

        wait;
    end process;

end;
