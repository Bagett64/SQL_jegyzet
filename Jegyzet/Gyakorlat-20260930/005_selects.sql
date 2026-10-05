SELECT * FROM DUAL;

SELECT 1 + 5 FROM dual;

SELECT SYSDATE
      ,trunc(SYSDATE)
      ,to_char(SYSDATE - 2, 'YYYY-MM-DD')
  FROM dual;
