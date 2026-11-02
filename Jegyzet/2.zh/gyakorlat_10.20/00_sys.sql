PROMPT Creating user DOG_MANAGER...

----------------------------------
-- 1. Create user, add grants   --
----------------------------------
declare
  cursor cur is
    select 'alter system kill session ''' || sid || ',' || serial# || '''' as command
      from v$session
     where username = 'DOG_MANAGER';
begin
  for c in cur loop
    EXECUTE IMMEDIATE c.command;
  end loop;
end;
/

DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM dba_users t WHERE t.username='DOG_MANAGER';
  IF v_count = 1 THEN 
    EXECUTE IMMEDIATE 'DROP USER dog_manager CASCADE';
  END IF;
END;
/
CREATE USER dog_manager 
  IDENTIFIED BY "12345678" 
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
;

GRANT CREATE SESSION TO dog_manager;
GRANT CREATE TABLE TO dog_manager;
GRANT CREATE VIEW TO dog_manager;
GRANT CREATE SEQUENCE TO dog_manager;
GRANT CREATE PROCEDURE TO dog_manager;

ALTER SESSION SET CURRENT_SCHEMA=dog_manager;

PROMPT Done.

PROMPT Creating table person...

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
 ,last_modfiied     DATE           DEFAULT SYSDATE NOT NULL
 ,created           DATE           DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;


ALTER TABLE person
  ADD CONSTRAINT person_pk PRIMARY KEY (person_id);

PROMPT Done.

PROMPT Creating tables...

