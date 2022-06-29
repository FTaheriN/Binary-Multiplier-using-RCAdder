library IEEE;
use IEEE.std_logic_1164.all;

ENTITY full_adder IS
PORT ( a : IN STD_LOGIC;
b : IN STD_LOGIC;
Cin : IN STD_LOGIC;
s : OUT STD_LOGIC;
Cout : OUT STD_LOGIC);
end ENTITY;

ARCHITECTURE BEHAVIORAL OF full_adder IS
BEGIN
	s <= a XOR b XOR Cin;
	Cout <= (a AND b) OR (a AND Cin) OR (b AND Cin);
END BEHAVIORAL;
