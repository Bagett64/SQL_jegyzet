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
