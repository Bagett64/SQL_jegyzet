-- 4. feladat
-- 20%-os áremelés azoknál a könyveknél, amelyeket legalább egyszer kikölcsönöztek
UPDATE konyv
SET ar = ar * 1.2
WHERE id IN (SELECT DISTINCT konyv_id FROM kolcsonzes);
