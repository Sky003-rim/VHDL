
		

		
		ARCHITECTURE ar1 OF S3_interface IS
		
		
	
  SIGNAL qr_s    : STD_LOGIC_VECTOR(15 DOWNTO 0);   -- 14 bits 
  SIGNAL q1_s    : STD_LOGIC_VECTOR( 3 DOWNTO 0);   -- mux 1 Byte
  

  SIGNAL ld_s    : STD_LOGIC;                       -- Signal store 8 for tx
  SIGNAL nxt_s   : STD_LOGIC;                       -- Next Bit
  SIGNAL clr_s   : STD_LOGIC;                       -- Clear Counters
  SIGNAL dne_s   : STD_LOGIC;                       -- Last Bit of input

  SIGNAL txd_s   : STD_LOGIC;
  
  BEGIN
ifsm :entity work.interface_fsm PORT MAP (rb_i,cp_i,dv_i,
                        dne_s,ld_s,stx_o,sdv_o,clr_s,nxt_s);							----interface fsm

reg01: entity work.reg14  PORT MAP (rb_i,cp_i,ld_s,hcount_s,events_s,qr_s);   -- 14 Bit Register

interfacec16: entity work.c14bin  PORT MAP (rb_i,cp_i,nxt_s,clr_s,dne_s,q1_s); -- counter of 16
  
  
mx12b: entity work.mx2sem3  PORT MAP (q1_s,qr_s,txd_s);                 -- load data

                           

 sd_o <= txd_s; 
 
 END ar1;