CREATE TABLE vacc(
       id               NUMBER PRIMARY KEY,
       dog_id           NUMBER NOT NULL,
       doctor_id        NUMBER NOT NULL,
       type_of_vacc     VARCHAR2(40) NOT NULL,
       date_of_vacc     DATE DEFAULT SYSDATE,
       location_of_vacc VARCHAR2(100),
       created          DATE DEFAULT SYSDATE NOT NULL
);

COMMENT ON TABLE vacc IS 'Oltások';
COMMENT ON COLUMN vacc.dog_id IS 'Kutya azonosítója';

ALTER TABLE vacc ADD CONSTRAINT vacc1_fk
    FOREIGN KEY (dog_id) REFERENCES dog(id);
ALTER TABLE vacc ADD CONSTRAINT vacc2_fk
    FOREIGN KEY (doctor_id) REFERENCES person(id);
