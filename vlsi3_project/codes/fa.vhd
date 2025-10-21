library ieee;
use ieee.std_logic_1164.all;

entity fa is
	port(
	a,b: in std_logic;
	cin: in std_logic;
	cout:out std_logic;
	sout:out std_logic
	);
end fa;

architecture fa_arch of fa is

begin 

	sout<= a xor b xor cin;
	cout<= (a and b) or ((a xor b) and cin);

end fa_arch;