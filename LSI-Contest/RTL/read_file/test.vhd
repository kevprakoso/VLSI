
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

library std;
use std.textio.all;  --include package textio.vhd

--entity declaration
entity read_file is
    generic
    (
        sim_file            :   string := "test_pos_1.raw";
        DATA_WIDTH          :   integer := 12;
        DATA_WIDTH_BYTES    :   integer := 2
    );
    port
    (
        clk     : in    std_logic;
        enable  : in    std_logic;
        eof     : out   std_logic;
        valid   : out   std_logic;
        data    : out   std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end read_file;

--architecture definition
architecture Behavioral of read_file is


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
                data <= ((vDatain(DATA_WIDTH-1 downto 0))); -- Convert variable to signal
            end if;
            eof <= '0';
        else
            eof <= '1';
        end if;
    end if;

  END PROCESS;

end Behavioral;