
    ARCHITECTURE ar1 OF uat IS

  SIGNAL qr_s    : STD_LOGIC_VECTOR(7 DOWNTO 0);   -- 8 bits 
  SIGNAL q1_s    : STD_LOGIC_VECTOR( 3 DOWNTO 0);   -- mux 4bits 
  

  SIGNAL ld_s    : STD_LOGIC;                       -- Signal store 8 for tx
  SIGNAL nxt_s   : STD_LOGIC;                       -- Next Bit
  SIGNAL clr_s   : STD_LOGIC;                       -- Clear Counters
  SIGNAL dne_s   : STD_LOGIC;                       -- Last Bit of input

  SIGNAL txd_s   : STD_LOGIC;

  BEGIN
ufsm :entity work.uat_fsm PORT MAP (rb_i,cp_i,dv_i,br_i,
                        dne_s,ld_s,clr_s,nxt_s);							----uat fsm

reg01: entity work.reg8  PORT MAP (rb_i,cp_i,ld_s,hcount_s,action_s,qr_s);   -- 1X8 Bit Register

uatc1: entity work.c11bin  PORT MAP (rb_i,cp_i,nxt_s,clr_s,dne_s,q1_s); -- counter of 11
  
  
mx12b: entity work.mx2tdo  PORT MAP (q1_s,qr_s,txd_s);                 -- load data

                           

  txd_o <= txd_s; 
 
 END ar1;