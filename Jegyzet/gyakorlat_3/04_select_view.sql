--------------------------------------------------------------------------------
-- PARTITION BY
-- Ugyanaz a logika mint a GROUP BY (közös jellemző alapján csoportosít) – de egy hatalmas különbséggel: nem olvasztja össze a sorokat egyetlen eredménysorrá!
-- Az over kulcsszó megmondja az adatbázisnak, hogy nem egy egyszerű számolást kell végezni, hanem egy analitikus (ablakozó) műveletet.
--------------------------------------------------------------------------------

CREATE VIEW vw_dogs_with_owners AS
 SELECT p.first_name
      ,p.last_name
      ,d.dog_name
      ,COUNT(*) over(PARTITION BY p.person_id) as count
      ,row_number() over(PARTITION BY p.person_id ORDER BY d.dog_name DESC) as rownumber
  FROM person p
  JOIN dog d
    ON p.person_id = d.owner_id;
