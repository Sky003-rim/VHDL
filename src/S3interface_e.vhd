LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
    USE work.top_pack.ALL;

  
  
  ENTITY S3_interface IS 
  
	PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
        cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
         
		  hcount_s   :  IN STD_LOGIC_VECTOR(5 DOWNTO 0);  -- count 
		  events_s   :  IN STD_LOGIC_VECTOR(7 DOWNTO 0) ; -- events
        dv_i   :  IN STD_LOGIC; 		  -- Serial Data to RS23
		  sd_o   :  OUT STD_LOGIC;
		  sdv_o  :  OUT STD_LOGIC ;
		  stx_o  :  out STD_LOGIC ) ;
 END S3_interface;
		