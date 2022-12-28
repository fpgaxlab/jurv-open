LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY  VirtualBoard IS
PORT (   
   CLOCK:in std_logic;                     -- 10MHz Input Clock 
   PB: in  std_logic_vector(19 downto 0);  -- 20 Push buttons, logical 1 when pressed
   S:  in  std_logic_vector(35 downto 0);  -- 36 Switches
   L:  out std_logic_vector(35 downto 0);  -- 36 LEDs, drive logical 1 to light up
   SD7:out std_logic_vector(7 downto 0);   -- 8 common anode Seven-segment Display
   SD6:out std_logic_vector(7 downto 0);
   SD5:out std_logic_vector(7 downto 0);
   SD4:out std_logic_vector(7 downto 0);
   SD3:out std_logic_vector(7 downto 0);
   SD2:out std_logic_vector(7 downto 0);
   SD1:out std_logic_vector(7 downto 0);
   SD0:out std_logic_vector(7 downto 0)); 
END VirtualBoard;

ARCHITECTURE  behav_VB OF  VirtualBoard IS

BEGIN


END behav_VB;