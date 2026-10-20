-- 2. feladat
-- Elsődleges kulcsok
ALTER TABLE konyv ADD CONSTRAINT pk_konyv_id PRIMARY KEY (id);
ALTER TABLE kolcsonzes ADD CONSTRAINT pk_kolcsonzes_id PRIMARY KEY (id);

-- Külső kulcs
ALTER TABLE kolcsonzes ADD CONSTRAINT fk_kolcsonzes_konyv_id FOREIGN KEY (konyv_id) REFERENCES konyv(id);

-- Egyedi megszorítás a címre
ALTER TABLE konyv ADD CONSTRAINT uq_konyv_cim UNIQUE (cim);

-- Ellenőrző megszorítás: az olvasó neve legalább 10 karakter hosszú
ALTER TABLE kolcsonzes ADD CONSTRAINT chk_kolcsonzes_olvaso_neve CHECK (LENGTH(olvaso_neve) >= 10);
