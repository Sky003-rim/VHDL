LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE IEEE.NUMERIC_STD.ALL    ;


ENTITY interface_fsm IS
  PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
        cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
        dv_i   :  IN STD_LOGIC;                     -- Have new count
       dne_i   :  IN STD_LOGIC;                     -- Last Bit transmitted
       sto_o   : OUT STD_LOGIC; 							 -- enable register load		
		str_o    : OUT STD_LOGIC ;							 --  transfer start
		vld_o   : OUT STD_LOGIC ;							 --  Data Valid			
       clr_o   : OUT STD_LOGIC;                     -- clear Bit-Counters
       nxt_o   : OUT STD_LOGIC);                    -- next Bit, inc count
  END interface_fsm;