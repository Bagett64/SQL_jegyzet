PL/SQL Developer Test script 3.0
7
declare
  -- Non-scalar parameters require additional processing 
  result ty_termek_type;
begin
  -- Call the function
  result := get_termek_adatok(lv_termek_azonostio => :lv_termek_azonostio);
end;
1
lv_termek_azonostio
1
9000
4
0
