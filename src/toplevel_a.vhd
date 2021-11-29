		
		ARCHITECTURE ar1 OF toplevel_e IS
		
		ATTRIBUTE chip_pin : string;
	
		   ATTRIBUTE chip_pin of rb_i    : SIGNAL IS  "E6"; -- S1_USR_BTN_akt_low;low logic when pressed
    ATTRIBUTE chip_pin of cp_i    : SIGNAL IS  "H6"; -- CLK_12MHz
    
	---------------------------Input Sensor ------------------------------------------------------------ 
    
	ATTRIBUTE chip_pin of clr_i      : SIGNAL IS  "H5"; --pin 11  
    ATTRIBUTE chip_pin of s1_i      : SIGNAL IS  "H4"; --pin 12  
    ATTRIBUTE chip_pin of s2_i      : SIGNAL IS  "J1"; --pin 13  
    ATTRIBUTE chip_pin of s3_i      : SIGNAL IS  "J2"; --pin 14  
	
  ---------------------------Output------------------------------------------------------------------- 
    
	ATTRIBUTE chip_pin of   rst_led   : SIGNAL IS  "A8";  --led1 - reset
    ATTRIBUTE chip_pin of   sec_o   : SIGNAL IS  "A9";  --led2  second pulse 
    ATTRIBUTE chip_pin of   red_o   : SIGNAL IS "A11"; --pin 6  
    ATTRIBUTE chip_pin of   green_o   : SIGNAL IS "A10"; --pin 5 

   
    -------------------------------UART Transmission----------------------------------------------
    ATTRIBUTE chip_pin of txd_o      : SIGNAL IS  "G12"; 				--Serial data  
	ATTRIBUTE chip_pin of tx_led  : SIGNAL IS  "B10"; 				--Serial data Active
    --ATTRIBUTE chip_pin of lbt_o   : SIGNAL IS  "A10"; 				--Transmission Complete
	
	
    -------------------------------- STATUS LED-----------------------------------------------------
   


 ----------------------------------PINS TO IC_s3-----------------------------------------------------
	ATTRIBUTE chip_pin of sdo_o     : SIGNAL IS  "J13"; --serial data           pin 3 
	ATTRIBUTE chip_pin of stx_o     : SIGNAL IS  "J12"; --Serial transmitting   pin 2 
	ATTRIBUTE chip_pin of sdv_o     : SIGNAL IS  "L12"; --Serial data valid     pin 1
	
	
SIGNAL br_s:  STD_LOGIC; --baudrate signal


SIGNAL inc_s: STD_LOGIC; --increament counter
SIGNAL dec_s: STD_LOGIC; --decreament counter
SIGNAL clr_s : STD_LOGIC ;-- clear


SIGNAL action_s : STD_LOGIC_VECTOR(1 DOWNTO 0) ; --events
SIGNAL hcount_s :	 STD_LOGIC_VECTOR (5 DOWNTO 0) ;-- number of people
SIGNAL  events_s :  STD_LOGIC_VECTOR (7 DOWNTO 0) ; --events
SIGNAL sec_s :STD_LOGIC ;
SIGNAL txd_s :STD_LOGIC ;
SIGNAL dv_s : STD_LOGIC ;

BEGIN

baud   :  baudrate_entity PORT MAP(rb_i,cp_i,br_s,sec_s) ;
gates  : fsm_lightsensor PORT MAP (clr_s,cp_i,rb_i,s1_i,s2_i,s3_i,inc_s ,dec_s) ; 	  		
number :  counter_entity PORT MAP(cp_i ,rb_i, inc_s ,dec_s ,clr_s,hcount_s,action_s) ;	
EVENTS :  control_entity PORT MAP (rb_i,cp_i,clr_i,action_s,red_o ,green_o,clr_s, dv_s,events_s) ;   
UART   :  uat PORT MAP (rb_i,cp_i,br_s,hcount_s,action_s,dv_s,txd_s ) ;
SEM3   :  S3_interface PORT MAP (rb_i,cp_i,hcount_s,events_s,dv_s,sdo_o,sdv_o,stx_o) ;  
 
 rst_led <= NOT(rb_i) ;
 tx_led <= txd_s ;
 txd_o <= txd_s ;
 sec_o <= sec_s ;

 END ar1 ;