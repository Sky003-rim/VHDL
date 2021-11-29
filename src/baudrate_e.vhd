LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE IEEE.NUMERIC_STD.ALL;
  USE work.top_pack.ALL;
-- ----------------------------------------------------------------------------
  ENTITY baudrate_entity IS
  PORT (rb_i   :  IN STD_LOGIC;                   -- Reset, active low
        cp_i   :  IN STD_LOGIC;                   -- Syscp, @ 12MHz
        br_o   : OUT STD_LOGIC;                   -- Baud-Rate
      
        sec_o  : OUT STD_LOGIC);                  -- One-Second-Pulse
  END baudrate_entity;