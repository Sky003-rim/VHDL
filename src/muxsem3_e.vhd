 LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE IEEE.NUMERIC_STD.ALL    ;
    USE work.top_pack.ALL;
-- ----------------------------------------------------------------------------
  ENTITY mx2sem3 IS
  PORT (s_i  :  IN STD_LOGIC_VECTOR(  3 DOWNTO 0);  -- get bits
        d_i  :  IN STD_LOGIC_VECTOR(  15 DOWNTO 0);  --headcount and events
      txd_o  : OUT STD_LOGIC);                      -- txd, Serial Output
  END mx2sem3;