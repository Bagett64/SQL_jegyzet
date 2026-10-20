-- 0. feladat
-- Ha már létezik a séma, eldobjuk (futásához DBA jogosultság vagy megfelelő admin jog kellhet)
BEGIN
    FOR u IN (SELECT username FROM dba_users WHERE username = 'KONYVTAR') LOOP
        EXECUTE IMMEDIATE 'DROP USER KONYVTAR CASCADE';
    END LOOP;
END;
/

-- Séma (felhasználó) létrehozása
CREATE USER KONYVTAR IDENTIFIED BY "konyvtar Jelszo";

-- Megfelelő jogok adása
GRANT CONNECT, RESOURCE, DBA TO KONYVTAR;

-- Átváltás a sémára
ALTER SESSION SET CURRENT_SCHEMA = KONYVTAR;
