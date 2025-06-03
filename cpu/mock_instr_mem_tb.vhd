--------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
--
-- Create Date:     10:40:27 06/03/2025
-- Design Name:   
-- Module Name:     /home/jarek/sources/rv32i/vhdl/risc-cpu-v2/cpu/mock_instr_mem_tb.vhd
-- Project Name:    risc-cpu-v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mock_instr_mem
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

entity mock_instr_mem_tb is
end mock_instr_mem_tb;

architecture behavior of mock_instr_mem_tb is

    -- Component Declaration for the Unit Under Test (UUT)

    component mock_instr_mem
    port(
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_addr : in unsigned(8 downto 0);
        i_en : in std_logic;
        o_instr : out std_logic_vector(31 downto 0);
        o_valid : out std_logic
        );
    end component;

    --Inputs
    signal i_clk : std_logic := '0';
    signal i_reset : std_logic := '0';
    signal i_addr : unsigned(8 downto 0) := (others => '0');
    signal i_en : std_logic := '0';

    --Outputs
    signal o_instr : std_logic_vector(31 downto 0);
    signal o_valid : std_logic;

    -- Clock period definitions
    constant i_clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: mock_instr_mem Port map (
        i_clk => i_clk,
        i_reset => i_reset,
        i_addr => i_addr,
        i_en => i_en,
        o_instr => o_instr,
        o_valid => o_valid
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
        wait for i_clk_period * 3;
        
        i_en <= '1';
        i_addr <= to_unsigned(1, i_addr'length);
        wait for i_clk_period;
        i_en <= '0';

        wait;
    end process;

end;
