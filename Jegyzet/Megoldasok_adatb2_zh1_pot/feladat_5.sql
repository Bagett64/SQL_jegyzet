-- 5. feladat
-- Analitikus függvények használata: kategória összeg és sorszámozás csökkenő ár alapján
SELECT
    cim,
    kategoria,
    ar,
    SUM(ar) OVER (PARTITION BY kategoria) AS kategoria_ossz_ar,
    ROW_NUMBER() OVER (PARTITION BY kategoria ORDER BY ar DESC) AS sorszam_kategorian_belul
FROM konyv;
