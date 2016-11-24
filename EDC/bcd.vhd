LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY BCD IS PORT (
	in_bcd: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	segs: OUT STD_LOGIC_VECTOR(1 TO 7));
END BCD;

ARCHITECTURE Behavioral OF BCD IS
BEGIN
PROCESS(in_bcd)
	BEGIN
		CASE in_bcd IS
		-- 0=on; 1=off
		WHEN "0000" => segs <= "0000001";	-- 0
		WHEN "0001" => Segs <= "1001111";	-- 1
		WHEN "0010" => Segs <= "0010010";	-- 2
		WHEN "0011" => Segs <= "0000110";	-- 3
		WHEN "0100" => Segs <= "1001100";	-- 4
		WHEN "0101" => Segs <= "0100100";	-- 5
		WHEN "0110" => Segs <= "0100000";	-- 6
		WHEN "0111" => Segs <= "0001111";	-- 7
		WHEN "1000" => Segs <= "0000000";	-- 8
		WHEN "1001" => Segs <= "0001100";	-- 9
		WHEN "1010" => Segs <= "0001000";	-- A
		WHEN "1011" => Segs <= "1100000";	-- b
		WHEN "1100" => Segs <= "0110001";	-- C
		WHEN "1101" => Segs <= "1000010";	-- d
		WHEN "1110" => Segs <= "0110000";	-- E
		WHEN "1111" => Segs <= "0111000";	-- F
		WHEN OTHERS => Segs <= "1111111";	-- all off
		END CASE;
	END PROCESS;
END Behavioral;
