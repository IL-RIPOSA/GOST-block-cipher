library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Gost_cipher_fun is
	port(
	clk: in std_logic;
	finish: in std_logic;
	sel_sig: in std_logic;
	k_i: in std_logic_vector(31 downto 0);
	inp: in std_logic_vector(63 downto 0);
	final: out std_logic_vector(63 downto 0);
	reg:out std_logic_vector(63 downto 0)
	);
end Gost_cipher_fun;

architecture Gost_cipher_fun_arch of Gost_cipher_fun is
component F_function is
	port(
	F_input1: in std_logic_vector(63 downto 0);
	F_input2: in std_logic_vector(31 downto 0);
	F_output: out std_logic_vector(63 downto 0)
	);
end component;
signal fin,fout,reg_out: std_logic_vector(63 downto 0):=(others=>'0');


begin
	fin<= inp when sel_sig='1' else reg_out;	--mux than choose the fin(input in F_function) between the signals inp (plaintxt) and reg_out based on the value of sel_sig.

	F_function_u: F_function port map(
	F_input1=> fin,		
	F_input2=> k_i,					--k_i : round_key . Output of the ram.
	F_output=> fout					--fout: output value of the F_function.
	);

logic:process(clk)
	begin
		if rising_edge(clk) then		-- if finish is '1' that means than the evaluate phase has completed and we dont write any new value in the reg_out.
			if finish='0' then		-- if finish is '0' then another round of evaluate has began so we write in the reg_out the fout.
				reg_out<=fout;
				reg<=fout;
			else
				final<= reg_out;
			end if;
		end if;
	end process;	

end Gost_cipher_fun_arch;