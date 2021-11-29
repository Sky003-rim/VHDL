
ARCHITECTURE ar1 of baudrate_entity is
SIGNAL counter:integer range 1 to prescaler+1;





Begin
clkd :PROCESS(rb_i,cp_i)
 Begin
    IF(rb_i = '0')THEN
       br_o<='0';
       counter <= 1;

    ELSIF(cp_i'EVENT AND cp_i='1')then
          counter<=counter+1;
       if(counter=prescaler)then
            br_o<='1';
            counter<=1;
       else
            br_o<='0';
       end if;
    END IF;

end process clkd;


  
--------------Comes now the Hearbeat signal--------------------------
Heartbeat : process(cp_i, rb_i)
        variable count : natural range 0 to clockspeed;
    begin
        if  (rb_i = '0' )then
            count := 0;
            sec_o <= '1';
        elsif rising_edge(cp_i) then
            count := count + 1;
            if count < clockspeed/2 then                 
                sec_o  <= '1';
            elsif count < clockspeed then
                 sec_o <= '0';
            else
                 sec_o  <= '1';
                 count := 0;
            end if;
        end if;
    end process Heartbeat ; 



end  ar1;