LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.all;
  USE IEEE.NUMERIC_STD.all;

-- --------------------------------------------------------------------

 PACKAGE top_pack IS

 CONSTANT debounce_const  : integer := 19;
 CONSTANT prescaler       : integer := 1250;
 CONSTANT clockspeed      : integer := 12000000;
 
 
COMPONENT Top IS
PORT(
  rb_i   : IN  std_logic;
  cp_i   : IN  std_logic;
  s1_i   : IN  std_logic;
  s2_i   : IN  std_logic;
  s3_i   : IN  std_logic;
  cl_i   : IN  std_logic;
  rb_o   : OUT std_logic;
  sec_o  : OUT std_logic;
  grn_o  : OUT std_logic;
  red_o  : OUT std_logic;
  tled_o : OUT std_logic;
  txd_o  : OUT std_logic;
  sdi_o  : OUT std_logic;
  sdv_o  : OUT std_logic;
  stx_o  : OUT std_logic
  );
END COMPONENT;
---------------------------------DESIGN UNITS -------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

COMPONENT baudrate_entity IS
  PORT (rb_i   :  IN STD_LOGIC;                   -- Reset, active low
        cp_i   :  IN STD_LOGIC;                   -- Syscp, @ 12MHz
        br_o   : OUT STD_LOGIC;                   -- Baud-Rate
      
        sec_o  : OUT STD_LOGIC);                  -- One-Second-Pulse					
END COMPONENT;

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

COMPONENT control_entity is
PORT(
		rb_i,																---reset active low
		 cp_i  ,																---System clock @ 12MHz
		 clr_i         : IN STD_LOGIC ;								---clear data

	  	 action_s      : IN 	STD_LOGIC_VECTOR(1 downto 0 )	; 
		
		 red_o ,																---RED LED high
		 green_o       : OUT STD_LOGIC ; 							--- GREEN LED high
		 clr_o         : OUT STD_LOGIC ;								--- Clear out
		 dv_o          : OUT STD_LOGIC  ;        					--- data valid out
		 events_s      : OUT STD_LOGIC_VECTOR( 7 downto 0) ) ;--- Events		
END COMPONENT;


------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

COMPONENT fsm_lightsensor is
PORT(
		      clr_i ,									   ----		CLEAR counter	
				cp_i 	,										----		SYSTEM CLOCK
				rb_i 	    :IN STD_LOGIC 	  ;		----		reset active low
				
				
				s1_i      :IN STD_LOGIC      ;
				s2_i      :IN STD_LOGIC      ;
				s3_i      :IN STD_LOGIC      ;      ----    Light sensors,active HIGH	
				inc_s ,  								   ----	  count up
				dec_s 	  :OUT STD_LOGIC 	  );		----	  count down	
END COMPONENT;

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
COMPONENT counter_entity is
PORT ( cp_i ,																--Sysclk
			 rb_i,																--reset 
			 inc_s ,																--increament		
			 dec_s ,                                              --decreament 
			 clr_i		   : IN STD_LOGIC ;                       -- clear
			 
			 hcount_s      : OUT STD_LOGIC_VECTOR (5 downto 0) ;  --Number of people
			 action_s	   : OUT STD_LOGIC_VECTOR (1 downto 0))  ;-- indicates people comin in, going out or max number is reached 						
END COMPONENT;


------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

COMPONENT uat IS
  PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
        cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
        br_i   :  IN STD_LOGIC;                     -- Baudrate, 1k2
        hcount_s   :  IN STD_LOGIC_VECTOR(5 DOWNTO 0); -- RTC or GPS-Data, 6x4BCD
		  action_s   :  IN STD_LOGIC_VECTOR(1 DOWNTO 0) ;
        dv_i   :  IN STD_LOGIC;
	txd_o  :  OUT STD_LOGIC);                -- Serial Data to RS23
END COMPONENT;

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

