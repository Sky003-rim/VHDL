LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE work.top_pack.ALL;

ENTITY reg14 IS
  PORT (rb_i,cp_i :  IN STD_LOGIC;
        en_i      :  IN STD_LOGIC;
        d_s       :  IN STD_LOGIC_VECTOR (5 DOWNTO 0) ;
		  event_s    :  IN STD_LOGIC_VECTOR (7 DOWNTO 0) ;
        q_o       : OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
  END reg14;
