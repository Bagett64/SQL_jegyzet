-- 1. feladat
CREATE TABLE konyv (
    id NUMBER,
    cim VARCHAR2(255) NOT NULL,
    kategoria VARCHAR2(100),
    ar NUMBER
);

CREATE TABLE kolcsonzes (
    id NUMBER,
    konyv_id NUMBER NOT NULL,
    olvaso_neve VARCHAR2(255) NOT NULL,
    kivetel_datuma DATE,
    lejarat_datuma DATE
);