COMPONENT S3_interface is
PORT(rb_i   :  IN STD_LOGIC;                     -- Reset, active low
        cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
         
		  hcount_s   :  IN STD_LOGIC_VECTOR(5 DOWNTO 0);  -- count 
		  events_s   :  IN STD_LOGIC_VECTOR(7 DOWNTO 0) ; -- events
        dv_i   :  IN STD_LOGIC; 		  -- data valid
		  sd_o   :  OUT STD_LOGIC;		  -- Serial data out
		  sdv_o  :  OUT STD_LOGIC ;    -- Serial data valid
		  stx_o  :  out STD_LOGIC ) ;  -- Serial transfer start
END COMPONENT;








-----------------------------------------------UART COMPONENTS---------------------------------------------------------------------------------------------------


COMPONENT reg24e IS
PORT(
  rb_i : IN STD_LOGIC;
  cp_i : IN STD_LOGIC;
  en_i : IN STD_LOGIC;
  d_i  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  q_o  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

---------------------------------------------------------------------------------------------------------------------

COMPONENT uat_fsm IS
PORT (rb_i   :  IN STD_LOGIC;                    
     cp_i   :  IN STD_LOGIC; 
	 br_i   :  IN STD_LOGIC;        
     dv_i   :  IN STD_LOGIC;                               
     dne_i   :  IN STD_LOGIC;                    
     sto_o   : OUT STD_LOGIC;                    
     clr_o   : OUT STD_LOGIC;                     
     nxt_o   : OUT STD_LOGIC     
     );
END COMPONENT;

---------------------------------------------------------------------------------------------------------------------

COMPONENT reg8 IS
  PORT (rb_i,cp_i :  IN STD_LOGIC;
        en_i      :  IN STD_LOGIC;
        d_s       :  IN STD_LOGIC_VECTOR (5 DOWNTO 0) ;
		  act_s    :  IN STD_LOGIC_VECTOR (1 DOWNTO 0) ;
        q_o       : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) );
END COMPONENT;

---------------------------------------------------------------------------------------------------------------------

COMPONENT c11bin IS
PORT (rb_i   :  IN STD_LOGIC;                     
      cp_i   :  IN STD_LOGIC;                     
      en_i   :  IN STD_LOGIC;                     
      cl_i   :  IN STD_LOGIC;                    
      co_o   : OUT STD_LOGIC;                     
       q_o   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)   
      );
END COMPONENT;

---------------------------------------------------------------------------------------------------------------------

COMPONENT mx2sem3 IS
  PORT (s_i  :  IN STD_LOGIC_VECTOR(  3 DOWNTO 0);  -- get bits
        d_i  :  IN STD_LOGIC_VECTOR(  15 DOWNTO 0);  --headcount and events
      txd_o  : OUT STD_LOGIC);                      -- txd, Serial Output           
END COMPONENT;

----------------------INTERFACE COMPONENTS---------------------------------------------------------------------------------------------------

COMPONENT interface_fsm IS
  PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
        cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
        dv_i   :  IN STD_LOGIC;                     -- Have new count
       dne_i   :  IN STD_LOGIC;                     -- Last Bit transmitted
       sto_o   : OUT STD_LOGIC; 							 -- enable register load		
		str_o    : OUT STD_LOGIC ;							 --  transfer start
		vld_o   : OUT STD_LOGIC ;							 --  Data Valid			
       clr_o   : OUT STD_LOGIC;                     -- clear Bit-Counters
       nxt_o   : OUT STD_LOGIC);                    -- next Bit, inc count
END COMPONENT;

---------------------------------------------------------------------------------------------------------------------

COMPONENT c14bin IS
  PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
        cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
        en_i   :  IN STD_LOGIC;                     -- Enable Count
        cl_i   :  IN STD_LOGIC;                     -- Clear Counter
        co_o   : OUT STD_LOGIC;                     -- Carry Out
         q_o   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) );-- Counter Value

END COMPONENT;

--------------------------------------------------------------------------------------------------------------------

COMPONENT mx2tdo IS
  PORT (s_i  :  IN STD_LOGIC_VECTOR(  3 DOWNTO 0);  -- get bits
        d_i  :  IN STD_LOGIC_VECTOR(  7 DOWNTO 0);  --headcount and action 
      txd_o  : OUT STD_LOGIC);                      -- txd, Serial Output
END COMPONENT;

--------------------------------------------------------------------------------------------------------------------------
END top_pack;