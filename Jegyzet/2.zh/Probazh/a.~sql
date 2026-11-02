CREATE OR REPLACE TYPE ty_termek_type AS OBJECT
(
  termekazonosito NUMBER,
  megnevezes      VARCHAR2(50),

  CONSTRUCTOR FUNCTION ty_termek_type RETURN SELF AS RESULT
);
/ 
CREATE OR REPLACE TYPE BODY ty_termek_type IS
CONSTRUCTOR FUNCTION ty_termek_type RETURN SELF AS RESULT is
BEGIN 
  self.termekazonosito := NULL; 
self.megnevezes := NULL;
 RETURN;
  END; 
  END;
