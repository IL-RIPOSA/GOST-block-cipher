library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
	port(
	d,b: in std_logic;
	sel: in std_logic;
	c: out std_logic
	);
end mux2to1;

architecture mux2to1_arch of mux2to1 is

begin
c<= d when sel ='1' else
    b;
end mux2to1_arch;