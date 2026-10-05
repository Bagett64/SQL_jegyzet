--------------------------------------------------------------------------------
-- Oracle adatbázis a gyakorlatban
-- 4. gyakorlat
-- Táblák, Nézetek, Indexek, Megszorítások készítése (FK, UK, CK...)
--------------------------------------------------------------------------------

-- / #01 / -------------------------------------------------------------
-- Hozzuk létre a PERSON táblát a 01_dog_manager.sql -el.
------------------------------------------------------------------------


-- / #02 / -------------------------------------------------------------
-- Az elsõdleges kulcshoz az indexet automatikusan létrehozza az Oracle,
-- úgy mint UNIQUE INDEX.
-- Nézzük meg, hogy milyen indexek kapcsolódnak a táblához!
-- Az adatszótárból le tudjuk kérdezni a felhasználói indexeket,
-- a USER_INDEXES nézet segítségével:
------------------------------------------------------------------------

SELECT *
FROM   user_indexes;

------------------------------------------------------------------------
-- Látható, hogy az index (és a megszorítás) neve véletlenszerû lett.
-- Fontos, hogy a kulcsokhoz kapcsolódó indexeket névvel tudjuk
-- azonosítani. Kesõbb, amikor majd elemezni kell egy SQL futtatását így
-- könnyeben fel fogjuk ismerni, hogy mihez tartozik a kulcsban használt
-- index, illetve erre a hintek írásakor is szükség lehet.
------------------------------------------------------------------------


-- / #03 / -------------------------------------------------------------
-- Hozzuk létre külön az elsõdleges kulcsot!
-- De elõbb eldobjuk a táblát.
-- PURGE: a tábla nem kerül be a Recycled Bin-be,
--        hanem visszanonhatatlanul töröljük.
------------------------------------------------------------------------

DROP TABLE person PURGE;

-- / #04 / -------------------------------------------------------------
-- Létrehozzuk a táblát elsõdleges kulcs nélkül.
-- Töröljük a korábbi definícióból a PRIMARY KEY kulcsszavakat,
-- majd hozzuk létre újra a táblát!
------------------------------------------------------------------------

