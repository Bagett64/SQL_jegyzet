-- Csomag specifikációja (Fejléc)
CREATE OR REPLACE PACKAGE pkg_raktar IS
  gv_alap_keszlet NUMBER;
  
  FUNCTION get_keszlet_ertek(lv_id IN NUMBER) RETURN NUMBER;
  PROCEDURE ar_kalkulacio(lv_id IN NUMBER);
  PROCEDURE print_termek_boltok(lv_id IN NUMBER);
END pkg_raktar;
/

-- Csomag törzse
CREATE OR REPLACE PACKAGE BODY pkg_raktar IS

  -- 4/a: get_keszlet_ertek függvény
  FUNCTION get_keszlet_ertek(lv_id IN NUMBER) RETURN NUMBER IS
    v_keszlet NUMBER;
    v_ar      NUMBER;
  BEGIN
    SELECT bt.keszlet, bt.egysegar
      INTO v_keszlet, v_ar
      FROM bolt_termek bt
     WHERE bt.id = lv_id;
     
    RETURN v_keszlet * v_ar;
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN -1;
    WHEN TOO_MANY_ROWS THEN RETURN -2;
  END get_keszlet_ertek;

  -- 4/b: ar_kalkulacio eljárás (10%-os emelés)
  PROCEDURE ar_kalkulacio(lv_id IN NUMBER) IS
    v_keszlet NUMBER;
  BEGIN
    SELECT bt.keszlet
      INTO v_keszlet
      FROM bolt_termek bt
     WHERE bt.id = lv_id;
     
    IF v_keszlet < gv_alap_keszlet THEN
      UPDATE bolt_termek bt
         SET bt.egysegar = bt.egysegar * 1.1
       WHERE bt.id = lv_id;
    END IF;
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Hiba: Nincs ilyen bolt-termék adat!');
    WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE('Hiba: Túl sok találat az árkalkulációnál!');
  END ar_kalkulacio;

  -- 4/c: print_termek_boltok eljárás (kurzoros listázás)
  PROCEDURE print_termek_boltok(lv_id IN NUMBER) IS
    v_termek_nev VARCHAR2(250);
  BEGIN
    -- Termék nevének lekérdezése
    SELECT t.megnevezes
      INTO v_termek_nev
      FROM termek t
     WHERE t.id = lv_id;
     
    DBMS_OUTPUT.PUT_LINE('Termék: ' || v_termek_nev);
    DBMS_OUTPUT.PUT_LINE('Kapható az alábbi boltokban:');
    
    -- Boltok listázása kurzorral
    FOR c IN (SELECT b.nev
                FROM bolt_termek bt
                JOIN bolt b ON bt.bolt_id = b.id
               WHERE bt.termek_id = lv_id)
    LOOP
      DBMS_OUTPUT.PUT_LINE('- ' || c.nev);
    END LOOP;
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Hiba: Nem található a termék!');
    WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE('Hiba: Túl sok eredmény a terméknév lekérdezésekor!');
  END print_termek_boltok;

-- INICIALIZÁCIÓS BLOKK
BEGIN
  gv_alap_keszlet := 100;
END pkg_raktar;
/
