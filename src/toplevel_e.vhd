

library IEEE ;
	use IEEE.STD_LOGIC_1164.all ;
	use IEEE.NUMERIC_STD.all    ;
	 USE work.top_pack.ALL;
	
	ENTITY toplevel_e is 
	
		PORT( 
				cp_i     :in STD_LOGIC ;-------------------		SYSTEM CLOCK
				rb_i	 :in STD_LOGIC ;-------------------		SYSTEM RESET
				s1_i,s2_i,
				s3_i,
				clr_i     :in STD_LOGIC ;-------------------		CLEAR COUNTER
				

				rst_led,					 -------------------		indicates reset active or not
				txd_o ,					 -------------------		UART transmission serial data stream	
				tx_led,					 -------------------		indicates a running UART transmission
				green_o ,					 -------------------		ON if the room is not full
				red_o,					 -------------------		ON if the room is full
				sdo_o,					 -------------------		Serial data out
				sdv_o,					 -------------------		Serial data valid
				stx_o,				-------------------		Serial transfer active
				sec_o     :OUT STD_LOGIC);-------------------		clock of period 1 sec	
				
				
				
				
			
				
				END toplevel_e ;
				
				
		