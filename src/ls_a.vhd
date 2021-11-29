
		
		
		ARCHITECTURE Behaviour OF fsm_lightsensor IS
		
		TYPE state_name IS (S0,S1,S2,S3,S4,S5,S6);
		--S0 --------------- initial state
		--S1 --------------- person enters
		--S2 --------------- second sensor is triggered
		--S3 --------------- third sensor is triggered
		--S4 --------------- person leaves
		--S5 --------------- second sensor is triggered
		--S6 --------------- first sensor is triggered
		SIGNAL now_st, nxt_st : state_name ;
		
		BEGIN
		
		cp: PROCESS (rb_i,cp_i,clr_i)      ---Change state with clock event                         
				BEGIN                                                     
					IF (rb_i='0') THEN now_st <=S0;                   
					ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
																	
					
					END IF;
					END PROCESS cp;
					
					
		st_transition : PROCESS (now_st,s1_i,s2_i,s3_i)		--State transtion 

				BEGIN
				
				nxt_st <= S0 ;
				
				CASE now_st IS 
				
				WHEN S0  => IF (s1_i ='1'AND s2_i ='0'AND s3_i ='0') THEN nxt_st <= S1 ;
										
					ELSIF(s1_i = '0' AND s2_i ='0' AND s3_i ='1') THEN nxt_st <= S4 ;
					
					ELSE          nxt_st <= S0;
										
					END IF ;
				
				WHEN S1 => IF(s1_i='0' AND s2_i = '1' AND s3_i ='0') THEN nxt_st <= S2 ;
								
						ELSE nxt_st <= S1 ;
							  	
					END IF ;
				
				WHEN S2 => IF (s1_i ='0' AND s2_i ='0' AND s3_i ='1') THEN nxt_st <= S3 ;
					

 						ELSE nxt_st <= S2 ;
						
					END IF ; 
				
				WHEN S3 => IF (s1_i = '0' AND s2_i = '0' AND s3_i = '0') THEN nxt_st <= S0 ;
						
								ELSE nxt_st <= S3 ;
								
								END IF ;					
				
				WHEN S4=> IF (s1_i ='0' AND s2_i ='1' AND s3_i = '0') THEN 
					nxt_st <= S5 ;
				
					
					ELSE nxt_st <= S4 ;
				
					END IF ;
				
				WHEN S5 => IF (s1_i  = '1' AND s2_i = '0' AND s3_i ='0')  THEN
					nxt_st <= S6 ;
					
					
					ELSE  nxt_st <= S5 ;
					END IF  ;
				WHEN S6 =>IF (s1_i = '0' AND s2_i = '0' AND s3_i = '0') THEN nxt_st <= S0 ;
						
								ELSE nxt_st <= S6 ;
								
								END IF ;
				
				END CASE ; 
				
			END PROCESS st_transition ;
		
		
		values : PROCESS(now_st)				--- State outputs
		BEGIN
			CASE now_st IS
		
			WHEN S3 =>  inc_s <= '1' ; dec_s <= '0' ;
			WHEN S6 =>  dec_s <= '1'  ; inc_s <= '0' ;
			
			WHEN OTHERS =>  inc_s <= '0' ; dec_s <= '0' ;
			
			
			END CASE ; 
			END PROCESS values ;
			
			END Behaviour ;
			