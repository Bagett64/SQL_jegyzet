CREATE OR REPLACE FUNCTION get_prev_date(p_n NUMBER DEFAULT 1) RETURN DATE IS
BEGIN
  RETURN SYSDATE - p_n;
END;
/
CREATE OR REPLACE FUNCTION get_dog_name_by_owner_id(p_person_id NUMBER)
  RETURN VARCHAR2 IS
  l_count    NUMBER;
  l_dog_names VARCHAR2(2000);
BEGIN
  SELECT COUNT(*) INTO l_count FROM dog d WHERE d.owner_id = p_person_id;

  IF l_count = 0
  THEN
    RETURN 'Dog not found!';
  END IF;

  IF l_count > 1
  THEN
    SELECT listagg(d.dog_name, '; ') within GROUP(ORDER BY d.dog_name)
      INTO l_dog_names
      FROM dog d
     WHERE d.owner_id = p_person_id;
  
    RETURN l_dog_names;
  END IF;

  SELECT d.dog_name
    INTO l_dog_names
    FROM dog d
   WHERE d.owner_id = p_person_id;

  RETURN l_dog_names;

END;
/
CREATE OR REPLACE FUNCTION get_dog_name_by_owner_id2(p_person_id NUMBER)
  RETURN VARCHAR2 IS
  l_dog_name VARCHAR2(40);
BEGIN
  SELECT d.dog_name
    INTO l_dog_name
    FROM dog d
   WHERE d.owner_id = p_person_id;

  RETURN l_dog_name;

EXCEPTION
  WHEN no_data_found THEN
    RETURN 'Dog not found!';
	
  WHEN too_many_rows THEN
    RETURN 'Too many dogs!';
  
END;
/
CREATE OR REPLACE FUNCTION check_vacc_type_by_dog_id(p_dog_id NUMBER)
  RETURN NUMBER IS
  l_vacc_type vacc.vacc_type_id%TYPE;
BEGIN
  SELECT v.vacc_type_id
    INTO l_vacc_type
    FROM dog d
    JOIN vacc v
      ON d.dog_id = v.dog_id
   WHERE d.dog_id = p_dog_id;

  IF l_vacc_type = 'A01'
     OR l_vacc_type = 'B01'
  THEN
    RETURN 1;
  ELSE
    RETURN 0;
  END IF;

EXCEPTION
  WHEN no_data_found THEN
    RETURN - 1;
	
  WHEN too_many_rows THEN
    RETURN - 2;
  
END;
/
