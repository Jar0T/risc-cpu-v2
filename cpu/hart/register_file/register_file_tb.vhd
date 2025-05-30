--------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
--
-- Create Date:     19:33:02 05/30/2025
-- Design Name:   
-- Module Name:     register_file_tb.vhd
-- Project Name:    risc-cpu-v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: register_file
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

entity register_file_tb is
end register_file_tb;

architecture behavior of register_file_tb is

    -- Component Declaration for the Unit Under Test (UUT)

    component register_file
    port(
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_addr_a : in integer range 0 to 31;
        i_addr_b : in integer range 0 to 31;
        i_addr_d : in integer range 0 to 31;
        o_data_a : out std_logic_vector(31 downto 0);
        o_data_b : out std_logic_vector(31 downto 0);
        i_data_d : in std_logic_vector(31 downto 0);
        i_oe_a : in std_logic;
        i_oe_b : in std_logic;
        i_we_d : in std_logic
        );
    end component;

    --Inputs
    signal i_clk : std_logic := '0';
    signal i_reset : std_logic := '0';
    signal i_addr_a : integer range 0 to 31 := 0;
    signal i_addr_b : integer range 0 to 31 := 0;
    signal i_addr_d : integer range 0 to 31 := 0;
    signal i_data_d : std_logic_vector(31 downto 0) := (others => '0');
    signal i_oe_a : std_logic := '0';
    signal i_oe_b : std_logic := '0';
    signal i_we_d : std_logic := '0';

    --Outputs
    signal o_data_a : std_logic_vector(31 downto 0);
    signal o_data_b : std_logic_vector(31 downto 0);

    -- Clock period definitions
    constant i_clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: register_file port map (
        i_clk => i_clk,
        i_reset => i_reset,
        i_addr_a => i_addr_a,
        i_addr_b => i_addr_b,
        i_addr_d => i_addr_d,
        o_data_a => o_data_a,
        o_data_b => o_data_b,
        i_data_d => i_data_d,
        i_oe_a => i_oe_a,
        i_oe_b => i_oe_b,
        i_we_d => i_we_d
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
        wait for i_clk_period * 2;
        
        i_we_d <= '1';
        for i in 0 to 31 loop
            i_addr_d <= i;
            i_data_d <= std_logic_vector(to_unsigned(i + 8, i_data_d'length));
            wait for i_clk_period;
        end loop;
        i_we_d <= '0';
        wait for i_clk_period;
        
        i_oe_a <= '1';
        for i in 0 to 31 loop
            i_addr_a <= i;
            wait for i_clk_period;
        end loop;
        i_oe_a <= '0';
        wait for i_clk_period;
        
        i_oe_b <= '1';
        for i in 0 to 31 loop
            i_addr_b <= i;
            wait for i_clk_period;
        end loop;
        i_oe_b <= '0';
        wait for i_clk_period;
        
        i_reset <= '1';
        wait for i_clk_period;
        i_reset <= '0';

        wait;
    end process;

end;
