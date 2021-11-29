
  
-- ----------------------------------------------------------------------------

ARCHITECTURE ar2 OF counter_entity IS

  -- Internal Signals --------------------------------
  SIGNAL count_s : UNSIGNED(5 DOWNTO 0); 
 
 
 BEGIN
run: PROCESS (cp_i, rb_i, inc_s, dec_s,count_s)
  BEGIN
    IF    (rb_i = '0')THEN count_s <= (OTHERS=>'0'); 
			   action_s <="00";
    ELSIF (cp_i'EVENT AND cp_i = '1') THEN
      IF    (inc_s = '1' AND dec_s = '0') THEN 
						IF (count_s = 000011) THEN
						action_s<= "11" ;
						ELSE count_s <= count_s + 1; action_s <="01" ;
						END IF ;
      ELSIF (dec_s = '1' AND inc_s = '0') THEN
		IF (count_s = 000000) THEN
						action_s <= "00" ;
						ELSE count_s <= count_s - 1; action_s <="10" ;
						END IF ;
		ELSE action_s <= "00" ;
      END IF;
    END IF;
  hcount_s <= STD_LOGIC_VECTOR(count_s);
  END PROCESS run;


  -- Output ------------------------------------------



END ar2;

-- ----------------------------------------------------------------------------
