library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity final is
	port(
	plaintxt: in std_logic_vector(63 downto 0);
	enable_run:in std_logic;
	mode:in std_logic;
	en_new_data: std_logic;
	en_new_key: std_logic;
	userkey: in std_logic_vector(255 downto 0);
	clk,rst: in std_logic;
	cvalid: out std_logic;
	ciphertxt: out std_logic_vector(63 downto 0)
	);
end final;

architecture rtl of final is
component ram is
	port(
	clk: in std_logic;
	user_key: in std_logic_vector(255 downto 0);
	init: in std_logic;
	new_key: in std_logic;
	enc_dec: in std_logic;
	adress: in std_logic_vector(4 downto 0);
	round_key: out std_logic_vector(31 downto 0)
	);
end component;
component Gost_cipher_fun is
	port(
	clk: in std_logic;
	finish: in std_logic;
	sel_sig: in std_logic;
	k_i: in std_logic_vector(31 downto 0);
	inp: in std_logic_vector(63 downto 0);
	final: out std_logic_vector(63 downto 0);
	reg:out std_logic_vector(63 downto 0)
	);
end component;
component fsm is
	port(
	clk,rst:in std_logic;
	en,enable_key, enable_data: in std_logic;
	init_mem, init_key: out std_logic;
	init_run, init_data:out std_logic;
	round: inout std_logic_vector(5 downto 0);
	mem_pos: inout std_logic_vector(4 downto 0);
	done:out std_logic
	);
end component;

signal counter:std_logic_vector(5 downto 0);
signal counter_ram: std_logic_vector(4 downto 0);
signal roundkey: std_logic_Vector(31 downto 0):=(others=>'0');
signal start_key: std_logic_vector(255 downto 0):=(others=>'0');
signal start_txt: std_logic_vector(63 downto 0):=(others=>'0');
signal mem_start,run_start,en_key,en_data: std_logic:='0';
signal done_sig:std_logic:='1';
signal test_val: std_logic_vector(63 downto 0);
begin

start_regs:process(clk,rst)
begin
	if rising_edge(clk) then		--input reagisters.
		start_txt<= plaintxt;
		start_key<= userkey;
	end if;
end process;

ram_instantiation: ram port map(		-- inputs mem_start wich is the output init_mem of fsm
	clk=>clk, user_key=>start_key,		--        en_key which is the output init_key of fsm
	init=>mem_start,			--	  counter_ram which is the output mem_pos of fsm
	new_key=>en_key,
	enc_dec=>mode,
	adress=> counter_ram,
	round_key=> roundkey
	);
Gost_instantiation: Gost_cipher_fun port map(
	clk=>clk,finish=>done_sig,sel_sig=>en_data,	-- input done_sig which is the output done of the fsm
	k_i=>roundkey, inp=>start_txt,			--       en_data which is the ouput enable_key of the fsm.
	final=>ciphertxt,reg=>test_val			--	 roundkey which the output round_key of the ram.
	);						-- Test_val is a temporary signal to check the values of the reg_out register in every iretation.
							-- it is used for debugging.
fsm_instantiation: fsm port map(
	clk=>clk,rst=>rst,
	en=>enable_run,enable_key=>en_new_key,
	enable_data=>en_new_data,
	init_mem=>mem_start,init_key=>en_key,
	init_run=>run_start,init_data=>en_data,
	round=> counter,mem_pos=>counter_ram,
	done=>done_sig
	);
cvalid<='1' when done_sig='1' else
	'0';
end rtl;