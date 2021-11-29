LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
  USE work.top_pack.ALL;



ENTITY  control_entity IS 
PORT 
		(rb_i,																---reset active low
		 cp_i  ,																---System clock
		 clr_i         : IN STD_LOGIC ;								---clear data

	  	 action_s      : IN 	STD_LOGIC_VECTOR(1 downto 0 )	; 
		
		 red_o ,																---RED LED high
		 green_o       : OUT STD_LOGIC ; 							--- GREEN LED high
		 clr_o         : OUT STD_LOGIC ;								--- Clear out
		 dv_o          : OUT STD_LOGIC  ;        					--- data valid out
		 events_s      : OUT STD_LOGIC_VECTOR( 7 downto 0) ) ;--- Events
		 		
		 
		 
		 END control_entity ;