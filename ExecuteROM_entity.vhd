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
ENTITY ExecuteROM IS
 GENERIC(Adr : POSITIVE := 4;
 Dat : POSITIVE := 13);
 PORT(Address : IN std_logic_vector(Adr - 1 DOWNTO 0);
 Data : OUT std_logic_vector(Dat - 1 DOWNTO 0));
END ENTITY ExecuteROM;
--
ARCHITECTURE Behavior OF ExecuteROM IS
 TYPE rom_array IS ARRAY (0 TO 2**Adr - 1) OF
 std_ulogic_vector(Dat - 1 DOWNTO 0);

 CONSTANT ROM : rom_array := ( "1111101100100", -- Control vector for opcode 0
                               "1111100100100", -- Control vector for opcode 1
                               "1111100011000", -- Control vector for opcode 2
                               "1111100011000", -- Control vector for opcode 3
                               "0000000111000", -- Control vector for opcode 4
                               "0000000101100", -- Control vector for opcode 5
                               "0000000100100", -- Control vector for opcode 6
                               "0000000010100", -- Control vector for opcode 7
                               "0000000000001", -- Control vector for opcode 8
                               "0000010000001", -- Control vector for opcode 9
                               "0000010000010", -- Control vector for opcode 10
                               "0000000000000", -- Control vector for opcode 11
                               "1000000000011", -- Control vector for opcode 12
                               "0100010000011", -- Control vector for opcode 13
                               "0100010000011", -- Control vector for opcode 14
                               "0000000000000");-- Control vector for opcode 15

BEGIN
 Data <= ROM(to_integer(unsigned(Address)));
END ARCHITECTURE Behavior;