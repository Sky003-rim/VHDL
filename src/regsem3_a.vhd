
  ARCHITECTURE ar1 OF reg14 IS

  SIGNAL state_s : STD_LOGIC_VECTOR (15 DOWNTO 0);

  BEGIN
  ldx : PROCESS (rb_i,cp_i,state_s)
   BEGIN
   IF (rb_i='0') THEN state_s <= B"0000000000000000";
   ELSIF (cp_i='1' AND cp_i'EVENT)
    THEN
     IF  (en_i='1') THEN state_s(7 DOWNTO 0)<=event_s ;
			 state_s(13 DOWNTO 8)<= d_s ;  
			 state_s(15 DOWNTO 14) <= "00" ;
	  END IF;	
   END IF;
   END PROCESS ldx;
  q_o <= state_s;
  END ar1;