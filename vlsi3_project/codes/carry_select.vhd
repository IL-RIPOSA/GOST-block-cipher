library ieee;
use ieee.std_logic_1164.all;


entity carry_select is
	port(
	A,B: in std_logic_vector(31 downto 0);
	Z: out std_logic_vector(31 downto 0)
	);
end carry_select;

architecture carry_select_arch of carry_select is
component fa
	port(
	a,b: in std_logic;
	cin: in std_logic;
	cout:out std_logic;
	sout:out std_logic
	);
end component;

component mux2to1
	port(
	d,b: in std_logic;
	sel: in std_logic;
	c: out std_logic
	);
end component;

component rca_block_N
	generic(N: integer:= 5);
	port(
	input1,input2: in std_logic_vector(N-1 downto 0);
	Cin: in std_logic;
	Sout:out std_logic_vector(N-1 downto 0);
	Cout:out std_logic
	);
end component;

component Mux_block 
	generic(M: integer:= 3;
	N: integer:= 1
	);
	port(
	in1,in2: in std_logic_vector(M-1 downto N);
	sig: in std_logic;
	out3: out std_logic_vector(M-1 downto N)
	);
end component;

signal c: std_logic_vector(7 downto 0);
signal temp0,temp1: std_logic_vector(6 downto 0);
signal sum0,sum1:std_logic_vector(31 downto 1);

begin 
	--1 bit
	U0: fa port map(A(0),B(0),'0',c(0),Z(0));
	--2 bits
	U1_0: rca_block_N generic map(2) port map(A(2 downto 1),B(2 downto 1),'0',sum0(2 downto 1),temp0(0));
	U1_1: rca_block_N generic map(2) port map(A(2 downto 1),B(2 downto 1),'1',sum1(2 downto 1),temp1(0));
	U1_2: Mux_block generic map(3,1) port map(sum1(2 downto 1),sum0(2 downto 1),c(0),Z(2 downto 1));
	U1_3: mux2to1 port map(temp1(0),temp0(0),c(0),c(1));
	--3 bits
	U2_0: rca_block_N generic map(3) port map(A(5 downto 3),B(5 downto 3),'0',sum0(5 downto 3),temp0(1));
	U2_1: rca_block_N generic map(3) port map(A(5 downto 3),B(5 downto 3),'1',sum1(5 downto 3),temp1(1));
	U2_2: Mux_block generic map(6,3) port map(sum1(5 downto 3),sum0(5 downto 3),c(1),Z(5 downto 3));
	U2_3: mux2to1 port map(temp1(1),temp0(1),c(1),c(2));
	--4 bits
	U3_0: rca_block_N generic map(4) port map(A(9 downto 6),B(9 downto 6),'0',sum0(9 downto 6),temp0(2));
	U3_1: rca_block_N generic map(4) port map(A(9 downto 6),B(9 downto 6),'1',sum1(9 downto 6),temp1(2));
	U3_2: Mux_block generic map(10,6) port map(sum1(9 downto 6),sum0(9 downto 6),c(2),Z(9 downto 6));
	U3_3:mux2to1 port map(temp1(2),temp0(2),c(2),c(3));
	--4 bits
	U4_0: rca_block_N generic map(4) port map(A(13 downto 10),B(13 downto 10),'0',sum0(13 downto 10),temp0(3));
	U4_1: rca_block_N generic map(4) port map(A(13 downto 10),B(13 downto 10),'1',sum1(13 downto 10),temp1(3));
	U4_2: Mux_block generic map(14,10) port map(sum1(13 downto 10),sum0(13 downto 10),c(3),Z(13 downto 10));
	U4_3: mux2to1 port map(temp1(3),temp0(3),c(3),c(4));
	--5 bits
	U5_0: rca_block_N generic map(5) port map(A(18 downto 14),B(18 downto 14),'0',sum0(18 downto 14),temp0(4));
	U5_1: rca_block_N generic map(5) port map(A(18 downto 14),B(18 downto 14),'1',sum1(18 downto 14),temp1(4));
	U5_2: Mux_block generic map(19,14) port map(sum1(18 downto 14),sum0(18 downto 14),c(4),Z(18 downto 14));
	U5_3: mux2to1 port map(temp1(4),temp0(4),c(4),c(5));
	--6 bits
	U6_0: rca_block_N generic map(6) port map(A(24 downto 19),B(24 downto 19),'0',sum0(24 downto 19),temp0(5));
	U6_1: rca_block_N generic map(6) port map(A(24 downto 19),B(24 downto 19),'1',sum1(24 downto 19),temp1(5));
	U6_2: Mux_block generic map(25,19) port map(sum1(24 downto 19),sum0(24 downto 19),c(5),Z(24 downto 19));
	U6_3: mux2to1 port map(temp1(5),temp0(5),c(5),c(6));
	--7 bits
	U7_0: rca_block_N generic map(7) port map(A(31 downto 25),B(31 downto 25),'0',sum0(31 downto 25),temp0(6));
	U7_1: rca_block_N generic map(7) port map(A(31 downto 25),B(31 downto 25),'1',sum1(31 downto 25),temp1(6));
	U7_2: Mux_block generic map(32,25) port map(sum1(31 downto 25),sum0(31 downto 25),c(6),Z(31 downto 25));
	U7_3: mux2to1 port map(temp1(6),temp0(6),c(6),c(7));
	
	
end carry_select_arch;