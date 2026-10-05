UPDATE vacc_type t
SET    t.vacc_name = 'Veszettség elleni oltás'
WHERE  t.vacc_type_id = 'A01';

UPDATE vacc_type t
SET    t.vacc_name = 'Lyme-kór elleni oltás'
WHERE  t.vacc_type_id = 'B01';

UPDATE vacc_type t
SET    t.vacc_name = 'Kombinált oltás'
WHERE  t.vacc_type_id = 'C01';

UPDATE vacc_type t
SET    t.vacc_name = 'Parvovírus elleni oltás'
WHERE  t.vacc_type_id = 'D01';

SELECT * FROM vacc_type;
