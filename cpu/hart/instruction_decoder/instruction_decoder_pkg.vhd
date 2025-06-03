
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package instruction_decoder_pkg is

    function decode_imm_i(instr: std_logic_vector(31 downto 0)) return signed;
    function decode_imm_s(instr: std_logic_vector(31 downto 0)) return signed;
    function decode_imm_b(instr: std_logic_vector(31 downto 0)) return signed;
    function decode_imm_u(instr: std_logic_vector(31 downto 0)) return signed;
    function decode_imm_j(instr: std_logic_vector(31 downto 0)) return signed;

end instruction_decoder_pkg;

package body instruction_decoder_pkg is

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

end instruction_decoder_pkg;
