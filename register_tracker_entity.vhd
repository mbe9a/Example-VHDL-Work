--
-- VHDL Entity stage_processor_lib.register_tracker.arch_name
--
-- Created:
--          by - Michael.UNKNOWN (TCHAIKOVSKY)
--          at - 20:11:17 04/11/2016
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY register_tracker IS
  GENERIC(RegSel : positive := 4); -- bits required to select a register
          
  PORT( Q0, Q1 : OUT std_logic; -- data output
        ReadSelect0, ReadSelect1, load, set : IN std_logic_vector(RegSel - 1 DOWNTO 0);
        clock, load_enable, set_enable, rst : IN std_logic);
END ENTITY register_tracker;

architecture behavior of register_tracker is
  signal ReadDecoded0, ReadDecoded1, loadDecoded, setDecoded : std_logic_vector((2**RegSel) - 1 DOWNTO 0);
  
begin
  RegArray : for i in 0 to ((2**RegSel) - 1) generate
  begin
    Regi : entity work.tracker_register_unit(struct)
      port map(set => setDecoded(i), Q0 => Q0, Q1 => Q1, clk => clock, load => loadDecoded(i), read0 => ReadDecoded0(i), read1 => ReadDecoded1(i), rst => rst);
  end generate RegArray;
  
  Decoder_Set : entity work.Decoder(Behavior)
    generic map(controls => RegSel)
    port map(sel => set, onehot => setDecoded, enable => set_enable);
  
  Decoder_Load : entity work.Decoder(Behavior)
    generic map(controls => RegSel)
    port map(sel => load, onehot => loadDecoded, enable => load_enable);
      
  Decoder_Read0 : entity work.Decoder(Behavior)
    generic map(controls => RegSel)
    port map (sel => ReadSelect0, onehot => ReadDecoded0, enable => '1');
      
  Decoder_Read1 : entity work.Decoder(Behavior)
    generic map(controls => RegSel)
    port map (sel => ReadSelect1, onehot => ReadDecoded1, enable => '1');
      
end architecture behavior;