library IEEE ;
	use IEEE.STD_LOGIC_1164.all ;
     USE IEEE.NUMERIC_STD.ALL    ;
	    USE work.top_pack.ALL;
    
ENTITY counter_entity IS

	PORT ( cp_i ,																--Sysclk
			 rb_i,																--reset 
			 inc_s ,																--increament		
			 dec_s ,                                              --decreament 
			 clr_i		   : IN STD_LOGIC ;                       -- clear
			 
			 hcount_s      : OUT STD_LOGIC_VECTOR (5 downto 0) ;  --Number of people
			 action_s	   : OUT STD_LOGIC_VECTOR (1 downto 0))  ;-- indicates people comin in, going out or max number is reached
			 
END counter_entity ;
