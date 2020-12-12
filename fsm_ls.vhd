library IEEE ;
	use IEEE.STD_LOGIC_1164.all ;
	use IEEE.NUMERIC_STD.all    ;
	
	ENTITY fsm_ls IS 
		PORT (
		
				clr_i 	,										----		CLEAR counter	
				clk_i 	,										----		SYSTEM CLOCK
				rst_n_i 	  : IN STD_LOGIC 		;			----		reset active low
				
				
				ls_i       :IN STD_LOGIC_VECTOR (2 downto 0) ;--Light sensors,active HIGH	
				inc_s ,  										----		count up
				dec_s 	  :OUT STD_LOGIC 						----		count down
				
				
				) ;
				
		END fsm_ls ;
		
		
		ARCHITECTURE Behaviour OF fsm_ls IS
		
		TYPE state_name IS (S0,S1,S2,S3,S4,S5);
		SIGNAL now_st, nxt_st, prev_st : state_name ;
		
		BEGIN
		
		cp: PROCESS (rst_n_i,clk_i,clr_i)      ---Change state with clock event                         
				BEGIN                                                     
					IF (rst_n_i='0' OR clr_i = '1') THEN now_st <=S0;                   
					ELSIF (clk_i'EVENT AND clk_i='1') THEN now_st <= nxt_st;
					END IF;
					END PROCESS cp;
					
					
		st_transition : PROCESS (now_st,ls_i,prev_st)		--State transtion 

				BEGIN
				
				nxt_st <= S0 ; 
				
				CASE now_st IS 
				
				WHEN S0  => IF (ls_i="001") THEN	nxt_st <= S1 ;
						
					ELSIF (ls_i = "100") THEN nxt_st <= S3 ;
							prev_st <= S0; 
					
					END IF ;
				
				WHEN S1 => IF (ls_i= "010") THEN nxt_st <= S2 ;
						prev_st <= S1 ;
						ELSE nxt_st <= S1 ;
					END IF ;
				
				WHEN S2 => IF (ls_i= "100") THEN nxt_st <= S3 ;
						prev_st <= S2 ;

 						ELSE nxt_st <= S2 ;
					
					END IF ; 
				
				WHEN S3 => IF (ls_i= "010") THEN 
					nxt_st <= S4 ;
					prev_st <= S3 ;
					
					ELSIF (ls_i = "000") THEN nxt_st <= S0 ;
					prev_st <= S3 ;
					
					ELSE  nxt_st <= S3 ;
					
					END IF ;
				
				WHEN S4 => IF (ls_i= "001")  THEN
					nxt_st <= S5 ;
					prev_st <= S4 ;
					
					ELSE  nxt_st <= S4 ;
					END IF  ;
				WHEN S5 => IF (ls_i = "000") THEN
					nxt_st <=S0 ;
					ELSE  nxt_st <= S5 ;
					END IF ;
				
				END CASE ; 
				
			END PROCESS st_transition ;
		
		
		values : PROCESS(now_st)				--- State outputs
		BEGIN
			CASE now_st IS
		
			WHEN S3 =>  IF( prev_st = S2) then inc_s <= '1'  ; dec_s <='0' ;
							ELSIF (prev_st = S0) THEN inc_s <= '0' ; dec_s <= '0' ;
							END IF ;
			WHEN S5 =>  dec_s <= '1'  ; inc_s <='0' ;
			
			WHEN OTHERS =>  inc_s <= '0' ; dec_s <= '0' ;
			
			
			END CASE ; 
			END PROCESS values ;
			
			END Behaviour ;
			