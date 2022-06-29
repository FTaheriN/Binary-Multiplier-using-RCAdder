library ieee;
use ieee.std_logic_1164.all;

ENTITY mult IS
GENERIC(n : INTEGER := 8 );
PORT   (a : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	b : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	ANS : OUT STD_LOGIC_VECTOR(2*n - 1 DOWNTO 0));
end ENTITY;


ARCHITECTURE BEHAVIORAL OF mult IS
COMPONENT RC_Adder
GENERIC(n : INTEGER := 4 );
PORT   (a : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	b : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	cin : IN STD_LOGIC;
	s : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	Cout : OUT STD_LOGIC);
end COMPONENT;

SIGNAL m : STD_LOGIC_VECTOR(2*n - 1 DOWNTO 0);
SIGNAL s : STD_LOGIC_VECTOR(n*n-1 DOWNTO 0);
SIGNAL g : STD_LOGIC_VECTOR(n*n - 1 DOWNTO 0);
SIGNAL co : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
--SIGNAL tmp : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
BEGIN
	j1: FOR j IN 0 TO n-1 GENERATE
		k1: FOR k IN 0 TO n-1 GENERATE
			g(j*n + k) <= a(k)AND b(j); --ok
		END GENERATE;
	END GENERATE;
	
	co(0) <= '0'; --ok
	s(n-1 DOWNTO 0) <= g(n-1 DOWNTO 0); --ok
	
	rALL: FOR i IN 0 TO n-2 GENERATE
		SIGNAL tmp : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		BEGIN
		tmp(n-1) <= co(i);
		tmp(n-2 DOWNTO 0) <= s(n*(i+1)-1 DOWNTO n*i+1);
		r: RC_Adder     GENERIC MAP(n => n)
				PORT MAP(a => tmp,
				 	 b => g(n*(i+2)-1 DOWNTO n*(i+1)),
					 cin => '0',
				 	 s => s(n*(i+2)-1 DOWNTO n*(i+1)),
				 	 Cout => co(i+1)); 
		
	END GENERATE;
	
	--m(0) <= s(0); --ok
	--m(1) <= s(n);
	--m(2) <= s(2*n);
	--m(3) <= s(12);
	--m(4) <= s(13);
	--m(5) <= s(14);
	--m(6) <= s(15);
	--m(7) <= co(3);
	f1: FOR l IN 0 TO n-2 GENERATE
		m(l) <= s(n*l);
	END GENERATE;
	f2: FOR p IN 0 TO n-1 GENERATE
		m(n-1 + p) <= s(n*(n-1) + p);
	END GENERATE;

	m(2*n -1) <= co(n-1);
	
	ANS <= m; --ok

END BEHAVIORAL;



