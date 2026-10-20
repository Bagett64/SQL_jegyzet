-- 6. feladat
-- Left join a 0 kölcsönzés megjelenítéséhez, szűrés 'a' betűre, és maximum 2 kölcsönzés
SELECT
    k.cim,
    k.kategoria,
    COUNT(ko.id) AS kolcsonzesek_szama
FROM konyv k
LEFT JOIN kolcsonzes ko ON k.id = ko.konyv_id
WHERE LOWER(k.cim) LIKE '%a%'
GROUP BY k.cim, k.kategoria
HAVING COUNT(ko.id) < 3;
