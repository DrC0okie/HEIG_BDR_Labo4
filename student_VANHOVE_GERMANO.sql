SET search_path = pagila;

--
-- Triggers
---------------------------

-- Exercice 01
-- Exercice 3.1

CREATE OR REPLACE FUNCTION majoration()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.amount = NEW.amount * 1.08;
    NEW.payment_date = now();
    RETURN NEW;
end;
$$
    LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER majoration_on_insert
    BEFORE INSERT
    ON payment
    FOR EACH ROW
EXECUTE FUNCTION majoration();

-- Vérification
INSERT INTO payment(payment_id, customer_id, staff_id, rental_id, amount, payment_date)
VALUES (8, 269, 2, 7, 100, '2017-01-24 21:40:19.996577 +00:00');

SELECT *
FROM payment
WHERE payment_id = 8;

-- END Exercice 01

-- Exercice 02
-- END Exercice 02

-- Exercice 03
-- END Exercice 03

--
-- Vues
---------------------------

-- Exercice 04
-- END Exercice 04

-- Exercice 05
-- END Exercice 05

-- Exercice 06
-- END Exercice 06

-- Exercice 07
-- END Exercice 07

-- Exercice 08
-- END Exercice 08

--
-- Procédures / Fonctions
---------------------------

-- Exercice 09
-- END Exercice 09

-- Exercice 10
-- END Exercice 10
