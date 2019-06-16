
library ieee;
library work;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
-- read delay is 2 cycles

entity twiddleRom4096 is
	port(clk: in std_logic;
			romAddr: in unsigned(9-1 downto 0);
			romData: out std_logic_vector(30-1 downto 0)
			);
end entity;
architecture a of twiddleRom4096 is
	constant romDepthOrder: integer := 9;
	constant romDepth: integer := 2**romDepthOrder;
	constant romWidth: integer := 30;
	--ram
	type ram1t is array(0 to romDepth-1) of
		std_logic_vector(romWidth-1 downto 0);
	signal rom: ram1t;
	signal addr1: unsigned(romDepthOrder-1 downto 0) := (others=>'0');
	signal data0,data1: std_logic_vector(romWidth-1 downto 0) := (others=>'0');
begin
	addr1 <= romAddr when rising_edge(clk);
	data0 <= rom(to_integer(addr1));
	data1 <= data0 when rising_edge(clk);
	romData <= data1;
	rom <= (
"000000000110010111111111111111" , "000000001100101111111111111111" , "000000010010111111111111111111" , "000000011001001111111111111111" , "000000011111011111111111111111" , "000000100101110111111111111111" , "000000101100000111111111111110" , "000000110010010111111111111110" , "000000111000100111111111111101" , "000000111110111111111111111100"
, "000001000101001111111111111011" , "000001001011011111111111111010" , "000001010001101111111111111001" , "000001011000000111111111111000" , "000001011110010111111111110111" , "000001100100100111111111110110" , "000001101010110111111111110101" , "000001110001001111111111110100" , "000001110111011111111111110010" , "000001111101101111111111110001"
, "000010000011111111111111101111" , "000010001010010111111111101101" , "000010010000100111111111101100" , "000010010110110111111111101010" , "000010011101000111111111101000" , "000010100011011111111111100110" , "000010101001101111111111100100" , "000010101111111111111111100010" , "000010110110001111111111100000" , "000010111100011111111111011101"
, "000011000010110111111111011011" , "000011001001000111111111011001" , "000011001111010111111111010110" , "000011010101100111111111010011" , "000011011011110111111111010001" , "000011100010001111111111001110" , "000011101000011111111111001011" , "000011101110101111111111001000" , "000011110100111111111111000101" , "000011111011001111111111000010"
, "000100000001100111111110111111" , "000100000111110111111110111100" , "000100001110000111111110111001" , "000100010100010111111110110101" , "000100011010100111111110110010" , "000100100000110111111110101110" , "000100100111000111111110101011" , "000100101101011111111110100111" , "000100110011101111111110100011" , "000100111001111111111110100000"
, "000101000000001111111110011100" , "000101000110011111111110011000" , "000101001100101111111110010100" , "000101010010111111111110010000" , "000101011001001111111110001011" , "000101011111011111111110000111" , "000101100101101111111110000011" , "000101101100000111111101111110" , "000101110010010111111101111010" , "000101111000100111111101110101"
, "000101111110110111111101110001" , "000110000101000111111101101100" , "000110001011010111111101100111" , "000110010001100111111101100010" , "000110010111110111111101011101" , "000110011110000111111101011000" , "000110100100010111111101010011" , "000110101010100111111101001110" , "000110110000110111111101001001" , "000110110111000111111101000011"
, "000110111101010111111100111110" , "000111000011100111111100111000" , "000111001001110111111100110011" , "000111010000000111111100101101" , "000111010110010111111100100111" , "000111011100100111111100100010" , "000111100010101111111100011100" , "000111101000111111111100010110" , "000111101111001111111100010000" , "000111110101011111111100001010"
, "000111111011101111111100000011" , "001000000001111111111011111101" , "001000001000001111111011110111" , "001000001110011111111011110000" , "001000010100100111111011101010" , "001000011010110111111011100011" , "001000100001000111111011011101" , "001000100111010111111011010110" , "001000101101100111111011001111" , "001000110011110111111011001000"
, "001000111001111111111011000001" , "001001000000001111111010111010" , "001001000110011111111010110011" , "001001001100101111111010101100" , "001001010010110111111010100101" , "001001011001000111111010011101" , "001001011111010111111010010110" , "001001100101011111111010001110" , "001001101011101111111010000111" , "001001110001111111111001111111"
, "001001111000001111111001111000" , "001001111110010111111001110000" , "001010000100100111111001101000" , "001010001010101111111001100000" , "001010010000111111111001011000" , "001010010111001111111001010000" , "001010011101010111111001001000" , "001010100011100111111000111111" , "001010101001101111111000110111" , "001010101111111111111000101111"
, "001010110110001111111000100110" , "001010111100010111111000011110" , "001011000010100111111000010101" , "001011001000101111111000001100" , "001011001110111111111000000011" , "001011010101000111110111111011" , "001011011011010111110111110010" , "001011100001011111110111101001" , "001011100111100111110111100000" , "001011101101110111110111010110"
, "001011110011111111110111001101" , "001011111010001111110111000100" , "001100000000010111110110111010" , "001100000110011111110110110001" , "001100001100101111110110100111" , "001100010010110111110110011110" , "001100011000111111110110010100" , "001100011111001111110110001010" , "001100100101010111110110000001" , "001100101011011111110101110111"
, "001100110001101111110101101101" , "001100110111110111110101100011" , "001100111101111111110101011000" , "001101000100000111110101001110" , "001101001010001111110101000100" , "001101010000011111110100111010" , "001101010110100111110100101111" , "001101011100101111110100100101" , "001101100010110111110100011010" , "001101101000111111110100001111"
, "001101101111000111110100000101" , "001101110101001111110011111010" , "001101111011010111110011101111" , "001110000001100111110011100100" , "001110000111101111110011011001" , "001110001101110111110011001110" , "001110010011111111110011000010" , "001110011010000111110010110111" , "001110100000001111110010101100" , "001110100110001111110010100000"
, "001110101100010111110010010101" , "001110110010011111110010001001" , "001110111000100111110001111110" , "001110111110101111110001110010" , "001111000100110111110001100110" , "001111001010111111110001011010" , "001111010001000111110001001110" , "001111010111000111110001000010" , "001111011101001111110000110110" , "001111100011010111110000101010"
, "001111101001011111110000011110" , "001111101111011111110000010001" , "001111110101100111110000000101" , "001111111011101111101111111001" , "010000000001110111101111101100" , "010000000111110111101111011111" , "010000001101111111101111010011" , "010000010011111111101111000110" , "010000011010000111101110111001" , "010000100000001111101110101100"
, "010000100110001111101110011111" , "010000101100010111101110010010" , "010000110010010111101110000101" , "010000111000011111101101111000" , "010000111110011111101101101010" , "010001000100100111101101011101" , "010001001010100111101101010000" , "010001010000100111101101000010" , "010001010110101111101100110100" , "010001011100101111101100100111"
, "010001100010110111101100011001" , "010001101000110111101100001011" , "010001101110110111101011111101" , "010001110100111111101011101111" , "010001111010111111101011100001" , "010010000000111111101011010011" , "010010000110111111101011000101" , "010010001100111111101010110111" , "010010010011000111101010101000" , "010010011001000111101010011010"
, "010010011111000111101010001100" , "010010100101000111101001111101" , "010010101011000111101001101110" , "010010110001000111101001100000" , "010010110111000111101001010001" , "010010111101000111101001000010" , "010011000011000111101000110011" , "010011001001000111101000100100" , "010011001111000111101000010101" , "010011010101000111101000000110"
, "010011011011000111100111110111" , "010011100001000111100111100111" , "010011100111000111100111011000" , "010011101101000111100111001001" , "010011110010111111100110111001" , "010011111000111111100110101010" , "010011111110111111100110011010" , "010100000100111111100110001010" , "010100001010110111100101111010" , "010100010000110111100101101010"
, "010100010110110111100101011011" , "010100011100101111100101001010" , "010100100010101111100100111010" , "010100101000101111100100101010" , "010100101110100111100100011010" , "010100110100100111100100001010" , "010100111010011111100011111001" , "010101000000011111100011101001" , "010101000110010111100011011000" , "010101001100010111100011001000"
, "010101010010001111100010110111" , "010101011000001111100010100110" , "010101011110000111100010010101" , "010101100011111111100010000101" , "010101101001111111100001110100" , "010101101111110111100001100011" , "010101110101101111100001010001" , "010101111011100111100001000000" , "010110000001100111100000101111" , "010110000111011111100000011110"
, "010110001101010111100000001100" , "010110010011001111011111111011" , "010110011001000111011111101001" , "010110011110111111011111011000" , "010110100100110111011111000110" , "010110101010101111011110110100" , "010110110000100111011110100010" , "010110110110011111011110010000" , "010110111100010111011101111110" , "010111000010001111011101101100"
, "010111001000000111011101011010" , "010111001101111111011101001000" , "010111010011110111011100110110" , "010111011001100111011100100011" , "010111011111011111011100010001" , "010111100101010111011011111110" , "010111101011001111011011101100" , "010111110000111111011011011001" , "010111110110110111011011000111" , "010111111100101111011010110100"
, "011000000010011111011010100001" , "011000001000010111011010001110" , "011000001110000111011001111011" , "011000010011111111011001101000" , "011000011001101111011001010101" , "011000011111100111011001000010" , "011000100101010111011000101110" , "011000101011001111011000011011" , "011000110000111111011000001000" , "011000110110101111010111110100"
, "011000111100100111010111100001" , "011001000010010111010111001101" , "011001001000000111010110111001" , "011001001101110111010110100110" , "011001010011101111010110010010" , "011001011001011111010101111110" , "011001011111001111010101101010" , "011001100100111111010101010110" , "011001101010101111010101000010" , "011001110000011111010100101101"
, "011001110110001111010100011001" , "011001111011111111010100000101" , "011010000001101111010011110000" , "011010000111011111010011011100" , "011010001101001111010011000111" , "011010010010111111010010110011" , "011010011000100111010010011110" , "011010011110010111010010001001" , "011010100100000111010001110101" , "011010101001110111010001100000"
, "011010101111011111010001001011" , "011010110101001111010000110110" , "011010111010111111010000100001" , "011011000000100111010000001011" , "011011000110010111001111110110" , "011011001011111111001111100001" , "011011010001101111001111001011" , "011011010111010111001110110110" , "011011011101000111001110100000" , "011011100010101111001110001011"
, "011011101000010111001101110101" , "011011101110000111001101011111" , "011011110011101111001101001010" , "011011111001010111001100110100" , "011011111110111111001100011110" , "011100000100101111001100001000" , "011100001010010111001011110010" , "011100001111111111001011011100" , "011100010101100111001011000101" , "011100011011001111001010101111"
, "011100100000110111001010011001" , "011100100110011111001010000010" , "011100101100000111001001101100" , "011100110001101111001001010101" , "011100110111010111001000111111" , "011100111100111111001000101000" , "011101000010011111001000010001" , "011101001000000111000111111010" , "011101001101101111000111100011" , "011101010011010111000111001100"
, "011101011000110111000110110101" , "011101011110011111000110011110" , "011101100100000111000110000111" , "011101101001100111000101110000" , "011101101111001111000101011000" , "011101110100101111000101000001" , "011101111010010111000100101010" , "011101111111110111000100010010" , "011110000101010111000011111010" , "011110001010111111000011100011"
, "011110010000011111000011001011" , "011110010101111111000010110011" , "011110011011100111000010011011" , "011110100001000111000010000011" , "011110100110100111000001101011" , "011110101100000111000001010011" , "011110110001100111000000111011" , "011110110111000111000000100011" , "011110111100100111000000001011" , "011111000010000110111111110010"
, "011111000111100110111111011010" , "011111001101000110111111000010" , "011111010010100110111110101001" , "011111011000000110111110010000" , "011111011101100110111101111000" , "011111100010111110111101011111" , "011111101000011110111101000110" , "011111101101111110111100101101" , "011111110011010110111100010100" , "011111111000110110111011111011"
, "011111111110001110111011100010" , "100000000011101110111011001001" , "100000001001000110111010110000" , "100000001110100110111010010111" , "100000010011111110111001111101" , "100000011001011110111001100100" , "100000011110110110111001001010" , "100000100100001110111000110001" , "100000101001101110111000010111" , "100000101111000110110111111110"
, "100000110100011110110111100100" , "100000111001110110110111001010" , "100000111111001110110110110000" , "100001000100100110110110010110" , "100001001001111110110101111100" , "100001001111010110110101100010" , "100001010100101110110101001000" , "100001011010000110110100101110" , "100001011111011110110100010100" , "100001100100110110110011111001"
, "100001101010001110110011011111" , "100001101111011110110011000100" , "100001110100110110110010101010" , "100001111010001110110010001111" , "100001111111011110110001110101" , "100010000100110110110001011010" , "100010001010000110110000111111" , "100010001111011110110000100100" , "100010010100101110110000001001" , "100010011010000110101111101110"
, "100010011111010110101111010011" , "100010100100100110101110111000" , "100010101001111110101110011101" , "100010101111001110101110000010" , "100010110100011110101101100110" , "100010111001101110101101001011" , "100010111110111110101100110000" , "100011000100001110101100010100" , "100011001001011110101011111000" , "100011001110101110101011011101"
, "100011010011111110101011000001" , "100011011001001110101010100101" , "100011011110011110101010001001" , "100011100011101110101001101110" , "100011101000111110101001010010" , "100011101110000110101000110110" , "100011110011010110101000011010" , "100011111000100110100111111101" , "100011111101101110100111100001" , "100100000010111110100111000101"
, "100100001000000110100110101001" , "100100001101010110100110001100" , "100100010010011110100101110000" , "100100010111101110100101010011" , "100100011100110110100100110111" , "100100100001111110100100011010" , "100100100111001110100011111101" , "100100101100010110100011100000" , "100100110001011110100011000100" , "100100110110100110100010100111"
, "100100111011101110100010001010" , "100101000000110110100001101101" , "100101000101111110100001010000" , "100101001011000110100000110010" , "100101010000001110100000010101" , "100101010101010110011111111000" , "100101011010011110011111011010" , "100101011111011110011110111101" , "100101100100100110011110100000" , "100101101001101110011110000010"
, "100101101110101110011101100100" , "100101110011110110011101000111" , "100101111000111110011100101001" , "100101111101111110011100001011" , "100110000010111110011011101101" , "100110001000000110011011010000" , "100110001101000110011010110010" , "100110010010001110011010010011" , "100110010111001110011001110101" , "100110011100001110011001010111"
, "100110100001001110011000111001" , "100110100110001110011000011011" , "100110101011001110010111111100" , "100110110000001110010111011110" , "100110110101001110010111000000" , "100110111010001110010110100001" , "100110111111001110010110000010" , "100111000100001110010101100100" , "100111001001001110010101000101" , "100111001110001110010100100110"
, "100111010011000110010100000111" , "100111011000000110010011101001" , "100111011101000110010011001010" , "100111100001111110010010101011" , "100111100110111110010010001011" , "100111101011110110010001101100" , "100111110000101110010001001101" , "100111110101101110010000101110" , "100111111010100110010000001111" , "100111111111011110001111101111"
, "101000000100011110001111010000" , "101000001001010110001110110000" , "101000001110001110001110010001" , "101000010011000110001101110001" , "101000010111111110001101010001" , "101000011100110110001100110010" , "101000100001101110001100010010" , "101000100110100110001011110010" , "101000101011011110001011010010" , "101000110000001110001010110010"
, "101000110101000110001010010010" , "101000111001111110001001110010" , "101000111110101110001001010010" , "101001000011100110001000110010" , "101001001000011110001000010001" , "101001001101001110000111110001" , "101001010010000110000111010001" , "101001010110110110000110110000" , "101001011011100110000110010000" , "101001100000011110000101101111"
, "101001100101001110000101001110" , "101001101001111110000100101110" , "101001101110101110000100001101" , "101001110011011110000011101100" , "101001111000001110000011001011" , "101001111100111110000010101010" , "101010000001101110000010001001" , "101010000110011110000001101000" , "101010001011001110000001000111" , "101010001111111110000000100110"
, "101010010100100110000000000101" , "101010011001010101111111100100" , "101010011110000101111111000010" , "101010100010101101111110100001" , "101010100111011101111110000000" , "101010101100000101111101011110" , "101010110000110101111100111100" , "101010110101011101111100011011" , "101010111010000101111011111001" , "101010111110110101111011010111"
, "101011000011011101111010110110" , "101011001000000101111010010100" , "101011001100101101111001110010" , "101011010001010101111001010000" , "101011010101111101111000101110" , "101011011010100101111000001100" , "101011011111001101110111101010" , "101011100011110101110111001000" , "101011101000011101110110100101" , "101011101100111101110110000011"
, "101011110001100101110101100001" , "101011110110001101110100111110" , "101011111010101101110100011100" , "101011111111010101110011111001" , "101100000011110101110011010111" , "101100001000011101110010110100" , "101100001100111101110010010001" , "101100010001100101110001101111" , "101100010110000101110001001100" , "101100011010100101110000101001"
, "101100011111000101110000000110" , "101100100011100101101111100011" , "101100101000000101101111000000" , "101100101100100101101110011101" , "101100110001000101101101111010" , "101100110101100101101101010111" , "101100111010000101101100110100" , "101100111110100101101100010000" , "101101000011000101101011101101" , "101101000111011101101011001001"
, "101101001011111101101010100110" , "101101010000010101101010000010"
);
end a;
