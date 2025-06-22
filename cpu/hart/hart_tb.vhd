--------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jar0T
--
-- Create Date:     15:24:58 06/21/2025
-- Design Name:   
-- Module Name:     hart_tb.vhd
-- Project Name:    risc-cpu-v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: hart
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

entity hart_tb is
end hart_tb;

architecture behavior of hart_tb is 

    -- Component Declaration for the Unit Under Test (UUT)

    component hart
    port(
        i_clk : in  std_logic;
        i_reset : in  std_logic;
        o_pc : out  std_logic_vector(31 downto 0);
        i_instr : in  std_logic_vector(31 downto 0);
        o_dmem_en : out  std_logic;
        o_dmem_we : out  std_logic_vector(3 downto 0);
        o_dmem_addr : out  std_logic_vector(29 downto 0);
        o_dmem_data : out  std_logic_vector(31 downto 0);
        i_dmem_data : in  std_logic_vector(31 downto 0)
        );
    end component;

    --Inputs
    signal i_clk : std_logic := '0';
    signal i_reset : std_logic := '0';
    signal i_instr : std_logic_vector(31 downto 0) := (others => '0');
    signal i_dmem_data : std_logic_vector(31 downto 0) := (others => '0');

    --Outputs
    signal o_pc : std_logic_vector(31 downto 0);
    signal o_dmem_en : std_logic;
    signal o_dmem_we : std_logic_vector(3 downto 0);
    signal o_dmem_addr : std_logic_vector(29 downto 0);
    signal o_dmem_data : std_logic_vector(31 downto 0);

    -- Clock period definitions
    constant i_clk_period : time := 10 ns;
    
    type t_mem is array(0 to 511) of std_logic_vector(31 downto 0);
    signal s_instr_rom : t_mem := (
        others => X"00000013"
    );
    signal s_data_ram : t_mem := (
        0 => X"44332211",
        1 => X"44332211",
        2 => X"44332211",
        3 => X"44332211",
        4 => X"44332211",
        5 => X"44332211",
        6 => X"44332211",
        7 => X"44332211",
        others => (others => '0')
    );

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: hart port map (
        i_clk => i_clk,
        i_reset => i_reset,
        o_pc => o_pc,
        i_instr => i_instr,
        o_dmem_en => o_dmem_en,
        o_dmem_we => o_dmem_we,
        o_dmem_addr => o_dmem_addr,
        o_dmem_data => o_dmem_data,
        i_dmem_data => i_dmem_data
        );

    -- Clock process definitions
    i_clk_process :process
    begin
        wait for i_clk_period/2;
        i_clk <= not i_clk;
    end process;
    
    imem_process : process(i_clk)
    begin
        if rising_edge(i_clk) then
            i_instr <= s_instr_rom(to_integer(unsigned(o_pc(31 downto 2))));
        end if;
    end process;
    
    dmem_process : process(i_clk)
    begin
        if rising_edge(i_clk) then
            if o_dmem_en = '1' then
                i_dmem_data <= s_data_ram(to_integer(unsigned(o_dmem_addr)));
                
                for i in 0 to 3 loop
                    if o_dmem_we(i) = '1' then
                        s_data_ram(to_integer(unsigned(o_dmem_addr)))(8*i+7 downto 8*i) <= o_dmem_data(8*i+7 downto 8*i);
                    end if;
                end loop;
            end if;
        end if;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- insert stimulus here

        wait;
    end process;

end;