CREATE TABLE person(
  person_id         NUMBER         NOT NULL
 ,first_name        VARCHAR2(40)   NOT NULL
 ,last_name         VARCHAR2(40)   NOT NULL
 ,birth_date        DATE
 ,birth_place_city  VARCHAR2(100)
 ,loc_country_code  VARCHAR2(2)
 ,loc_city          VARCHAR2(100)
 ,loc_address       VARCHAR2(100)
 ,email             VARCHAR2(100)
 ,tel               VARCHAR2(20)
 ,last_modified     DATE           DEFAULT SYSDATE NOT NULL
 ,created           DATE           DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;


-- / #05 / -------------------------------------------------------------
-- Adjuk hozzá az elsõdleges kulcsot.
------------------------------------------------------------------------

ALTER TABLE person
  ADD CONSTRAINT person_pk PRIMARY KEY (person_id);
  
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (10, 'László', 'Tóth', to_date('23-10-1956', 'dd-mm-yyyy'), 'Karakószörcsök', 'HU', 'Veszprém', 'Vasút u. 21.', 'laszlo.toth@tot.hu', '0678123456', to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (2, 'István', 'Kovács', to_date('19-12-1991', 'dd-mm-yyyy'), 'Budapest XXII.', 'HU', 'Pécs', 'Gül Baba tér 19.', 'istvan.kovacs91@ggmmaaiill.com', '06317654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (3, 'Nóra', 'Szabó-Eszterházy', to_date('10-01-2009', 'dd-mm-yyyy'), 'Pécs', 'EN', 'Brighton', null, 'norika2009@enternet.hu', '+4477987654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (PERSON_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (5, 'John', 'Smith', to_date('07-07-1967', 'dd-mm-yyyy'), 'Mencseszter sziti', 'HU', 'Mohács', 'Béke tér 1.', 'johny@smith.eu', '06307777777', to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'));


-- / #06 / -------------------------------------------------------------
-- Nézzük meg, hogy most milyen indexek kapcsolódnak a táblához
------------------------------------------------------------------------

SELECT *
FROM   user_indexes;

--
-- Az index neve a kulcs nevét követi. PERSON_PK lett.
--


-- / #07 / -------------------------------------------------------------
-- Itt sem volt megadva a PRIMARY KEY neve.
-- Nem szükséges újra létrehozni a táblát, eldohatjuk a megszorítást is.
-- Dobjuk a MEGSZORÍTÁSOKAT és újra hozzuk létre õket névvel.
--   1, DOG  táblában a DOG_ID-ra, DOG_PK néven.
--   2, VACC táblában a VACC_ID-ra, VACC_PK_néven.
------------------------------------------------------------------------

SELECT *
FROM   user_indexes;

-- 1,
ALTER TABLE dog
  DROP CONSTRAINT SYS_C007064; -- lekérdezésbõl

ALTER TABLE dog
  ADD CONSTRAINT dog_pk PRIMARY KEY (dog_id);

-- 2,
ALTER TABLE vacc
  DROP CONSTRAINT SYS_C007057; -- lekérdezésbõl

ALTER TABLE vacc
  ADD CONSTRAINT vacc_pk PRIMARY KEY (vacc_id);


-- / #08 / -------------------------------------------------------------
-- Definiáljuk a táblák közötti kapcsolatokat
--   1, VACC.DOG_ID -> DOG
--   2, VACC.DOCTOR_ID -> person
--   3, DOG.OWNER_ID -> person

-- 1, VACC.DOG_ID -> DOG
ALTER TABLE vacc
  ADD CONSTRAINT vacc_dog_fk FOREIGN KEY (dog_id) REFERENCES dog(dog_id);

-- 2, VACC.DOCTOR_ID -> person
ALTER TABLE vacc
  ADD CONSTRAINT vacc_doctor_fk FOREIGN KEY (doctor_id) REFERENCES person(person_id);

-- 3, DOG.OWNER_ID -> person
ALTER TABLE dog
  ADD CONSTRAINT dog_owner_fk FOREIGN KEY (owner_id) REFERENCES person(person_id);


-- / #09 / -------------------------------------------------------------
-- Hozzunk lére megoszorításokat a kutyák regisztrációs számára!
--   1, a csak egyedi lehet (UNIQE)
--   2, a hossza legalább 5 karakter (LENGTH függvény)
------------------------------------------------------------------------

-- 1,
ALTER TABLE dog
  ADD CONSTRAINT dog_reg_no_uk UNIQUE (registration_number);

-- 2,
ALTER TABLE dog
  ADD CONSTRAINT dog_reg_no_ck CHECK (LENGTH(registration_number) >= 5);


-- / #10 / -----------------------------------------------------------
-- Legyünk elnézõek a hosszt illetõen.
-- A megoszorítások inaktíválhatóak MODIFY CONSTRAINT paranccsal.
------------------------------------------------------------------------
ALTER TABLE dog
  MODIFY CONSTRAINT dog_reg_no_ck DISABLE;


------------------------------------------------------------------------
--
-- II. Bevezetünk egy szótártáblát az oltásokra
--
------------------------------------------------------------------------


-- / #12 / -------------------------------------------------------------
-- Átnevezzük az oltás típusát tároló oszlopot,
-- hogy szerepljen benne az "id".
------------------------------------------------------------------------

ALTER TABLE vacc
  RENAME COLUMN type_of_vacc TO vacc_type_id;

-- / #13 / -------------------------------------------------------------
-- Létrehozzuk az oltástípusok tábláját
------------------------------------------------------------------------
CREATE TABLE vacc_type
(
  vacc_type_id VARCHAR2(40) NOT NULL,
  vacc_name    VARCHAR2(200)
) TABLESPACE users;

COMMENT ON TABLE vacc_type IS 'Oltások típusai';
COMMENT ON COLUMN vacc_type.vacc_type_id IS 'Oltás típuskódja';
COMMENT ON COLUMN vacc_type.vacc_name IS 'Oltás megnevezése';

-- / #14 / -------------------------------------------------------------
-- Létrehozunk egy elsõdleges kulcsot
ALTER TABLE vacc_type
  ADD CONSTRAINT vacc_type_pk PRIMARY KEY (vacc_type_id);


-- / #15 / -------------------------------------------------------------
-- Majd az egyedi értékekkel feltöltjük a táblát a meglévõ oltásokból
INSERT INTO vacc_type
(
  vacc_type_id
)
SELECT DISTINCT vacc_type_id
FROM   vacc;

COMMIT;

SELECT * FROM vacc_type t ORDER BY t.vacc_type_id;


-- / #16 / -------------------------------------------------------------
-- Töltsük fel az oltástípusok mellé a nevüket.
-- Futtassuk le a 03_dog_manager_update.sql -t
-- COMMIT-ról ne feledkezzünk el!
------------------------------------------------------------------------

SELECT * FROM vacc_type t ORDER BY t.vacc_type_id;


-- / #17 / -------------------------------------------------------------
-- Az oltások táblján elhelyezük egy hivatkozást az oltások típusára
-- Ezt követõen nem lehet olyan oltást rögzíteni, amelynek korábban
-- nem rögzítettük volna a típusát.
ALTER TABLE vacc
  ADD CONSTRAINT vacc_type_fk FOREIGN KEY (vacc_type_id) REFERENCES vacc_type(vacc_type_id);


-- / #18 / -------------------------------------------------------------
-- Hozzunk létre egy nézetet, ami tartalmazza a kutya
--   * azonosítóját, nevét és regisztációs számát
--   * mikor volt oltva az adott kutya
--   * és mi az oltás neve
------------------------------------------------------------------------

CREATE VIEW vw_dog_vacc AS
SELECT d.dog_id
      ,d.dog_name
      ,d.registration_number      
      ,v.date_of_vacc
      ,vt.vacc_name
FROM   dog d
       JOIN vacc v
         ON d.dog_id = v.dog_id
       JOIN vacc_type vt
         ON v.vacc_type_id = vt.vacc_type_id
ORDER BY d.dog_id, v.date_of_vacc
;

SELECT * FROM vw_dog_vacc;



-- / #18 / -------------------------------------------------------------
-- Adjuk hozzá a nézethez az orvos nevét
-- Továbbá csak a 2015. utáni oltásokat listázzuk.
--
-- ORA-00955: name is already used by an existing object
-- Kell az "OR REPLACE", hogy le tudjuk cseréni a nézetet
--
CREATE OR REPLACE VIEW vw_dog_vacc AS
SELECT d.dog_id
      ,d.dog_name
      ,d.registration_number      
      ,v.date_of_vacc
      ,vt.vacc_name
      ,'Dr.' || p.first_name || ' ' || p.last_name AS doctor_name
FROM   dog d
       JOIN vacc v
         ON d.dog_id = v.dog_id
       JOIN vacc_type vt
         ON v.vacc_type_id = vt.vacc_type_id
       JOIN person p
         ON v.doctor_id = p.person_id
WHERE  v.date_of_vacc >= DATE '2016-01-01'
ORDER BY d.dog_id, v.date_of_vacc
;

-- / #19 / -------------------------------------------------------------
-- Hozzunk létre indexeket kereséshez a DOG táblában.
-- Indexelt mezők: dog_name, birth_date

CREATE INDEX dog_ix_01 ON dog(dog_name, birth_date);
CREATE INDEX dog_ix_02 ON dog(birth_date);
CREATE INDEX dog_ix_03 ON dog(dog_name);

-- A 3. indexre valójában nincs szükség, mert az Oracle képes az első
-- index "felvezető" mezőit használni.
-- Gyakorat képpen ezért dobjuk ezt az indexet:
DROP INDEX dog_ix_03;


