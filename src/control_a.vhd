
		 
		 
ARCHITECTURE ar1 OF control_entity  is 

	TYPE state_name IS (initial_st, green_st, red_st,clr_st,dec_st,engreen_st,endec_st,startgreen_st,startdec_st, wait_st) ; 
	SIGNAL now_st, prev_st, nxt_st : state_name ;
	SIGNAl max_s : STD_LOGIC ;
	
	SIGNAL act_s : STD_LOGIC_VECTOR(1 DOWNTO 0) ;
	
	BEGIN
	
	act_s <= action_s ;

	PROCESS(cp_i, rb_i,clr_i) 
	
	BEGIN
	
	IF (rb_i='0') THEN now_st <=initial_st;  
					
					ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
							IF(clr_i = '1') THEN now_st <= clr_st;
					END IF;
					END IF ;
					
	END PROCESS ; 
	
	
	st_transition : PROCESS(now_st,act_s,nxt_st,max_s) 
	
	BEGIN
	
		nxt_st <= initial_st ;
		
		CASE now_st IS 
		
		WHEN initial_st  => IF (act_s = "01") THEN nxt_st <= green_st ;
									
									ELSIF(act_s = "11") THEN nxt_st <= red_st ;
									ELSIF(act_s = "10") THEN nxt_st <= dec_st ; 
								
									ELSE nxt_st <= initial_st ;
									
									END IF ;
									
	WHEN red_st => IF (act_s = "10") THEN nxt_st <=dec_st	;
	
						ELSE nxt_st <=red_st;
						END IF ;
	WHEN green_st => nxt_st <=engreen_st ;
	WHEN dec_st   => nxt_st <=endec_st ;
	WHEN engreen_st => nxt_st <= startgreen_st ;
	WHEN endec_st   => nxt_st <= startdec_st   ;
	
	
	
	WHEN startgreen_st => nxt_st <= wait_st ;
	WHEN startdec_st => nxt_st<= wait_st   ;
	
	
	
	WHEN clr_st => nxt_st <= initial_st ;
	WHEN wait_st => nxt_st <= initial_st ;
		END CASE ;
		
		END PROCESS st_transition ;
		
		
		values : PROCESS(now_st,max_s) 
		
		BEGIN
		
		CASE now_st IS 
			WHEN initial_st =>     green_o <= not(max_s) ; red_o <= '0' ; events_s <= "00000000" ; dv_o <= '0' ; clr_o <= '0' ; max_s <= '0' ;
			WHEN clr_st 	=>  	  green_o <= not(max_s) ; red_o <= '0' ; events_s <= "00000000" ; dv_o <= '0' ; clr_o <= '1' ; max_s <= '0' ;
			WHEN green_st =>   	  green_o <= not(max_s) ; red_o <= '0' ;  events_s <= "00101011" ; dv_o <= '0' ; clr_o <= '0'; max_s <= '0' ;
			WHEN red_st =>     	  green_o <= '0' ; red_o <= '1' ; events_s <= "00100001" ; dv_o <= '1' ; clr_o <= '0' ; max_s <= '1' ;
			WHEN dec_st =>         green_o <= not(max_s) ; red_o <= '0' ; events_s <= "00101101" ; dv_o <= '0' ; clr_o <= '0' ; max_s <= '0' ;
			WHEN engreen_st =>     green_o <= not(max_s) ; red_o <= '0' ; events_s <= "00101011" ; dv_o <= '1' ; clr_o <= '0' ; max_s <= '0' ;
			WHEN endec_st  =>      green_o <= not(max_s) ; red_o <= '0' ; events_s <= "00101101" ; dv_o <= '1' ; clr_o <= '0' ; max_s <= '0' ;
			WHEN startgreen_st =>  green_o <= not(max_s) ; red_o <= '0' ; events_s <= "00101011" ; dv_o <= '0' ; clr_o <= '0' ; max_s <= '0' ;
			WHEN startdec_st  =>   green_o <= not(max_s) ; red_o <= '0' ; events_s <= "00101101" ; dv_o <= '0' ; clr_o <= '0' ; max_s <= '0' ;
			WHEN wait_st   =>      green_o <= not(max_s); red_o <= '0'  ; events_s <= "00000000" ;dv_o <= '0'  ; clr_o <= '0' ; max_s <= '0' ;
			END CASE ;
			END PROCESS values ;
			END ar1 ;
			
		