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
CREATE TABLE staff_creation_log
(
    username     varchar(16) NOT NULL,
    when_created timestamp NOT NULL
);

CREATE OR REPLACE FUNCTION staff_creation_log()
    RETURNS TRIGGER
    AS
$$
BEGIN
    INSERT INTO staff_creation_log VALUES(NEW.username, now());
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER staff_creation
    BEFORE INSERT
    ON staff
    FOR EACH ROW
    EXECUTE PROCEDURE staff_creation_log();

INSERT INTO staff (first_name, last_name, address_id, email, store_id, username, password)
            values
                ('Thomas',
                 'Germano',
                 50,
                 'thomas.germano@sekilastaff.com',
                 1,
                 'catwayne',
                 'wallah'
                );

SELECT username, when_created
FROM staff_creation_log
WHERE username = 'catwayne';

-- END Exercice 02

-- Exercice 03
-- END Exercice 03

--
-- Vues
---------------------------

-- Exercice 04
CREATE OR REPLACE VIEW staff_address
AS
SELECT phone, first_name, last_name, address, postal_code, city, district, country
    FROM staff
    INNER JOIN address a
        ON a.address_id = staff.address_id
    INNER JOIN city c
        ON c.city_id = a.city_id
    INNER JOIN country co
        ON c.country_id = co.country_id
;
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
