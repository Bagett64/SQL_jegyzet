CREATE OR REPLACE FUNCTION get_termek_nevek_by_bolt(lv_bolt_id IN NUMBER)
  RETURN VARCHAR2 IS
  v_darab    NUMBER := 0;
  v_eredmeny VARCHAR2(500);
BEGIN
  SELECT COUNT(*)
    INTO v_darab
    FROM bolt_termek bt
   WHERE lv_bolt_id = bt.bolt_id;

  IF v_darab = 0
  THEN
    RETURN 'Nincs termek';
  ELSIF v_darab = 1
  THEN
    SELECT t.megnevezes
      INTO v_eredmeny
      FROM bolt_termek bt
      JOIN termek t
        ON bt.termek_id = t.id
     WHERE bt.bolt_id = lv_bolt_id;
    RETURN v_eredmeny;
  ELSE
    SELECT listagg(t.megnevezes, ', ') within GROUP(ORDER BY t.megnevezes)
      INTO v_eredmeny
      FROM bolt_termek bt
      JOIN termek t
        ON bt.termek_id = t.id
     WHERE bt.bolt_id = lv_bolt_id;
    RETURN v_eredmeny;
  END IF;
END;
