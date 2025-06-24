----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jar0T
-- 
-- Create Date:     17:53:30 05/30/2025 
-- Design Name: 
-- Module Name:     hart - RTL 
-- Project Name:    risc-cpu-v2
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.hart_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hart is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        
        o_pc : out std_logic_vector(31 downto 0);
        i_instr : in std_logic_vector(31 downto 0);
        
        o_dmem_en : out std_logic;
        o_dmem_we : out std_logic_vector(3 downto 0);
        o_dmem_addr : out std_logic_vector(29 downto 0);
        o_dmem_data : out std_logic_vector(31 downto 0);
        i_dmem_data : in std_logic_vector(31 downto 0)
    );
end hart;

architecture RTL of hart is

    component program_counter is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_we : in std_logic;
        i_pc : in std_logic_vector(31 downto 0);
        o_pc : out std_logic_vector(31 downto 0);
        o_pc_plus_4 : out std_logic_vector(31 downto 0)
    );
    end component;

    component instruction_decoder is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_valid : in std_logic;
        i_instruction : in std_logic_vector(31 downto 0);
        o_imm : out std_logic_vector(31 downto 0);
        o_control_signals : out t_control_signals
    );
    end component;

    component register_file is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_addr_a : in integer range 0 to 31;
        i_addr_b : in integer range 0 to 31;
        i_addr_d : in integer range 0 to 31;
        o_data_a : out std_logic_vector(31 downto 0);
        o_data_b : out std_logic_vector(31 downto 0);
        i_data_d : in std_logic_vector(31 downto 0);
        i_we_d : in std_logic
    );
    end component;
    
    component execute_unit is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_funct4 : in std_logic_vector(3 downto 0);
        i_funct3 : in std_logic_vector(2 downto 0);
        i_a : in std_logic_vector(31 downto 0);
        i_b : in std_logic_vector(31 downto 0);
        i_rs1 : in std_logic_vector(31 downto 0);
        i_rs2 : in std_logic_vector(31 downto 0);
        o_y : out std_logic_vector(31 downto 0);
        o_cmp_resut : out std_logic
    );
    end component;
    
    component memory_setup is
    port (
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
    
    component memory_readback is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_read : in std_logic;
        i_funct3 : in std_logic_vector(2 downto 0);
        i_addr_low : in std_logic_vector(1 downto 0);
        i_data : in std_logic_vector(31 downto 0);
        o_data : out std_logic_vector(31 downto 0)
    );
    end component;
    
    component write_back is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_we : in std_logic;
        i_result_select : in t_result_select;
        i_alu : in std_logic_vector(31 downto 0);
        i_memory : in std_logic_vector(31 downto 0);
        i_immediate : in std_logic_vector(31 downto 0);
        i_pc_plus_4 : in std_logic_vector(31 downto 0);
        o_data : out std_logic_vector(31 downto 0);
        o_we : out std_logic
    );
    end component;
    
    component branch_unit is
    port (
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

    signal s_pc, s_pc_plus_4 : std_logic_vector(31 downto 0) := (others => '0');

    signal s_pc_imem, s_pc_plus_4_imem : std_logic_vector(31 downto 0) := (others => '0');
    
    signal s_imm : std_logic_vector(31 downto 0) := (others => '0');
    signal s_control_signals : t_control_signals := CONTROL_SIGNALS_DEFAULT;
    signal s_pc_decoder, s_pc_plus_4_decoder : std_logic_vector(31 downto 0) := (others => '0');
    
    signal s_rs1, s_rs2 : std_logic_vector(31 downto 0) := (others => '0');
    signal s_pc_reg_file, s_pc_plus_4_reg_file : std_logic_vector(31 downto 0) := (others => '0');
    signal s_imm_reg_file : std_logic_vector(31 downto 0) := (others => '0');
    signal s_control_signals_reg_file : t_control_signals := CONTROL_SIGNALS_DEFAULT;
    
    signal s_data_a, s_data_b : std_logic_vector(31 downto 0) := (others => '0');
    signal s_result : std_logic_vector(31 downto 0) := (others => '0');
    signal s_cmp_result : std_logic := '0';
    signal s_pc_plus_4_execute : std_logic_vector(31 downto 0) := (others => '0');
    signal s_rs2_execute : std_logic_vector(31 downto 0) := (others => '0');
    signal s_imm_execute : std_logic_vector(31 downto 0) := (others => '0');
    signal s_control_signals_execute : t_control_signals := CONTROL_SIGNALS_DEFAULT;
    
    signal s_pc_plus_4_mem_setup : std_logic_vector(31 downto 0) := (others => '0');
    signal s_result_mem_setup : std_logic_vector(31 downto 0) := (others => '0');
    signal s_imm_mem_setup : std_logic_vector(31 downto 0) := (others => '0');
    signal s_control_signals_mem_setup : t_control_signals := CONTROL_SIGNALS_DEFAULT;
    
    signal s_pc_plus_4_dmem : std_logic_vector(31 downto 0) := (others => '0');
    signal s_result_dmem : std_logic_vector(31 downto 0) := (others => '0');
    signal s_imm_dmem : std_logic_vector(31 downto 0) := (others => '0');
    signal s_control_signals_dmem : t_control_signals := CONTROL_SIGNALS_DEFAULT;
    
    signal s_mem_data : std_logic_vector(31 downto 0) := (others => '0');
    signal s_pc_plus_4_mem_read : std_logic_vector(31 downto 0) := (others => '0');
    signal s_result_mem_read : std_logic_vector(31 downto 0) := (others => '0');
    signal s_imm_mem_read : std_logic_vector(31 downto 0) := (others => '0');
    signal s_control_signals_mem_read : t_control_signals := CONTROL_SIGNALS_DEFAULT;
    
    signal s_write_back_data : std_logic_vector(31 downto 0) := (others => '0');
    signal s_write_back_en : std_logic := '0';
    
    
    signal s_branch_addr : std_logic_vector(31 downto 0) := (others => '0');
    signal s_pc_select : std_logic := '0';

begin

    o_pc <= s_pc;

    i_program_counter : program_counter port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_we => s_pc_select,
        i_pc => s_branch_addr,
        o_pc => s_pc,
        o_pc_plus_4 => s_pc_plus_4
    );

    i_instruction_decoder : instruction_decoder port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_valid => '1',
        i_instruction => i_instr,
        o_imm => s_imm,
        o_control_signals => s_control_signals
    );
    
    i_register_file : register_file port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_addr_a => s_control_signals.ra,
        i_addr_b => s_control_signals.rb,
        i_addr_d => s_control_signals.rd,
        o_data_a => s_rs1,
        o_data_b => s_rs2,
        i_data_d => s_write_back_data,
        i_we_d => s_write_back_en
    );
    
    s_data_a <= s_rs1 when s_control_signals_reg_file.alu_src_a = '0' else s_pc_reg_file;
    s_data_b <= s_rs2 when s_control_signals_reg_file.alu_src_b = '0' else s_imm_reg_file;
    
    i_execute_unit : execute_unit port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_func => s_control_signals_reg_file.funct4,
        i_funct3 => s_control_signals_reg_file.funct3,
        i_a => s_data_a,
        i_b => s_data_b,
        i_rs1 => s_rs1,
        i_rs2 => s_rs2,
        o_y => s_result,
        o_result => s_cmp_result
    );
    
    i_memory_setup : memory_setup port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_read => s_control_signals_execute.mem_read,
        i_write => s_control_signals_execute.mem_write,
        i_funct3 => s_control_signals_execute.funct3,
        i_rs2 => s_rs2_execute,
        i_addr => s_result,
        o_en => o_dmem_en,
        o_we => o_dmem_we,
        o_data => o_dmem_data,
        o_addr => o_dmem_addr
    );
     
    i_memory_readback : memory_readback port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_read => s_control_signals_dmem.mem_read,
        i_funct3 => s_control_signals_dmem.funct3,
        i_addr_low => s_result_dmem(1 downto 0),
        i_data => i_dmem_data,
        o_data => s_mem_data
    );
    
    i_write_back : write_back port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_we => s_control_signals_mem_read.register_write,
        i_result_select => s_control_signals_mem_read.result_select,
        i_alu => s_result_mem_read,
        i_memory => s_mem_data,
        i_immediate => s_imm_mem_read,
        i_pc_plus_4 => s_pc_plus_4_mem_read,
        o_data => s_write_back_data,
        o_we => s_write_back_en
    );
    
    i_branch_unit : branch_unit port map(
        i_clk => i_clk,
        i_reset => i_reset,
        i_jump => s_control_signals_execute.jump,
        i_branch => s_control_signals_execute.branch,
        i_take_branch => s_cmp_result,
        i_branch_addr => s_result,
        o_branch_addr => s_branch_addr,
        o_pc_select => s_pc_select
    );
    
    imem_registers : process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_pc_imem <= (others => '0');
                s_pc_plus_4_imem <= (others => '0');
            else
                s_pc_imem <= s_pc;
                s_pc_plus_4_imem <= s_pc_plus_4;
            end if;
        end if;
    end process imem_registers;
    
    decoder_registers : process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_pc_decoder <= (others => '0');
                s_pc_plus_4_decoder <= (others => '0');
            else
                s_pc_decoder <= s_pc_imem;
                s_pc_plus_4_decoder <= s_pc_plus_4_imem;
            end if;
        end if;
    end process decoder_registers;
    
    reg_file_registers : process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_pc_reg_file <= (others => '0');
                s_pc_plus_4_reg_file <= (others => '0');
                s_imm_reg_file <= (others => '0');
                s_control_signals_reg_file <= CONTROL_SIGNALS_DEFAULT;
            else
                s_pc_reg_file <= s_pc_decoder;
                s_pc_plus_4_reg_file <= s_pc_plus_4_decoder;
                s_imm_reg_file <= s_imm;
                s_control_signals_reg_file <= s_control_signals;
            end if;
        end if;
    end process reg_file_registers;
    
    execute_registers : process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_pc_plus_4_execute <= (others => '0');
                s_rs2_execute <= (others => '0');
                s_imm_execute <= (others => '0');
                s_control_signals_execute <= CONTROL_SIGNALS_DEFAULT;
            else
                s_pc_plus_4_execute <= s_pc_plus_4_reg_file;
                s_rs2_execute <= s_rs2;
                s_imm_execute <= s_imm_reg_file;
                s_control_signals_execute <= s_control_signals_reg_file;
            end if;
        end if;
    end process execute_registers;
    
    mem_setup_registers : process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_pc_plus_4_mem_setup <= (others => '0');
                s_result_mem_setup <= (others => '0');
                s_imm_mem_setup <= (others => '0');
                s_control_signals_mem_setup <= CONTROL_SIGNALS_DEFAULT;
            else
                s_pc_plus_4_mem_setup <= s_pc_plus_4_execute;
                s_result_mem_setup <= s_result;
                s_imm_mem_setup <= s_imm_execute;
                s_control_signals_mem_setup <= s_control_signals_execute;
            end if;
        end if;
    end process mem_setup_registers;
    
    dmem_registers : process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_pc_plus_4_dmem <= (others => '0');
                s_result_dmem <= (others => '0');
                s_imm_dmem <= (others => '0');
                s_control_signals_dmem <= CONTROL_SIGNALS_DEFAULT;
            else
                s_pc_plus_4_dmem <= s_pc_plus_4_mem_setup;
                s_result_dmem <= s_result_mem_setup;
                s_imm_dmem <= s_imm_mem_setup;
                s_control_signals_dmem <= s_control_signals_mem_setup;
            end if;
        end if;
    end process dmem_registers;
    
    mem_readback_registers : process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_pc_plus_4_mem_read <= (others => '0');
                s_result_mem_read <= (others => '0');
                s_imm_mem_read <= (others => '0');
                s_control_signals_mem_read <= CONTROL_SIGNALS_DEFAULT;
            else
                s_pc_plus_4_mem_read <= s_pc_plus_4_dmem;
                s_result_mem_read <= s_result_dmem;
                s_imm_mem_read <= s_imm_dmem;
                s_control_signals_mem_read <= s_control_signals_dmem;
            end if;
        end if;
    end process mem_readback_registers;

end RTL;

