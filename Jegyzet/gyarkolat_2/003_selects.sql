SELECT * FROM dog;
SELECT * FROM person;

--RIGHT JOIN
SELECT * FROM dog d RIGHT JOIN person p ON d.owner_id = p.id;

--JOIN
SELECT * FROM person p JOIN dog d ON p.id = d.owner_id;

--CROSS JOIN
SELECT * FROM person p CROSS JOIN dog d;

--FULL JOIN
SELECT * FROM person p FULL JOIN dog d ON p.id = d.owner_id;

--Legnagyobb 'Z%' regisztrációsszámú kutya.
SELECT rownum
      ,t.*
  FROM (SELECT ROWID
              ,d.*
          FROM dog d
         WHERE upper(d.registration_number) LIKE 'Z%'
         ORDER BY d.registration_number DESC) t
 WHERE rownum = 1;
 
--Két évnél idősebb kutyák.
SELECT d.dog_name || ' (' || d.registration_number || ')'
      ,d.birth_date
  FROM dog d
 WHERE 1 = 1
   AND d.birth_date < add_months(SYSDATE, -24);


--'c' karaktert tartalmazó kutyák gazdái.
SELECT p.first_name
      ,p.last_name
      ,COUNT(*) AS dog_cnt
      ,listagg(d.dog_name, '; ') within GROUP(ORDER BY d.dog_name) AS dog_names
      ,SUM(CASE
             WHEN d.dog_name LIKE '%c%' THEN
              1
             ELSE
              0
           END)
  FROM person p
  JOIN dog d
    ON p.id = d.owner_id
 GROUP BY p.first_name
         ,p.last_name
HAVING SUM(CASE
  WHEN d.dog_name LIKE '%c%' THEN
   1
  ELSE
   0
END) > 0;
