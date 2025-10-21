library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
	port(
	clk: in std_logic;
	user_key: in std_logic_vector(255 downto 0);
	init: in std_logic;
	new_key: in std_logic;
	enc_dec: in std_logic;
	adress: in std_logic_vector(4 downto 0);
	round_key: out std_logic_vector(31 downto 0)
	);
end ram;

architecture arch of ram is
type mem is array(7 downto 0) of std_logic_vector(31 downto 0);

signal ksu:mem;
signal check: unsigned(2 downto 0);
begin
check<= unsigned(adress(2 downto 0));	-- 3bits because we want to reach up to 8 adresses. (0-7)

RAM: process(clk)
begin
if rising_edge(clk) then
	if (init='1' and new_key='1') then	--if init,new_key=1 then we have to initialise the ksu with the new user_key
		ksu(0)<= user_key(31 downto 0);
		ksu(1)<= user_key(63 downto 32);
		ksu(2)<= user_key(95 downto 64);
		ksu(3)<= user_key(127 downto 96);
		ksu(4)<= user_key(159 downto 128);
		ksu(5)<= user_key(191 downto 160);
		ksu(6)<= user_key(223 downto 192);
		ksu(7)<= user_key(255 downto 224);
		round_key<= user_key(31 downto 0);
	elsif(init='1' and new_key='0')then	--if new_key=0 then the ksu remains the same
		round_key<= ksu(0);
	else
		-- enc_dec='1' then encrypt (K0,..,K7)(K0,..,K7)(K0,..,K7)(K7,..,K0)
		if (enc_dec='1') then
			if(adress(4)='1' and adress(3)='1') then	--if adress: 11XXX then we are in the last sequence of keys
				round_key<= ksu(to_integer(not check)); -- ex. adress: 11000 then ksu(~000)= ksu(111)
			else	round_key<= ksu(to_integer(check));	--else we aren't in the last seq.
			end if;
		--enc_dec='0' then decrypt (K0,..,K7)(K7,..,K0)(K7,..,K0)(K7,..,K0)
		else
			if(adress(4)='0' and adress(3)='0') then
				round_key<= ksu(to_integer(check));	--if we are in the first sequence then produce the keys_seq:K0,..,K7
			else	round_key<= ksu(to_integer(not check));	--else produce the seq: (~UUU): if U=0 then ksu(111)etc.
			end if;
		end if;
	end if;	
		
end if;
end process;

end arch;