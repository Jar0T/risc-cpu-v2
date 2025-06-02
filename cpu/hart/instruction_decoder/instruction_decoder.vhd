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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_decoder is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_instruction : in std_logic_vector(31 downto 0);
        o_ra : out integer range 0 to 31;
        o_rb : out integer range 0 to 31;
        o_rd : out integer range 0 to 31;
        o_alu_func : out std_logic;
        o_funct3 : out std_logic_vector(2 downto 0);
        o_imm : out signed(31 downto 0)
    );
end instruction_decoder;

architecture Behavioral of instruction_decoder is

    signal s_ra, s_rb, s_rd : integer range 0 to 31 := 0;
    signal s_funct3 : std_logic_vector(2 downto 0) := (others => '0');
    signal s_imm : signed(31 downto 0) := (others => '0');
    signal s_alu_func : std_logic := '0';
    
    function decode_imm_i(instr: std_logic_vector(31 downto 0)) return signed is
        variable imm : std_logic_vector(11 downto 0);
    begin
        imm := instr(31 downto 20);
        return resize(signed(imm), 32);
    end function;
    
    function decode_imm_s(instr: std_logic_vector(31 downto 0)) return signed is
        variable imm : std_logic_vector(11 downto 0);
    begin
        imm := instr(31 downto 25) & instr(11 downto 7);
        return resize(signed(imm), 32);
    end function;
    
    function decode_imm_b(instr: std_logic_vector(31 downto 0)) return signed is
        variable imm : std_logic_vector(12 downto 0);
    begin
        imm := instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0';
        return resize(signed(imm), 32);
    end function;
    
    function decode_imm_u(instr: std_logic_vector(31 downto 0)) return signed is
        variable imm : std_logic_vector(31 downto 0);
    begin
        imm := instr(31 downto 12) & X"000";
        return signed(imm);
    end function;
    
    function decode_imm_j(instr: std_logic_vector(31 downto 0)) return signed is
        variable imm : std_logic_vector(20 downto 0);
    begin
        imm := instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0';
        return resize(signed(imm), 32);
    end function;

begin

    o_ra <= s_ra;
    o_rb <= s_rb;
    o_rd <= s_rd;
    o_funct3 <= s_funct3;
    o_alu_func <= s_alu_func;

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_ra <= 0;
                s_rb <= 0;
                s_rd <= 0;
                s_funct3 <= (others => '0');
                s_imm <= (others => '0');
                s_alu_func <= '0';
            else
                s_ra <= to_integer(unsigned(i_instruction(19 downto 15)));
                s_rb <= to_integer(unsigned(i_instruction(24 downto 20)));
                s_rd <= to_integer(unsigned(i_instruction(11 downto 7)));
                
                s_funct3 <= i_instruction(14 downto 12);
                s_imm <= (others => '0');
                
                case i_instruction(6 downto 2) is
                    when "01101" => -- LUI
                        s_imm <= decode_imm_u(i_instruction);
                    when "00101" => -- AUIPC
                        s_imm <= decode_imm_u(i_instruction);
                    when "11011" => -- JAL
                        s_imm <= decode_imm_j(i_instruction);
                    when "11001" => -- JALR
                        s_imm <= decode_imm_i(i_instruction);
                    when "11000" => -- BRANCH
                        s_imm <= decode_imm_b(i_instruction);
                    when "00000" => -- LOAD
                        s_imm <= decode_imm_i(i_instruction);
                    when "01000" => -- STORE
                        s_imm <= decode_imm_s(i_instruction);
                    when "00100" => -- ALUI
                        s_imm <= decode_imm_i(i_instruction);
                        if i_instruction(14 downto 12) = "000" then
                            s_alu_func <= '0';
                        else
                            s_alu_func <= i_instruction(30);
                        end if;
                    when "01100" => -- ALU
                        s_alu_func <= i_instruction(30);
                    when "00011" => -- MISC-MEM
                    when "11100" => -- SYSTEM
                    when others =>
                end case;
            end if;
        end if;
    end process;

end Behavioral;

