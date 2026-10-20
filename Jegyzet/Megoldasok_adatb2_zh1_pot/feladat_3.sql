-- 3. feladat
-- Adatok feltöltése egyetlen INSERT ALL utasítással
INSERT ALL
    -- Könyv adatok
    INTO konyv (id, cim, kategoria, ar) VALUES (1, 'Adatbázisok alapjai', 'Informatika', 5000)
    INTO konyv (id, cim, kategoria, ar) VALUES (2, 'A gyűrűk ura', 'Fantasy', 4500)
    INTO konyv (id, cim, kategoria, ar) VALUES (3, 'Programozás C nyelven', 'Informatika', 3000)
    INTO konyv (id, cim, kategoria, ar) VALUES (4, 'Történelem röviden', 'Történelem', 2500)
    
    -- Kölcsönzés adatok (figyelve, hogy az olvasó neve >= 10 karakter)
    INTO kolcsonzes (id, konyv_id, olvaso_neve, kivetel_datuma, lejarat_datuma) 
        VALUES (1, 1, 'Kovács János', TRUNC(SYSDATE), TRUNC(SYSDATE + 14))
    INTO kolcsonzes (id, konyv_id, olvaso_neve, kivetel_datuma, lejarat_datuma) 
        VALUES (2, 2, 'Nagy Béla olv', TRUNC(SYSDATE), TRUNC(SYSDATE + 30))
    INTO kolcsonzes (id, konyv_id, olvaso_neve, kivetel_datuma, lejarat_datuma) 
        VALUES (3, 1, 'Szabó István', TRUNC(SYSDATE), TRUNC(SYSDATE + 7))
SELECT * FROM dual;
----

SELECT * FROM  vacc;

insert ALL
	 into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
		  values (1, 3, 5, 'A01', to_date('20-01-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'))
	 into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
		  values (2, 3, 5, 'B01', to_date('20-08-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'))
	 into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
		  values (3, 7, 10, 'A01', to_date('11-01-2010', 'dd-mm-yyyy'), 'Budapest', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'))
	 into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
		  values (4, 11, 10, 'B01', to_date('09-09-2009', 'dd-mm-yyyy'), 'Veszprém', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'))
	 into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
		  values (5, 13, 10, 'C01', to_date('29-02-2012', 'dd-mm-yyyy'), 'Mohács', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'))
SELECT * FROM dual;

SELECT * FROM vacc;

