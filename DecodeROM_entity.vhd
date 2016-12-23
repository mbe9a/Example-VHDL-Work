--
-- VHDL Entity stage_processor_lib.DecodeRom.arch_name
--
-- Created:
--          by - Michael.UNKNOWN (TCHAIKOVSKY)
--          at - 18:55:20 03/21/2016
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
ENTITY DecodeROM IS
 GENERIC(Adr : POSITIVE := 3;
 Dat : POSITIVE := 15);
 PORT(Address : IN std_logic_vector(Adr - 1 DOWNTO 0);
 Data : OUT std_logic_vector(Dat - 1 DOWNTO 0));
END ENTITY DecodeROM;
--
ARCHITECTURE Behavior OF DecodeROM IS
 TYPE rom_array IS ARRAY (0 TO 2**Adr - 1) OF
 std_ulogic_vector(Dat - 1 DOWNTO 0);

 CONSTANT ROM : rom_array := ( "001010001000000", -- Control vector for opcode 0
                               "010100001010100", -- Control vector for opcode 1
                               "100101001010110", -- Control vector for opcode 2
                               "000100001000100", -- Control vector for opcode 3
                               "000101001000001", -- Control vector for opcode 4
                               "000100000101100", -- Control vector for opcode 5
                               "001101011111111", -- Control vector for opcode 6
                               "000000101111000");-- Control vector for opcode 7

BEGIN
 Data <= ROM(to_integer(unsigned(Address)));
END ARCHITECTURE Behavior;