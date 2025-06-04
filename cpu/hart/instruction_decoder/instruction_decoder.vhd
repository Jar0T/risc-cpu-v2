----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
-- 
-- Create Date:     17:31:18 06/02/2025 
-- Design Name: 
-- Module Name:     instruction_decoder - Behavioral 
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
use ieee.numeric_std.all;

library work;
use work.instruction_decoder_pkg.all;
use work.hart_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_decoder is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_valid : in std_logic;
        i_instruction : in std_logic_vector(31 downto 0);
        o_imm : out signed(31 downto 0);
        o_control_signals : out t_control_signals
    );
end instruction_decoder;

architecture Behavioral of instruction_decoder is

    signal s_imm : signed(31 downto 0) := (others => '0');
    signal s_control_signals : t_control_signals := CONTROL_SIGNALS_DEFAULT;

begin

    o_imm <= s_imm;
    o_control_signals <= s_control_signals;

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_imm <= (others => '0');
                s_control_signals <= CONTROL_SIGNALS_DEFAULT;
            else
                if i_valid = '1' then
                    s_imm <= (others => '0');
                    
                    s_control_signals.ra <= to_integer(unsigned(i_instruction(19 downto 15)));
                    s_control_signals.rb <= to_integer(unsigned(i_instruction(24 downto 20)));
                    s_control_signals.rd <= to_integer(unsigned(i_instruction(11 downto 7)));
                    s_control_signals.funct3 <= i_instruction(14 downto 12);
                    s_control_signals.funct4 <= (others => '0');
                    s_control_signals.alu_src_a <= ALU_SRC_A_RS1;
                    s_control_signals.alu_src_b <= ALU_SRC_B_RS2;
                    s_control_signals.jump <= '0';
                    s_control_signals.branch <= '0';
                    s_control_signals.mem_read <= '0';
                    s_control_signals.mem_write <= '0';
                    s_control_signals.register_write <= '0';
                    s_control_signals.result_select <= ALU;
                    
                    case i_instruction(6 downto 2) is
                        when OPCODE_LUI =>
                            s_imm <= decode_imm_u(i_instruction);
                            s_control_signals.register_write <= '1';
                            s_control_signals.result_select <= IMMEDIATE;
                        when OPCODE_AUIPC =>
                            s_imm <= decode_imm_u(i_instruction);
                            s_control_signals.funct4 <= "0000";
                            s_control_signals.alu_src_a <= ALU_SRC_A_PC;
                            s_control_signals.alu_src_b <= ALU_SRC_B_IMM;
                            s_control_signals.register_write <= '1';
                            s_control_signals.result_select <= ALU;
                        when OPCODE_JAL =>
                            s_imm <= decode_imm_j(i_instruction);
                            s_control_signals.funct4 <= "0000";
                            s_control_signals.alu_src_a <= ALU_SRC_A_PC;
                            s_control_signals.alu_src_b <= ALU_SRC_B_IMM;
                            s_control_signals.jump <= '1';
                            s_control_signals.register_write <= '1';
                            s_control_signals.result_select <= PC_PLUS_4;
                        when OPCODE_JALR =>
                            s_imm <= decode_imm_i(i_instruction);
                            s_control_signals.funct4 <= "0000";
                            s_control_signals.alu_src_a <= ALU_SRC_A_RS1;
                            s_control_signals.alu_src_b <= ALU_SRC_B_IMM;
                            s_control_signals.jump <= '1';
                            s_control_signals.register_write <= '1';
                            s_control_signals.result_select <= PC_PLUS_4;
                        when OPCODE_BRANCH =>
                            s_imm <= decode_imm_b(i_instruction);
                            s_control_signals.funct4 <= "0000";
                            s_control_signals.alu_src_a <= ALU_SRC_A_PC;
                            s_control_signals.alu_src_b <= ALU_SRC_B_IMM;
                            s_control_signals.branch <= '1';
                        when OPCODE_LOAD =>
                            s_imm <= decode_imm_i(i_instruction);
                            s_control_signals.funct4 <= "0000";
                            s_control_signals.alu_src_a <= ALU_SRC_A_RS1;
                            s_control_signals.alu_src_b <= ALU_SRC_B_IMM;
                            s_control_signals.mem_read <= '1';
                            s_control_signals.register_write <= '1';
                            s_control_signals.result_select <= MEMORY;
                        when OPCODE_STORE =>
                            s_imm <= decode_imm_s(i_instruction);
                            s_control_signals.funct4 <= "0000";
                            s_control_signals.alu_src_a <= ALU_SRC_A_RS1;
                            s_control_signals.alu_src_b <= ALU_SRC_B_IMM;
                            s_control_signals.mem_write <= '1';
                        when OPCODE_OP_IMM =>
                            s_imm <= decode_imm_i(i_instruction);
                            if i_instruction(14 downto 12) = "000" then
                                s_control_signals.funct4 <= '0' & i_instruction(14 downto 12);
                            else
                                s_control_signals.funct4 <= i_instruction(30) & i_instruction(14 downto 12);
                            end if;
                            s_control_signals.alu_src_a <= ALU_SRC_A_RS1;
                            s_control_signals.alu_src_b <= ALU_SRC_B_IMM;
                            s_control_signals.register_write <= '1';
                            s_control_signals.result_select <= ALU;
                        when OPCODE_OP =>
                            s_control_signals.funct4 <= i_instruction(30) & i_instruction(14 downto 12);
                            s_control_signals.alu_src_a <= ALU_SRC_A_RS1;
                            s_control_signals.alu_src_b <= ALU_SRC_B_RS2;
                            s_control_signals.register_write <= '1';
                            s_control_signals.result_select <= ALU;
                        when OPCODE_MISC_MEM =>
                        when OPCODE_SYSTEM =>
                        when others =>
                    end case;
                end if;
            end if;
        end if;
    end process;

end Behavioral;

