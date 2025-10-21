library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is 
	port(
	clk,rst:in std_logic;
	en,enable_key, enable_data: in std_logic;
	init_mem, init_key: out std_logic;
	init_run, init_data:out std_logic;
	round: inout std_logic_vector(5 downto 0);
	mem_pos: inout std_logic_vector(4 downto 0);
	done:out std_logic
	);
end fsm;

architecture fsm_arch of fsm is

type state_type is (idle,load,init,run,en_out);

signal state: state_type;

begin

p0:process(clk,rst)
begin
	if rst='1' then
		state<= idle;			
	elsif rising_edge(clk) then
		case state is
		when idle=>
			if(en='1') then
				state<=load;
			else	state<=idle;
			end if;

		when load=>
			state<=init;

		when init=>
			state<=run;

		when run=>
			if(round="100000")then	--when round=32 then the cipher has already evaluate 32 times and the output phase has began.
				state<=en_out;
			else	state<=run;
			end if;

		when en_out=>
			state<=idle;

		end case;
	end if;
end process;


init_mem<='1' when state=load else '0';				-- fsm is in the load phase. In the next clock ram will see init_mem high and will begin the evaluate.
init_key<='1' when (enable_key='1' and state=load) else '0';	-- In the next clock ram will see the value of init_key and it will begin the process.

init_run<='1' when state=init else '0';				
init_data<='1' when (enable_data='1' and state=init) else '0';	--fsm in init state. init state : done=0 and init_data= U so in the next clock the Gost_cipher_fun will see done='0' 
								--and based on the init_data value will choose between the plaintxt or the reg_out.
p1:process(clk)		
begin
	if rising_edge(clk)then
		if round="011111" then		--round=31 means that this is the 32nd round that gost_cipher_fun evaluates. force done high so in the next clock Gost_cipher stops the evaluate process.
			done<='1';
		end if;
		case state is			--we increace mem_pos in the states load,run,init so that the ram in each clock produce the next round_key needed.
		when idle=>			--we increace round in the states init,run so that gives us the number of the iretation.
			round<=(others=>'0');	--Ex. if clock arrives and the fsm was in init state then the first process will change the state to run
			mem_pos<=(others=>'0');	--Ram will see an adress with value 1 so it will begin the process to produce the round_key_1.
		when load=>			--Gost_cipher will run with the round_key_0 that was ready when the clock arrived and the round will take the value 1.
			done<='0';
			round<=(others=>'0');
			mem_pos<=std_logic_vector(unsigned(mem_pos)+1);
		when init=>
			mem_pos<=std_logic_vector(unsigned(mem_pos)+1);
			round<=std_logic_vector(unsigned(round)+1);
		when run=>
			mem_pos<=std_logic_vector(unsigned(mem_pos)+1);
			round<=std_logic_vector(unsigned(round)+1);
		when en_out=>
			round<=(others=>'0');
			mem_pos<=(others=>'0');
		end case;
	end if;
end process;	

end fsm_arch;
