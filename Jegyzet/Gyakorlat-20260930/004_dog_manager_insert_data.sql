prompt Loading PERSON...
insert into PERSON (ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (10, 'László', 'Tóth', to_date('23-10-1956', 'dd-mm-yyyy'), 'Karakószörcsök', 'HU', 'Veszprém', 'Vasút u. 21.', 'laszlo.toth@tot.hu', '0678123456', to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:03:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (2, 'István', 'Kovács', to_date('19-12-1991', 'dd-mm-yyyy'), 'Budapest XXII.', 'HU', 'Pécs', 'Gül Baba tér 19.', 'istvan.kovacs91@ggmmaaiill.com', '06317654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (3, 'Nóra', 'Szabó-Eszterházy', to_date('10-01-2009', 'dd-mm-yyyy'), 'Pécs', 'EN', 'Brighton', null, 'norika2009@enternet.hu', '+4477987654321', to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:09:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into PERSON (ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, BIRTH_PLACE_CITY, LOC_COUNTRY_CODE, LOC_CITY, LOC_ADDRESS, EMAIL, TEL, LAST_MODIFIED, CREATED)
values (5, 'John', 'Smith', to_date('07-07-1967', 'dd-mm-yyyy'), 'Mencseszter sziti', 'HU', 'Mohács', 'Béke tér 1.', 'johny@smith.eu', '06307777777', to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:11:39', 'dd-mm-yyyy hh24:mi:ss'));
prompt Loading DOG...
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (3, 'PUL', 'Kócos', null, 3, 'tehgb255gre5', to_date('10-10-2010', 'dd-mm-yyyy'), 1, 2, to_date('21-09-2016 15:13:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:13:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (5, 'PUL', 'Bleky', null, 3, 'fdfvksf425kn543', to_date('25-01-2015', 'dd-mm-yyyy'), .99, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (7, 'PUL', 'Jimmy', null, 3, 'fdfvksf425kn544', to_date('25-01-2015', 'dd-mm-yyyy'), 1.03, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (9, 'PUL', 'Jane', null, 3, 'fdfvksf425kn545', to_date('25-01-2015', 'dd-mm-yyyy'), 1.11, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (11, 'GRT', 'Harap', null, 11, 'asd1234', to_date('12-01-2012', 'dd-mm-yyyy'), null, 10, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (13, 'GRT', 'Frici', null, 11, 'z123', to_date('20-02-2161', 'dd-mm-yyyy'), null, 3, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (15, 'GRT', 'Poci', null, 11, 'z124', to_date('20-02-2161', 'dd-mm-yyyy'), null, 3, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into DOG (ID, BREED_CODE, DOG_NAME, FATHER_ID, MOTHER_ID, REGISTRATION_NUMBER, BIRTH_DATE, BIRTH_WEIGHT, OWNER_ID, LAST_MODIFIED, CREATED)
values (17, 'GRT', 'Pici', null, 11, 'z125', to_date('20-02-2161', 'dd-mm-yyyy'), null, 2, to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-09-2016 15:19:36', 'dd-mm-yyyy hh24:mi:ss'));
prompt Loading VACC...
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (1, 3, 5, 'A01', to_date('20-01-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (2, 3, 5, 'B01', to_date('20-08-2016', 'dd-mm-yyyy'), 'Pécs', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (3, 7, 10, 'A01', to_date('11-01-2010', 'dd-mm-yyyy'), 'Budapest', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (4, 11, 10, 'B01', to_date('09-09-2009', 'dd-mm-yyyy'), 'Veszprém', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into VACC (ID, DOG_ID, DOCTOR_ID, TYPE_OF_VACC, DATE_OF_VACC, LOCATION_OF_VACC, CREATED)
values (5, 13, 10, 'C01', to_date('29-02-2012', 'dd-mm-yyyy'), 'Mohács', to_date('21-09-2016 15:22:49', 'dd-mm-yyyy hh24:mi:ss'));

commit;

prompt Done.
