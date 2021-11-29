-- ----------------------------------------------------------------------------
  library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
USE work.top_pack.ALL;
-- ----------------------------------------------------------------------------
  ENTITY TB1_interface IS END TB1_interface;
-- ----------------------------------------------------------------------------
  ARCHITECTURE ar1 OF TB1_interface IS
  SIGNAL rb_s,cp_s,dv_s,txd_s,sdv_s,stx_s : STD_LOGIC;
  SIGNAL d_s : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL event_s : STD_LOGIC_VECTOR (7 DOWNTO 0) ;
  BEGIN
  
  uux :S3_interface PORT MAP (rb_s,cp_s,d_s,event_s,dv_s,txd_s,sdv_s,stx_s) ;  
  
  runTB : PROCESS
          VARIABLE dotimes  : INTEGER :=   0;
          VARIABLE so_long  : INTEGER := 110;
          BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PIPS
-- ----------------------------------------------------------------------------
           rb_s  <= '1';
           cp_s  <= '0';
           d_s   <=  B"010101";
	  event_s <= "01100011" ;
           dv_s  <= '0'; WAIT FOR 100 PS;
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
    cp_s  <= '1'; WAIT FOR  10 NS; dv_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; dv_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    
	ASSERT (dv_s = '1') REPORT "data valid" SEVERITY note;
	
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
WAIT FOR 10 NS;
    ASSERT (false) REPORT "Done" SEVERITY error;
WAIT ;
  END PROCESS runTB;
END ar1;
  
  
  
  
