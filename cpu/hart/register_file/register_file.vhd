----------------------------------------------------------------------------------
-- Company: 
-- Engineer:        Jarosław Tumula
-- 
-- Create Date:     18:26:12 05/30/2025 
-- Design Name: 
-- Module Name:     register_file - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_file is
    Port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_addr_a : in std_logic_vector (4 downto 0);
        i_addr_b : in std_logic_vector (4 downto 0);
        i_addr_d : in std_logic_vector (4 downto 0);
        o_data_a : out std_logic_vector (31 downto 0);
        o_data_b : out std_logic_vector (31 downto 0);
        i_data_d : in std_logic_vector (31 downto 0);
        i_oe_a : in std_logic;
        i_oe_b : in std_logic;
        i_we_d : in std_logic
    );
end register_file;

architecture Behavioral of register_file is

begin


end Behavioral;

