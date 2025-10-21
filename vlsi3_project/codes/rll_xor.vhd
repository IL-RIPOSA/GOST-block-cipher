library ieee;
use ieee.std_logic_1164.all;

entity rll_xor is
	port(
	vector_left: in std_logic_vector(31 downto 0);
	value3: in std_logic_vector(31 downto 0);
	value4: out std_logic_vector(31 downto 0)
	);
end rll_xor;

architecture rll_xor_arch of rll_xor is

signal v1:std_logic_vector(31 downto 0);
begin
	v1<= value3(20 downto 0)& value3(31 downto 21);
	G1: for i in 0 to 31 generate
		value4(i)<= v1(i) xor vector_left(i);
	end generate;
end rll_xor_arch;