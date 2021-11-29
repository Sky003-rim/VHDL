
  
  ARCHITECTURE ar1 OF interface_fsm IS
--                                                          
  TYPE state_name IS (wtdv_st,ldrg_st,cinc_st,transfer_st,valid_st,wtb_st);
  SIGNAL now_st,nxt_st : state_name;                         

  BEGIN                                                     

  clkd: PROCESS (rb_i,cp_i)                                 
  BEGIN                                                      
   IF (rb_i='0') THEN now_st <= wtdv_st;                     
   ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
   END IF;
  END PROCESS clkd;
-- ----------------------------------------------------------------------------
  st_trans: PROCESS (now_st,dv_i,dne_i)
  begin
      nxt_st <= wtdv_st;
    CASE now_st IS
      WHEN wtdv_st  =>  IF (dv_i ='1') THEN nxt_st <= ldrg_st;
	                      ELSE                nxt_st <= wtdv_st;
                        END IF;
      WHEN ldrg_st =>                      nxt_st <= transfer_st;
      WHEN  transfer_st  =>    nxt_st <=valid_st;
                      
      WHEN valid_st  =>   nxt_st <= wtb_st;
	
		 WHEN  wtb_st=> nxt_st<=cinc_st ;
                  WHEN cinc_st    =>IF (dne_i='1') THEN nxt_st <= wtdv_st;    
						ELSE   nxt_st <= transfer_st; 
						END IF ;
    END CASE;
  END PROCESS st_trans;
-- ----------------------------------------------------------------------------
  ausgabe : PROCESS (now_st)
  BEGIN
    CASE now_st IS
     WHEN wtdv_st  =>  clr_o <= '1'; nxt_o  <= '0'; sto_o <= '0';vld_o <= '0' ; str_o <= '0' ;
	  WHEN transfer_st => clr_o <= '0'; nxt_o  <= '0'; sto_o <= '0'; vld_o <= '0' ; str_o <= '1' ;
	  WHEN valid_st =>  clr_o <= '0'; nxt_o  <= '0'; sto_o <= '0'; vld_o <= '1' ; str_o <= '1' ;
     WHEN ldrg_st  =>  clr_o <= '0'; nxt_o  <= '0'; sto_o <= '1'; vld_o <= '0' ; str_o <= '0' ;
     WHEN cinc_st  =>  clr_o <= '0'; nxt_o  <= '1'; sto_o <= '0';vld_o <= '0' ; str_o <= '1' ;
    WHEN wtb_st   =>  clr_o <= '0'; nxt_o  <= '0'; sto_o <= '0';vld_o <= '0' ; str_o <= '1' ;
    END CASE;
  END PROCESS ausgabe;
  end ar1;