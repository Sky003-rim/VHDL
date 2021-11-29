LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
   USE work.top_pack.ALL;

-- ----------------------------------------------------------------------------
ENTITY uat IS
  PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
        cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
        br_i   :  IN STD_LOGIC;                     -- Baudrate, 1k2
        hcount_s   :  IN STD_LOGIC_VECTOR(5 DOWNTO 0); -- RTC or GPS-Data, 6x4BCD
		  action_s   :  IN STD_LOGIC_VECTOR(1 DOWNTO 0) ;
        dv_i   :  IN STD_LOGIC;
	txd_o  :  OUT STD_LOGIC);                -- Serial Data to RS23
  END ENTITY;