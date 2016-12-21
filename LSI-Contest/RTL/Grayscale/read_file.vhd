
   ----------------------------------------------------------------------------------
-- Reads bytes from a file located at the path specified in the "input_file" 
-- declaration. At the end of the file EOF is set high.
--
-- Expects ASCII hex data as the input. Reads one line per clock. For example,
-- if the desired output is: 01,23,45,67,89,AB,CD,EF the input text file should
-- contain:
-- 01
-- 23
-- 45
-- ..
-- EF
--  
----------------------------------------------------------------------------------


--include this library for file handling in VHDL.
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


library std;
use std.textio.all;  --include package textio.vhd

--entity declaration
entity read_file is
    generic
    (
        sim_file            :   string := "test_pos_3.raw";
        DATA_WIDTH          :   integer := 24;
        DATA_WIDTH_BYTES    :   integer := 3
    );
    port
    (
        clk     : in    std_logic;
        enable  : in    std_logic;
        eof     : out   std_logic;
        valid   : out   std_logic;
        --data1    : out   std_logic_vector(8-1 downto 0);
	--data2    : out   std_logic_vector(8-1 downto 0);
	data    : out   std_logic_vector(8-1 downto 0)
    );
    
end read_file;

--architecture definition
architecture Behavioral of read_file is
signal data1,data2,data3: std_logic_vector(8-1 downto 0);

  -- file declaration
  -- type "text" is already declared in textio library
  FILE input_file  : text OPEN read_mode IS sim_file;

BEGIN

-- Read process
PROCESS(clk)
    -- file variables
    VARIABLE vDatainline : line;
    VARIABLE vDatain     : std_logic_vector((DATA_WIDTH_BYTES*8)-1 DOWNTO 0);

BEGIN
    if rising_edge(clk) then
        valid <= '0';
        if not endfile(input_file) then
            if enable = '1' then
                readline (input_file, vDatainline);         -- Get line from input file
                hread (vDatainline, vDatain);               -- Read line as Hex
                valid <= '1';                               -- Data is valid
                data1 <= ((vDatain(23 downto 16))); -- Convert variable to signal
		data2 <= ((vDatain(15 downto 8))); -- Convert variable to signal
		data3 <= ((vDatain(7 downto 0))); -- Convert variable to signal
		
--		data <= ((vDatain(23 downto 16))+(vDatain(15 downto 8))+(vDatain(7 downto 0)));
            end if;
            eof <= '0';
        else
            eof <= '1';
        end if;
    end if;

  END PROCESS;
--data <= TO_SIGNED(data1,9);
--0.01001100 Red
--0.10011001 Green
--0.00011001 Blue

end Behavioral;