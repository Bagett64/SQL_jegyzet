----------------------------------
-- 2. Create tables             --
----------------------------------
--ALTER SESSION SET CURRENT_SCHEMA=dog_manager;

CREATE TABLE person(
       ID NUMBER PRIMARY KEY,
       first_name VARCHAR2(40) NOT NULL,
       last_name VARCHAR2(40) NOT NULL,
       birth_date DATE,
       birth_place_city VARCHAR2(100),
       loc_country_code VARCHAR2(2),
       loc_city VARCHAR2(100),
       loc_address VARCHAR2(100),
       email VARCHAR2(100),
       tel VARCHAR2(20),
       last_modified DATE DEFAULT SYSDATE NOT NULL,
       created DATE DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;

CREATE TABLE dog(
       ID NUMBER PRIMARY KEY,
       breed_code CHAR(3), 
       dog_name VARCHAR2(40) NOT NULL,
       father_id NUMBER,
       mother_id NUMBER,
       registration_number VARCHAR2(40),
       birth_date DATE NOT NULL, 
       birth_weight NUMBER(5,2),
       owner_id NUMBER,
       last_modified DATE DEFAULT SYSDATE NOT NULL,
       created DATE DEFAULT SYSDATE NOT NULL
) 
TABLESPACE users;

alter table dog
  add constraint dog_owner_fk FOREIGN key (owner_id) REFERENCES person(id);
alter table dog
  add constraint dog_mother_fk FOREIGN key (mother_id) REFERENCES dog(id);
alter table dog
  add constraint dog_father_fk FOREIGN key (father_id) REFERENCES dog(id);
  
