CREATE OR REPLACE FUNCTION get_termek_adatok(lv_termek_azonostio IN NUMBER)
  RETURN ty_termek_type IS
  v_eredmeny ty_termek_type := ty_termek_type();
BEGIN
  SELECT t.id
        ,t.megnevezes
    INTO v_eredmeny.termekazonosito
        ,v_eredmeny.megnevezes
    FROM termek t
   WHERE t.id = lv_termek_azonostio;

  RETURN v_eredmeny;

EXCEPTION
WHEN no_data_found THEN RETURN ty_termek_type(); WHEN too_many_rows THEN RETURN NULL;
END;
/