CREATE TABLE dog(
  dog_id                          NUMBER         NOT NULL
 ,breed_code                      CHAR(3)
 ,dog_name                        VARCHAR2(40)   NOT NULL
 ,father_id                       NUMBER
 ,mother_id                       NUMBER
 ,registration_number             VARCHAR2(40)
 ,birth_date                      DATE NOT NULL 
 ,birth_weight                    NUMBER(5,2)
 ,owner_id                        NUMBER
 ,last_modfiied                   DATE           DEFAULT SYSDATE NOT NULL
 ,created                         DATE           DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;

ALTER TABLE dog
  ADD CONSTRAINT dog_pk PRIMARY KEY (dog_id);

CREATE TABLE vacc(
  vacc_id                         NUMBER         NOT NULL
 ,dog_id                          NUMBER         NOT NULL
 ,doctor_id                       NUMBER         NOT NULL
 ,vacc_type_id                    VARCHAR2(40)   NOT NULL
 ,date_of_vacc                    DATE           DEFAULT SYSDATE NOT NULL
 ,location_of_vacc                VARCHAR2(100)
 ,created                         DATE           DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;

ALTER TABLE vacc
  ADD CONSTRAINT vacc_pk PRIMARY KEY (vacc_id);
  
-- 1, VACC.DOG_ID -> DOG
ALTER TABLE vacc
  ADD CONSTRAINT vacc_dog_fk FOREIGN KEY (dog_id) REFERENCES dog(dog_id);

-- 2, VACC.DOCTOR_ID -> person
ALTER TABLE vacc
  ADD CONSTRAINT vacc_doctor_fk FOREIGN KEY (doctor_id) REFERENCES person(person_id);

-- 3, DOG.OWNER_ID -> person
ALTER TABLE dog
  ADD CONSTRAINT dog_owner_fk FOREIGN KEY (owner_id) REFERENCES person(person_id);
  
ALTER TABLE dog
  ADD CONSTRAINT dog_reg_no_uk UNIQUE (registration_number);

-- 2,
ALTER TABLE dog
  ADD CONSTRAINT dog_reg_no_ck CHECK (LENGTH(registration_number) >= 5);
  
CREATE TABLE vacc_type
(
  vacc_type_id VARCHAR2(40) NOT NULL,
  vacc_name    VARCHAR2(200)
);

COMMENT ON TABLE vacc_type IS 'Oltások típusai';
COMMENT ON COLUMN vacc_type.vacc_type_id IS 'Oltás típuskódja';
COMMENT ON COLUMN vacc_type.vacc_name IS 'Oltás megnevezése';

ALTER TABLE vacc_type
  ADD CONSTRAINT vacc_type_pk PRIMARY KEY (vacc_type_id);
  
  
ALTER TABLE vacc
  ADD CONSTRAINT vacc_type_fk FOREIGN KEY (vacc_type_id) REFERENCES vacc_type(vacc_type_id);


PROMPT Done.

PROMPT Loading tables...

PROMPT Loading tables...

INSERT INTO vacc_type
(
  vacc_type_id
)
select value
  from ((select 'A01' v1, 'B01' v2, 'C01' v3, 'D01' v4 from dual)
        unpivot(value for value_type in (v1, v2, v3, v4)));

UPDATE vacc_type t
SET    t.vacc_name = 'Veszettség elleni oltás'
WHERE  t.vacc_type_id = 'A01';

UPDATE vacc_type t
SET    t.vacc_name = 'Lyme-kór elleni oltás'
WHERE  t.vacc_type_id = 'B01';

UPDATE vacc_type t
SET    t.vacc_name = 'Kombinált oltás'
WHERE  t.vacc_type_id = 'C01';

UPDATE vacc_type t
SET    t.vacc_name = 'Parovírus elleni oltás'
WHERE  t.vacc_type_id = 'D01';

prompt Loading person...
insert into person (person_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODFIIED, CREATED)
values (10, 'László', 'Tóth', to_date('23-10-1956', 'dd-mm-yyyy'), 'Karakószörcsök', 'HU', 'Veszprém', 'Vasút u. 21.', 'laszlo.toth@tot.hu', '0678123456', to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into person (person_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODFIIED, CREATED)
values (2, 'István', 'Kovács', to_date('19-12-1991', 'dd-mm-yyyy'), 'Budapest XXII.', 'HU', 'Pécs', 'Gül Baba tér 19.', 'istvan.kovacs91@ggmmaaiill.com', '06317654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into person (person_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODFIIED, CREATED)
values (3, 'Nóra', 'Szabó-Eszterházy', to_date('10-01-2009', 'dd-mm-yyyy'), 'Pécs', 'EN', 'Brighton', null, 'norika2009@enternet.hu', '+4477987654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into person (person_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODFIIED, CREATED)
values (5, 'John', 'Smith', to_date('07-07-1967', 'dd-mm-yyyy'), 'Mencseszter sziti', 'HU', 'Mohács', 'Béke tér 1.', 'johny@smith.eu', '06307777777', to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'));

prompt Loading DOG...
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODFIIED, CREATED)
values (3, 'PUL', 'Kócos', null, 3, 'tehgb255gre5543', to_date('10-10-2010', 'dd-mm-yyyy'), 1, 2, to_date('21-09-2016 15:13:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:13:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODFIIED, CREATED)
values (5, 'PUL', 'Bleky', null, 3, 'fdfvksf425kn543', to_date('25-01-2015', 'dd-mm-yyyy'), .99, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODFIIED, CREATED)
values (7, 'PUL', 'Jimmy', null, 3, 'fdfvksf425kn544', to_date('25-01-2015', 'dd-mm-yyyy'), 1.03, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODFIIED, CREATED)
values (9, 'PUL', 'Jane', null, 3, 'fdfvksf425kn545', to_date('25-01-2015', 'dd-mm-yyyy'), 1.11, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODFIIED, CREATED)
values (11, 'GRT', 'Harap', null, 11, 'asd1234ksf425', to_date('12-01-2012', 'dd-mm-yyyy'), 2.5, 10, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODFIIED, CREATED)
values (13, 'GRT', 'Frici', null, 11, 'z123sksf425x', to_date('20-02-2161', 'dd-mm-yyyy'), 3.2, 3, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODFIIED, CREATED)
values (14, 'GRT', 'Frakk', null, 11, 'ff123sksf425x', to_date('20-02-2161', 'dd-mm-yyyy'), 2.1, 3, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODFIIED, CREATED)
values (15, 'GRT', 'Poci', null, 11, 'dasff123sksf425x', to_date('20-02-2161', 'dd-mm-yyyy'), 1.8, 3, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODFIIED, CREATED)
values (17, 'GRT', 'Pici', null, 11, 'cyxcdasff123sksf425x', to_date('20-02-2161', 'dd-mm-yyyy'), null, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (DOG_ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODFIIED, CREATED)
values (18, 'PUL', 'Janet', null, 3, 'fdfvksf425kn54ddwa5', to_date('25-01-2015', 'dd-mm-yyyy'), 1.11, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));


prompt Loading VACC...
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, VACC_TYPE_ID, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (1, 3, 5, 'A01', to_date('20-01-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, VACC_TYPE_ID, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (2, 3, 5, 'B01', to_date('20-08-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, VACC_TYPE_ID, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (3, 7, 10, 'A01', to_date('11-01-2010', 'dd-mm-yyyy'), 'Budapest', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, VACC_TYPE_ID, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (4, 11, 10, 'B01', to_date('09-09-2009', 'dd-mm-yyyy'), 'Veszprém', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, VACC_TYPE_ID, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (5, 13, 10, 'C01', to_date('29-02-2012', 'dd-mm-yyyy'), 'Mohács', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (VACC_ID, DOG_ID, DOCTOR_ID, VACC_TYPE_ID, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (6, 14, 10, 'C01', to_date('29-02-2012', 'dd-mm-yyyy'), 'Mohács', to_date('21-09-2016 15:28:14', 'dd-mm-yyyy hh24:mi:ss'));

prompt Done.





CREATE INDEX dog_ix_01 ON dog(dog_name, birth_date);
CREATE INDEX dog_ix_02 ON dog(birth_date);
CREATE INDEX dog_ix_03 ON dog(dog_name);


PROMPT Done.

create or replace function get_prev_date(p_days number default 1)
  return timestamp is
begin
  return trunc(sysdate - p_days);
end;
/


select get_prev_date from dual; 
select get_prev_date(2) from dual;

create or replace procedure add_vacc_type(p_vacc_type_id in varchar2, p_vacc_name in varchar2) is
begin
insert into vacc_type(vacc_type_id, vacc_name) values(p_vacc_type_id, p_vacc_name);
end;
/

declare 
    l_new_vacc_type_id varchar2(30) :=  'A02';
    l_new_vacc_name varchar2(200) := 'Kettes típusú veszettség';
begin
  add_vacc_type(p_vacc_type_id => l_new_vacc_type_id,
                p_vacc_name => l_new_vacc_name);
end;
/

create table dog_owner_hist(
       dog_id number not null,
       person_id number not null,
       tr_time timestamp not null
);

PROMPT Done dog_owner_hist.

create or replace procedure dog_change_owner(p_dog_id        in number,
                                             p_new_person_id in number) is
  l_act_owner number;
begin
  select d.owner_id into l_act_owner from dog d where d.dog_id = p_dog_id;
  update dog d set d.owner_id = p_new_person_id where d.dog_id = p_dog_id;
  insert into dog_owner_hist
    (dog_id, person_id, tr_time)
  values
    (p_dog_id, l_act_owner, sysdate);
end;
/

CREATE OR REPLACE PACKAGE my_package AS
  gv_increment NUMBER(12,0) := 1;
  FUNCTION next_number RETURN NUMBER;
END my_package;
/

CREATE OR REPLACE PACKAGE BODY my_package AS
  gv_number NUMBER(12,0); 
  FUNCTION next_number RETURN NUMBER IS
  BEGIN
    gv_number := gv_number + gv_increment;
    RETURN gv_number;
  END;
BEGIN 
  gv_number := 0; 
END my_package;
/

begin
DBMS_SESSION.RESET_PACKAGE;  
end;
/

SELECT my_package.next_number FROM dual;

SELECT my_package.next_number FROM dual;


DECLARE
  v_outer VARCHAR2(30);
  PROCEDURE show(p_arg1 IN VARCHAR2) IS
  BEGIN
     dbms_output.put_line(v_outer || p_arg1);
  END;
BEGIN
  v_outer := 'Hello';
  show('World');
END;
/

create or replace function get_prev_date_str(p_days in number default 1) return varchar2 is
l_date date;
begin
   l_date := get_prev_date(p_days => p_days);
   return TO_CHAR(l_date, 'YYYY.MM.DD');
end;
/

declare 
begin 
   dbms_output.put_line(get_prev_date_str(1));
   dbms_output.put_line(get_prev_date_str(2));
   dbms_output.put_line(get_prev_date_str(3));
end;
/

create or replace procedure calc_square(p_side     in number,
                                        p_perimeter out number,
                                        p_area     out number) is
begin
  p_perimeter := 4 * p_side;
  p_area := p_side * p_side;
end;
/

declare
  l_perimeter number;
  l_area number;
  l_side number := 5;
begin
  calc_square(p_side => l_side,
              p_perimeter => l_perimeter,
              p_area => l_area);
   dbms_output.put_line(l_perimeter);
   dbms_output.put_line(l_area);
end;
/
