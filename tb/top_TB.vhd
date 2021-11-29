library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all    ;
USE work.top_pack.ALL;

ENTITY top_TB IS 

END top_TB ;


ARCHITECTURE ar1 OF top_TB IS 
SIGNAL rb_s,cp_s,br_s,clr_s : STD_LOGIC;  -- INPUT

SIGNAL inc_s,dec_s,dv_s,s1_s,s2_s,s3_s : STD_LOGIC;
SIGNAL events_s: STD_LOGIC_VECTOR(7 DOWNTO 0); SIGNAL hcount_s : STD_LOGIC_VECTOR(5 DOWNTO 0) ;
SIGNAL action_s : STD_LOGIC_VECTOR(1 DOWNTO 0) ;
-- output
SIGNAL green_s,red_s,txd_s,sdo_s,sdv_s,stx_s,sec_s : STD_LOGIC;

BEGIN
--baud :  entity work.baudrate_entity PORT MAP(rb_s,cp_s,br_s,sec_s) ;

	  gates : fsm_lightsensor PORT MAP (clr_s,cp_s,rb_s,s1_s, s2_s, s3_s,inc_s ,dec_s) ; 	  		
number :counter_entity PORT MAP(cp_s ,rb_s, inc_s ,dec_s ,clr_s,hcount_s,action_s) ;	

EVENTS : control_entity PORT MAP (rb_s,cp_s,clr_s,action_s,red_s ,green_s,clr_s, dv_s,events_s) ;   
UART : uat PORT MAP (rb_s,cp_s,br_s,hcount_s,action_s,dv_s,txd_s ) ;
SEM3   : S3_interface PORT MAP (rb_s,cp_s,hcount_s,events_s,dv_s,sdo_s,sdv_s,stx_s) ;  


runTB : PROCESS

VARIABLE dotimes  : INTEGER :=   0;
VARIABLE so_long  : INTEGER := 30;
VARIABLE amount : INTEGER := 12;
-------------------INIT EVERYTHIN------------------------------------------------------------
BEGIN
rb_s <= '1' ; clr_s <= '0' ;  
cp_s  <= '0';
s1_s <= '0'; s2_s <= '0';s3_s <= '0';
br_s <= '0'    ; WAIT FOR 10 NS;
sec_s <= '0' ;


-------------------------------RESET CYCLE-----------------------------------------------------

rb_s <= '0' ; WAIT FOR 100 NS ;
rb_s <= '1' ;WAIT FOR 100 NS  ;

--------------------------------CLOCK CYCLES---------------------------------------------------

cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
-----------------CLOCK CYCLES----------------------------------------------------------------------
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
--------------------------------PEOPLE COMING----------------------------------------------------

cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;

ASSERT (inc_s = '1') REPORT "Person Entered" SEVERITY note;

--------------------------------BAUD CYCLES---------------------------------------------------
FOR dotimes IN 1 TO amount LOOP
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '1'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '0'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
END LOOP ;	
-----------------CLOCK CYCLES----------------------------------------------------------------------
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;



--------------------------------------------------------------------------------------------	
--------------------------------PEOPLE COMING----------------------------------------------------
cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
ASSERT (inc_s = '1') REPORT "Person Entered" SEVERITY note;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;

cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;

cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;  
--------------------------------BAUD CYCLES---------------------------------------------------
FOR dotimes IN 1 TO amount LOOP
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '1'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '0'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
END LOOP ;	

cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;


-----------------CLOCK CYCLES----------------------------------------------------------------------
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;

--------------------------------BAUD CYCLES---------------------------------------------------
FOR dotimes IN 1 TO amount LOOP
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '1'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '0'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
END LOOP ;	

-------------------------------PEOPLE COMING IN----------------------------------------------

cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
ASSERT (inc_s = '1') REPORT "Person Entered" SEVERITY note;

cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;


FOR dotimes IN 1 TO amount LOOP
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '1'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '0'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
END LOOP ;	


cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
ASSERT (inc_s = '1') REPORT "Person Entered" SEVERITY note;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;


FOR dotimes IN 1 TO amount LOOP
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '1'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '0'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
END LOOP ;	


cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
ASSERT (inc_s = '1') REPORT "Person Entered" SEVERITY note;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;


FOR dotimes IN 1 TO amount LOOP
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '1'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '0'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
END LOOP ;	

ASSERT (red_s = '1') REPORT "MAX reached" SEVERITY note;


--------------------------------PEOPLE LEAVING----------------------------------------------------
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
ASSERT (dec_s = '1') REPORT "Person left" SEVERITY note;

cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;


--------------------------------BAUD CYCLES---------------------------------------------------
FOR dotimes IN 1 TO amount LOOP
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '1'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '0'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
END LOOP ;	
--------------------------------PEOPLE LEAVING----------------------------------------------------
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
ASSERT (dec_s = '1') REPORT "Person left" SEVERITY note;

cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;

--------------------------------BAUD CYCLES---------------------------------------------------
FOR dotimes IN 1 TO amount LOOP
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '1'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '0'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
END LOOP ;	
--------------------------------PEOPLE LEAVING----------------------------------------------------
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s3_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s2_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '1' ; WAIT FOR 90 NS ; cp_s  <= '0'; WAIT FOR 100 NS;
ASSERT (dec_s = '1') REPORT "Person left" SEVERITY note;

cp_s <= '1'; WAIT FOR 10 NS; s1_s <= '0' ; WAIT FOR 90 NS; cp_s  <= '0'; WAIT FOR 100 NS;

--------------------------------BAUD CYCLES---------------------------------------------------
FOR dotimes IN 1 TO amount LOOP
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '1'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR  10 NS;
br_s  <= '0'; WAIT FOR  90 NS;
cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s <= '0'; WAIT FOR 100 NS;
END LOOP ;	



FOR dotimes IN 1 TO so_long LOOP
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 	
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
cp_s <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS; 			
END LOOP ;	

--------------------------------------------------------------------------------------------	
cp_s <= '0'; WAIT FOR 500 NS;

WAIT FOR 10 NS;
ASSERT (false) REPORT "Done" SEVERITY error;
WAIT ;
END PROCESS runTB;
END ar1 ;
