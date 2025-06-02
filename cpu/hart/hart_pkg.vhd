--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package hart_pkg is

    type t_result_select is (ALU, MEMORY, IMMEDIATE, PC_PLUS_4);
    
    type t_control_signals is record
        ra : integer range 0 to 31;
        rb : integer range 0 to 31;
        rd : integer range 0 to 31;
        funct3 : std_logic_vector(2 downto 0);
        funct4 : std_logic_vector(3 downto 0);
        alu_src_a : std_logic;                      -- 0 = rs1, 1 = PC
        alu_src_b : std_logic;                      -- 0 = rs2, 1 = imm
        jump : std_logic;
        branch : std_logic;
        mem_read : std_logic;
        mem_write : std_logic;
        register_write : std_logic;
        result_select : t_result_select;
    end record;
    
    constant OPCODE_LUI : std_logic_vector(4 downto 0) := "01101";
    constant OPCODE_AUIPC : std_logic_vector(4 downto 0) := "00101";
    constant OPCODE_JAL : std_logic_vector(4 downto 0) := "11011";
    constant OPCODE_JALR : std_logic_vector(4 downto 0) := "11001";
    constant OPCODE_BRANCH : std_logic_vector(4 downto 0) := "11000";
    constant OPCODE_LOAD : std_logic_vector(4 downto 0) := "00000";
    constant OPCODE_STORE : std_logic_vector(4 downto 0) := "01000";
    constant OPCODE_OP_IMM : std_logic_vector(4 downto 0) := "00100";
    constant OPCODE_OP : std_logic_vector(4 downto 0) := "01100";
    constant OPCODE_MISC_MEM : std_logic_vector(4 downto 0) := "00011";
    constant OPCODE_SYSTEM : std_logic_vector(4 downto 0) := "11100";
    
    constant ALU_SRC_A_RS1 : std_logic := '0';
    constant ALU_SRC_A_PC : std_logic := '1';
    constant ALU_SRC_B_RS2 : std_logic := '0';
    constant ALU_SRC_B_IMM : std_logic := '1';
    
    constant CONTROL_SIGNALS_DEFAULT : t_control_signals := (
        ra => 0,
        rb => 0,
        rd => 0,
        funct3 => (others => '0'),
        funct4 => (others => '0'),
        alu_src_a => ALU_SRC_A_RS1,
        alu_src_b => ALU_SRC_B_RS2,
        jump => '0',
        branch => '0',
        mem_read => '0',
        mem_write => '0',
        register_write => '0',
        result_select => ALU
    );

end hart_pkg;

package body hart_pkg is

end hart_pkg;
