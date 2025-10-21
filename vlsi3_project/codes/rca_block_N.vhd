library ieee;
use ieee.std_logic_1164.all;

entity rca_block_N is
	generic(N: integer:= 5);
	port(
	input1,input2: in std_logic_vector(N-1 downto 0);
	Cin: in std_logic;
	Sout:out std_logic_vector(N-1 downto 0);
	Cout:out std_logic
	);
end rca_block_N;

architecture rca_block_N_arch of rca_block_N is

component fa
	port(
	a,b: in std_logic;
	cin: in std_logic;
	cout:out std_logic;
	sout:out std_logic
	);
end component;
signal c: std_logic_vector(N downto 0);
begin
	c(0)<= Cin;
	G1: for i in 0 to N-1 generate
		U1: fa port map(input1(i),input2(i),c(i),c(i+1),Sout(i));
	end generate;
	Cout<=c(N);

end rca_block_N_arch;