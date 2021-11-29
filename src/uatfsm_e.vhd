LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
	  USE work.top_pack.ALL;


ENTITY uat_fsm IS
  PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
        cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
        dv_i   :  IN STD_LOGIC;                     -- Have new count
        br_i   :  IN STD_LOGIC;                     -- Baud-Rate to ena Counter
       dne_i   :  IN STD_LOGIC;                     -- Last Bit transmitted
       sto_o   : OUT STD_LOGIC;                     -- enable register load
       clr_o   : OUT STD_LOGIC;                     -- clear Bit-Counters
       nxt_o   : OUT STD_LOGIC);                    -- next Bit, inc count
  END uat_fsm;
  