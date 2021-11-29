
-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.top_pack.ALL;


-- ----------------------------------------------------------------------------

ENTITY ls_tb IS END ls_tb ;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF ls_tb  IS

  -- input
  SIGNAL clr_s,rb_s,cp_s,s1_s,s2_s,s3_s : std_logic;
  -- output
  SIGNAL inc_s ,dec_s : std_logic;

BEGIN
  
  -- Modules -----------------------------------------

    gates : fsm_lightsensor PORT MAP (clr_s,cp_s,rb_s,s1_s, s2_s, s3_s,inc_s ,dec_s) ; 		
				
  
  -- Process -----------------------------------------
  runTB : PROCESS
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rb_s <= '1';
    cp_s   <= '0';
    s1_s    <= '0';
    s2_s    <= '0';
    s3_s    <= '0'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 2: Do a reset-cycle
-- ----------------------------------------------------------------------------
    rb_s <= '0'; WAIT FOR 100 NS;
    rb_s <= '1'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 3: Run Test-Patterns
-- ----------------------------------------------------------------------------
-- Some SYScp-cycles:
    cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
-- Send Enter Code
    cp_s <= '1'; WAIT FOR  10 NS;
      s1_s  <= '1'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR  10 NS;
      s1_s  <= '0'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR  10 NS;
      s2_s  <= '1'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR  10 NS;
      s2_s  <= '0'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR  10 NS;
      s3_s  <= '1'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR  10 NS;
      s3_s  <= '0'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;

    
    WAIT FOR 10 NS;
    ASSERT (inc_s = '0') REPORT "Enter triggered" SEVERITY note;
    ASSERT (inc_s = '1') REPORT "Enter not triggered" SEVERITY warning;

-- Some SYScp-cycles:
    cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
-- Send Leave Code
    cp_s <= '1'; WAIT FOR  10 NS;
      s3_s  <= '1'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR  10 NS;
      s3_s  <= '0'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR  10 NS;
      s2_s  <= '1'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR  10 NS;
      s2_s  <= '0'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR  10 NS;
      s1_s  <= '1'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR  10 NS;
      s1_s  <= '0'; WAIT FOR  90 NS;
    cp_s <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (dec_s = '0') REPORT "Leave triggered" SEVERITY note;
    ASSERT (dec_s = '1') REPORT "Leave not triggered" SEVERITY warning;

-- Some SYScp-cycles:
    cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
    cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;

-- ----------------------------------------------------------------------------
    cp_s <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------

    WAIT FOR 10 NS;
    ASSERT (false) REPORT "Done" SEVERITY error;

    WAIT;
  END PROCESS runTB;
END ar1;

