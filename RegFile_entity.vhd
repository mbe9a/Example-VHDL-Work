--
-- VHDL Entity Lab4_lib.RegFile.arch_name
--
-- Created:
--          by - Michael.UNKNOWN (TCHAIKOVSKY)
--          at - 21:58:34 02/ 8/2016
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY RegFile IS

  GENERIC(RegWidth : positive := 16; -- bits in each register
          RegSel : positive := 4); -- bits required to select a register
          
  PORT( D : IN std_logic_vector(RegWidth - 1 DOWNTO 0); -- data input
        Q0, Q1 : OUT std_logic_vector(RegWidth - 1 DOWNTO 0); -- data output
        ReadSelect0, ReadSelect1, WriteSelect : IN std_logic_vector(RegSel - 1 DOWNTO 0);
        clock, enable_write, rst : IN std_logic);

END ENTITY RegFile;

architecture Behavior of RegFile is
  signal ReadDecoded0, ReadDecoded1, WriteDecoded : std_logic_vector((2**RegSel) - 1 DOWNTO 0);
  
begin
  RegArray : for i in 0 to ((2**RegSel) - 1) generate
  begin
    Regi : entity work.reg(struct)
      port map(rst => rst, D => D, Q0 => Q0, Q1 => Q1, clk => clock, load => WriteDecoded(i), read0 => ReadDecoded0(i), read1 => ReadDecoded1(i));
  end generate RegArray;
  
  Decoder_Write : entity work.Decoder(Behavior)
    generic map(controls => RegSel)
    port map(sel => WriteSelect, onehot => WriteDecoded, enable => enable_write);
      
  Decoder_Read0 : entity work.Decoder(Behavior)
    generic map(controls => RegSel)
    port map (sel => ReadSelect0, onehot => ReadDecoded0, enable => '1');
      
  Decoder_Read1 : entity work.Decoder(Behavior)
    generic map(controls => RegSel)
    port map (sel => ReadSelect1, onehot => ReadDecoded1, enable => '1');
  
end architecture Behavior;