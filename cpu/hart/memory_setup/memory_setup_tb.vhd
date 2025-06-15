--------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
--
-- Create Date:     12:29:32 06/15/2025
-- Design Name:   
-- Module Name:     /home/jarek/sources/rv32i/vhdl/risc-cpu-v2/cpu/hart/memory_setup/memory_setup_tb.vhd
-- Project Name:    risc-cpu-v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memory_setup
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
 
entity memory_setup_tb is
end memory_setup_tb;

architecture behavior of memory_setup_tb is

    -- Component Declaration for the Unit Under Test (UUT)

    component memory_setup
    port(
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_read : in std_logic;
        i_write : in std_logic;
        i_funct3 : in std_logic_vector(2 downto 0);
        i_rs2 : in std_logic_vector(31 downto 0);
        i_addr : in std_logic_vector(31 downto 0);
        o_en : out std_logic;
        o_we : out std_logic_vector(3 downto 0);
        o_data : out std_logic_vector(31 downto 0);
        o_addr : out std_logic_vector(29 downto 0)
        );
    end component;

    --Inputs
    signal i_clk : std_logic := '0';
    signal i_reset : std_logic := '0';
    signal i_read : std_logic := '0';
    signal i_write : std_logic := '0';
    signal i_funct3 : std_logic_vector(2 downto 0) := (others => '0');
    signal i_rs2 : std_logic_vector(31 downto 0) := (others => '0');
    signal i_addr : std_logic_vector(31 downto 0) := (others => '0');

    --Outputs
    signal o_en : std_logic;
    signal o_we : std_logic_vector(3 downto 0);
    signal o_data : std_logic_vector(31 downto 0);
    signal o_addr : std_logic_vector(29 downto 0);

    -- Clock period definitions
    constant i_clk_period : time := 10 ns;

begin

    -- instantiate the unit under test (uut)
    uut: memory_setup port map (
        i_clk => i_clk,
        i_reset => i_reset,
        i_read => i_read,
        i_write => i_write,
        i_funct3 => i_funct3,
        i_rs2 => i_rs2,
        i_addr => i_addr,
        o_en => o_en,
        o_we => o_we,
        o_data => o_data,
        o_addr => o_addr
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
        i_read <= '1';
        --LB
        i_funct3 <= "000";
        wait for i_clk_period;
        --LW
        i_funct3 <= "001";
        wait for i_clk_period;
        --LH
        i_funct3 <= "010";
        wait for i_clk_period;
        --LBU
        i_funct3 <= "100";
        wait for i_clk_period;
        --LHU
        i_funct3 <= "101";
        wait for i_clk_period;
        
        i_read <= '0';
        wait for i_clk_period;
        
        i_write <= '1';
        i_rs2 <= X"76543210";
        --SB
        i_funct3 <= "000";
        i_addr(1 downto 0) <= "00";
        wait for i_clk_period;
        i_addr(1 downto 0) <= "01";
        wait for i_clk_period;
        i_addr(1 downto 0) <= "10";
        wait for i_clk_period;
        i_addr(1 downto 0) <= "11";
        wait for i_clk_period;
        --SH
        i_addr <= (others => '0');
        i_funct3 <= "001";
        i_addr(1) <= '0';
        wait for i_clk_period;
        i_addr(1) <= '1';
        wait for i_clk_period;
        --SW
        i_addr <= (others => '0');
        i_funct3 <= "010";
        wait for i_clk_period;
        
        i_write <= '0';
        wait for i_clk_period;
        
        i_addr <= (others => '0');
        i_addr(3 downto 0) <= "0100";
        wait for i_clk_period;
        i_addr(3 downto 0) <= "0101";
        wait for i_clk_period;
        i_addr(3 downto 0) <= "0110";
        wait for i_clk_period;
        i_addr(3 downto 0) <= "0111";
        wait for i_clk_period;
        i_addr(3 downto 0) <= "1000";
        wait for i_clk_period;
        i_addr(3 downto 0) <= "1001";
        wait for i_clk_period;
        i_addr(3 downto 0) <= "1010";
        wait for i_clk_period;
        i_addr(3 downto 0) <= "1011";
        wait for i_clk_period;
        
        i_reset <= '1';
        wait for i_clk_period;
        i_addr <= (others => '0');
        i_write <= '0';
        i_read <= '0';
        i_funct3 <= (others => '0');
        i_rs2 <= (others => '0');
        wait for i_clk_period;
        i_reset <= '0';
        wait for i_clk_period;

        wait;
    end process;

end;
