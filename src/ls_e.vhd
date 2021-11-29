library IEEE ;
	use IEEE.STD_LOGIC_1164.all ;
	use IEEE.NUMERIC_STD.all    ;
	  USE work.top_pack.ALL;
	
	ENTITY fsm_lightsensor IS 
		PORT (
		
				clr_i ,										----		CLEAR counter	
				cp_i 	,										----		SYSTEM CLOCK
				rb_i 	    :IN STD_LOGIC 		;		----		reset active low
				
				
				s1_i      :IN STD_LOGIC      ;
				s2_i      :IN STD_LOGIC      ;
				s3_i      :IN STD_LOGIC      ;--Light sensors,active HIGH	
				inc_s ,  										----		count up
				dec_s 	  :OUT STD_LOGIC 						----		count down
				
				
				) ;
				
		END fsm_lightsensor ;