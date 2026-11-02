CREATE OR REPLACE FUNCTION get_termek_adatok(lv_termek_azonosito IN NUMBER)
  RETURN ty_termek_type IS
  v_eredmeny ty_termek_type := ty_termek_type();
BEGIN
  SELECT t.id, t.megnevezes
    INTO v_eredmeny.termekazonosito, v_eredmeny.megnevezes
    FROM termek t
   WHERE t.id = lv_termek_azonosito;

  RETURN v_eredmeny;
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN ty_termek_type();
  WHEN TOO_MANY_ROWS THEN
    RETURN NULL;
END;
/
