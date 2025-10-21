library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity F_function is
	port(
	F_input1: in std_logic_vector(63 downto 0);
	F_input2: in std_logic_vector(31 downto 0);
	F_output: out std_logic_vector(63 downto 0)
	);
end F_function;
architecture F_function_arch of F_function is

component s_box_arr is
	port(
	data: in std_logic_vector(31 downto 0);
	data_out: out std_logic_vector(31 downto 0)
	);
end component;

component carry_select is
	port(
	A,B: in std_logic_vector(31 downto 0);
	Z: out std_logic_vector(31 downto 0)
	);
end component;

component rll_xor is
	port(
	vector_left: in std_logic_vector(31 downto 0);
	value3: in std_logic_vector(31 downto 0);
	value4: out std_logic_vector(31 downto 0)
	);
end component;

signal add_out,s_out,rll_out: std_logic_vector(31 downto 0);

begin
	adder0: carry_select port map(F_input1(31 downto 0),F_input2,add_out);
	s_box0: s_box_arr port map(add_out,s_out);
	rll_xor0: rll_xor port map(F_input1(63 downto 32),s_out,rll_out);

	F_output<= F_input1(31 downto 0) & rll_out;

end F_function_arch;