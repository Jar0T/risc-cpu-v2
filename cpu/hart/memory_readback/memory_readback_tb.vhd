--------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jar0T
--
-- Create Date:     12:32:52 06/17/2025
-- Design Name:   
-- Module Name:     /home/jarek/sources/rv32i/vhdl/risc-cpu-v2/cpu/hart/memory_readback/memory_readback_tb.vhd
-- Project Name:    risc-cpu-v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memory_readback
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

entity memory_readback_tb is
end memory_readback_tb;

architecture behavior of memory_readback_tb is

    -- Component Declaration for the Unit Under Test (UUT)

    component memory_readback
    port(
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_read : in std_logic;
        i_funct3 : in std_logic_vector(2 downto 0);
        i_addr_low : in std_logic_vector(1 downto 0);
        i_data : in std_logic_vector(31 downto 0);
        o_data : out std_logic_vector(31 downto 0)
        );
    end component;

    --Inputs
    signal i_clk : std_logic := '0';
    signal i_reset : std_logic := '0';
    signal i_read : std_logic := '0';
    signal i_funct3 : std_logic_vector(2 downto 0) := (others => '0');
    signal i_addr_low : std_logic_vector(1 downto 0) := (others => '0');
    signal i_data : std_logic_vector(31 downto 0) := (others => '0');

    --Outputs
    signal o_data : std_logic_vector(31 downto 0);

    -- Clock period definitions
    constant i_clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: memory_readback Port map (
        i_clk => i_clk,
        i_reset => i_reset,
        i_read => i_read,
        i_funct3 => i_funct3,
        i_addr_low => i_addr_low,
        i_data => i_data,
        o_data => o_data
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
        i_data <= X"76543210";
        wait for i_clk_period;
        
        i_read <= '1';
        -- positive numbers
        i_data <= X"44332211";
        -- LB
        i_funct3 <= "000";
        i_addr_low <= "00";
        wait for i_clk_period;
        i_addr_low <= "01";
        wait for i_clk_period;
        i_addr_low <= "10";
        wait for i_clk_period;
        i_addr_low <= "11";
        wait for i_clk_period;
        -- LH
        i_funct3 <= "001";
        i_addr_low <= "00";
        wait for i_clk_period;
        i_addr_low <= "10";
        wait for i_clk_period;
        -- LW
        i_funct3 <= "010";
        i_addr_low <= "00";
        wait for i_clk_period;
        -- LBU
        i_funct3 <= "100";
        i_addr_low <= "00";
        wait for i_clk_period;
        i_addr_low <= "01";
        wait for i_clk_period;
        i_addr_low <= "10";
        wait for i_clk_period;
        i_addr_low <= "11";
        wait for i_clk_period;
        -- LHU
        i_funct3 <= "101";
        i_addr_low <= "00";
        wait for i_clk_period;
        i_addr_low <= "10";
        wait for i_clk_period;
        
        -- negative numbers
        i_data <= X"ffeeddcc";
        -- LB
        i_funct3 <= "000";
        i_addr_low <= "00";
        wait for i_clk_period;
        i_addr_low <= "01";
        wait for i_clk_period;
        i_addr_low <= "10";
        wait for i_clk_period;
        i_addr_low <= "11";
        wait for i_clk_period;
        -- LH
        i_funct3 <= "001";
        i_addr_low <= "00";
        wait for i_clk_period;
        i_addr_low <= "10";
        wait for i_clk_period;
        -- LW
        i_funct3 <= "010";
        i_addr_low <= "00";
        wait for i_clk_period;
        -- LBU
        i_funct3 <= "100";
        i_addr_low <= "00";
        wait for i_clk_period;
        i_addr_low <= "01";
        wait for i_clk_period;
        i_addr_low <= "10";
        wait for i_clk_period;
        i_addr_low <= "11";
        wait for i_clk_period;
        -- LHU
        i_funct3 <= "101";
        i_addr_low <= "00";
        wait for i_clk_period;
        i_addr_low <= "10";
        wait for i_clk_period;
        
        i_read <= '0';
        wait for i_clk_period;

        wait;
    end process;

end;
