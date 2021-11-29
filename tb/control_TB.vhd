-- ----------------------------------------------------------------------------
  library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.all    ;
USE work.top_pack.ALL;
-- ----------------------------------------------------------------------------
  ENTITY TB1_controlfsm IS END TB1_controlfsm ;
-- ----------------------------------------------------------------------------
  ARCHITECTURE ar1 OF TB1_controlfsm  IS
  SIGNAL rb_s,cp_s,dv_s,clr_i,clr_o,red_s,green_s: STD_LOGIC;
  SIGNAL action_s : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL events_s : STD_LOGIC_VECTOR (7 DOWNTO 0) ;
  BEGIN
  
  uux :control_entity PORT MAP (rb_s,cp_s,clr_i,action_s,red_s ,green_s,clr_o, dv_s,events_s) ; 
  
  runTB : PROCESS
          VARIABLE dotimes  : INTEGER :=   0;
          VARIABLE so_long  : INTEGER := 110;
          BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PIPS
-- ----------------------------------------------------------------------------
           rb_s  <= '1';
           cp_s  <= '0';
	
	 clr_i <= '0' ;
	  --events_s <= "00000000" ;
  
-- ----------------------------------------------------------------------------
--STEP 2: Do a reset-cycle
-- ----------------------------------------------------------------------------
    rb_s  <= '0'; WAIT FOR 100 NS;
    rb_s  <= '1'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 3: Run Test-Patterns
-- ----------------------------------------------------------------------------
-- Some SYScp-cycles:
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- The next rising slope of cp_i stores 6x4Bits into register
    cp_s  <= '1'; WAIT FOR  10 NS; action_s  <= "01"; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
	ASSERT (action_s = "01") REPORT "increase" SEVERITY note;

	 cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
  	cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    	cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
   	 cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
	 
	 cp_s  <= '1'; WAIT FOR  10 NS; action_s  <= "11"; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
	ASSERT (action_s = "11") REPORT "MAX" SEVERITY note;
	 cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;

	  cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
  	cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    	cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
   	 cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;

	cp_s  <= '1'; WAIT FOR  10 NS; action_s  <= "10"; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
	ASSERT (action_s = "10") REPORT "decrement" SEVERITY note;
	 cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
  	cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
  	cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    	cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
   	 cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
	 
    -- The LOOP-Statement is very handy for repeated activities
    FOR dotimes IN 1 TO so_long LOOP
  -- Some SYScp-cycles:
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    END LOOP;

-- ---------------------------------------------------------------------------- 	  
    cp_s  <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------
      ASSERT (false) REPORT "Done" SEVERITY error;
WAIT ;
  END PROCESS runTB;
END ar1;
  
  
  
  
