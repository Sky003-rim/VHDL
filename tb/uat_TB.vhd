-- ----------------------------------------------------------------------------
  library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
USE work.top_pack.ALL;
-- ----------------------------------------------------------------------------
  ENTITY TB1_uat IS END TB1_uat;

-- ----------------------------------------------------------------------------
  ARCHITECTURE ar1 OF TB1_uat
  IS
  SIGNAL rb_s,cp_s,br_s,dv_s,txd_s : STD_LOGIC;
  SIGNAL d_s : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL action_s : STD_LOGIC_VECTOR (1 DOWNTO 0) ;
  BEGIN
  
  uux :  uat PORT MAP (rb_s,cp_s,br_s,d_s,action_s,dv_s,txd_s ) ;
  
  runTB : PROCESS
          VARIABLE dotimes  : INTEGER :=   0;
          VARIABLE so_long  : INTEGER := 110;
          BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
           rb_s  <= '1';
           cp_s  <= '0';
           br_s  <= '0';
           d_s   <=  B"010111";
	  action_s <= "01" ;
           dv_s  <= '0'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 2: Do a reset-cycle
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
-- ----------------------------------------------------------------------------
-- Now we set dv_s=log1.
-- The next rising slope of cp_i stores 6x4Bits into register

           cp_s  <= '1'; WAIT FOR  10 NS; dv_s  <= '1'; WAIT FOR  90 NS;
           cp_s  <= '0'; WAIT FOR 100 NS;
           cp_s  <= '1'; WAIT FOR  10 NS; dv_s  <= '0'; WAIT FOR  90 NS;

           cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
           cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;	
           cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
           cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
           cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
	ASSERT (dv_s = '1') REPORT "data valid" SEVERITY note;
-- ----------------------------------------------------------------------------
-- Now we set br_s=log1. (duration: one SYScp-Period (@12MHz ca. 80ns)
-- This causes the uat-fsm to start the transmission of the packet

           cp_s  <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS;
--         cp_s  <= '1';  br_s  <= '1'; WAIT FOR  100 NS;
           cp_s  <= '0'; WAIT FOR 100 NS;
           cp_s  <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS;
	   ASSERT (br_s = '1') REPORT "baud high" SEVERITY note;
--         cp_s  <= '1';  br_s  <= '0'; WAIT FOR  100 NS;
           cp_s  <= '0'; WAIT FOR 100 NS;	
           cp_s  <= '1'; WAIT FOR 100 NS;
           cp_s  <= '0'; WAIT FOR 100 NS;		  
           cp_s  <= '1'; WAIT FOR 100 NS;
           cp_s  <= '0'; WAIT FOR 100 NS;		  
           cp_s  <= '1'; WAIT FOR 100 NS;
           cp_s  <= '0'; WAIT FOR 100 NS;		  
-- ----------------------------------------------------------------------------
-- The LOOP-Statement is very handy for repeated activities
--
           FOR dotimes IN 1 TO so_long
           LOOP  
           cp_s  <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS;
--         cp_s  <= '1';  br_s  <= '1'; WAIT FOR  100 NS;
           cp_s  <= '0'; WAIT FOR 100 NS;
           cp_s  <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS;
--         cp_s  <= '1';  br_s  <= '0'; WAIT FOR  100 NS;
           cp_s  <= '0'; WAIT FOR 100 NS;	
           cp_s  <= '1'; WAIT FOR 100 NS;  
           cp_s  <= '0'; WAIT FOR 100 NS;		  
           cp_s  <= '1'; WAIT FOR 100 NS;
           cp_s  <= '0'; WAIT FOR 100 NS;		  
           cp_s  <= '1'; WAIT FOR 100 NS;
           cp_s  <= '0'; WAIT FOR 100 NS;
           END LOOP;			  
-- ---------------------------------------------------------------------------- 	  
           cp_s  <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------
        WAIT FOR 10 NS;
    	ASSERT (false) REPORT "Done" SEVERITY error;
	   WAIT;
	  END PROCESS runTB;
-- ----------------------------------------------------------------------------
	END ar1;-------
-- ----------------------------------------------------------------------------
	
  
  
  
  
