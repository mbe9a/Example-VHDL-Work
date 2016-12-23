--
-- VHDL Entity Lab4_lib.Decoder.arch_name
--
-- Created:
--          by - Michael.UNKNOWN (TCHAIKOVSKY)
--          at - 23:40:04 02/ 8/2016
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Decoder IS
  generic(controls : positive := 2);
  PORT(sel : IN std_logic_vector(controls-1 downto 0);
        onehot : OUT std_logic_vector((2**controls)-1 downto 0);
        enable : IN std_logic);
END ENTITY Decoder;

architecture Behavior of Decoder is
begin
  process(sel, enable)
    variable selection : natural;
    variable result : std_logic_vector((2**controls)-1 downto 0);
    constant zero : std_logic_vector((2**controls)-1 downto 0) := (others => '0');
    begin
      result := zero;
      if(enable = '1') then
        selection := To_Integer(unsigned(sel));
        result(selection) := '1';
      end if;
      onehot <= result;
  end process;
end architecture Behavior;