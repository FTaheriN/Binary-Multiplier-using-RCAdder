library IEEE;
use IEEE.std_logic_1164.all;

ENTITY RC_Adder IS
GENERIC ( n: INTEGER := 4 );
PORT (  a : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	b : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	cin : IN STD_LOGIC;
	s : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	Cout : OUT STD_LOGIC);
end ENTITY;

ARCHITECTURE BEHAVIORAL OF RC_Adder IS
COMPONENT full_adder
PORT ( a : IN STD_LOGIC;
b : IN STD_LOGIC;
Cin : IN STD_LOGIC;
s : OUT STD_LOGIC;
Cout : OUT STD_LOGIC);
end COMPONENT;

--FOR ALL: fA USE ENTITY WORK.full_adder(BEHAVIORAL);

signal c: STD_LOGIC_VECTOR(n DOWNTO 0);

BEGIN
	c(0) <= cin;
	fALL: FOR i IN 0 TO n-1 GENERATE
		f: full_adder PORT MAP(a=>a(i) , b=>b(i) , Cin=>c(i) , s=>s(i) , Cout=>c(i+1));
	END GENERATE;
	Cout <= c(n);
END BEHAVIORAL;
