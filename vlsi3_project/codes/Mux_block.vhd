library ieee;
use ieee.std_logic_1164.all;

entity Mux_block is
	generic(M: integer:= 3;
	N: integer:= 1
	);
	port(
	in1,in2: in std_logic_vector(M-1 downto N);
	sig: in std_logic;
	out3: out std_logic_vector(M-1 downto N)
	);
end Mux_block;

architecture Mux_block_arch of Mux_block is

component mux2to1
	port(
	d,b: in std_logic;
	sel: in std_logic;
	c: out std_logic
	);
end component;

begin

	G1: for i in N to M-1 generate
		U1_i: mux2to1 port map(in1(i), in2(i), sig, out3(i));
	end generate;

end Mux_block_arch;