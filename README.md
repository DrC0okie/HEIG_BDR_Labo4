# HEIG_BDR_Labo4
### Exercice 1

```postgresql
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
```

#### Vérification

```postgresql
INSERT INTO payment(payment_id, customer_id, staff_id, rental_id, amount, payment_date)
VALUES (8, 269, 2, 7, 100, '2017-01-24 21:40:19.996577 +00:00');

SELECT *
FROM payment
WHERE payment_id = 8;
```

<<<<<<< Updated upstream
### Exercice 3.3

```sql
CREATE OR REPLACE FUNCTION update_mail()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.email = LOWER(CONCAT(NEW.first_name, '.', NEW.last_name, '@sakilastaff.com'));
    RETURN NEW;
END
$$
    LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_mail_on_update
    BEFORE UPDATE
    ON customer
    FOR EACH ROW
EXECUTE FUNCTION update_mail();

CREATE OR REPLACE TRIGGER update_mail_on_insert
    BEFORE INSERT
    ON customer
    FOR EACH ROW
EXECUTE FUNCTION update_mail();
```

#### Vérification

```sql
-- Vérification on insert
DELETE
FROM customer
WHERE customer_id = 600;
INSERT INTO customer(customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update)
VALUES (600, 2, 'Tim', 'VanHove', 'test@test.org', 605 , true,  '2017-02-14 00:00:00.000000 +00:00',
        '2017-02-15 09:57:20.000000 +00:00');
SELECT email, last_name, first_name
FROM customer
WHERE customer_id = 600;

-- Vérification on update
UPDATE customer
SET first_name = 'Thomas',    last_name  = 'Germano'
WHERE customer_id = 600;

SELECT email, last_name, first_name
FROM customer
WHERE customer_id = 600;
```



### Exercice 5

```sql
CREATE VIEW non_payments
AS
    SELECT first_name, last_name, email, title, EXTRACT(DAY FROM (now() - r.rental_date)) AS nb_days_late
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NULL
AND (r.rental_date + f.rental_duration * INTERVAL '1 day' < now());
```

=======
### Exercice 2

```postgresql
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

INSERT INTO staff (
                   first_name, 
                   last_name, 
                   address_id, 
                   email, 
                   store_id, 
                   username, 
                   password)

            values
                ('Thomas',
                 'Germano',
                 50,
                 'thomas.germano@sekilastaff.com',
                 1,
                 'catwayne',
                 'wallah'
                )
;
```
#### Vérification
```postgresql
SELECT username, when_created
FROM staff_creation_log
WHERE username = 'catwayne';
```

### Exercice 4

```postgresql
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
```
#### Vérification
```postgresql
SELECT * FROM staff_address;
```
##### Réponse
Oui, car la vue satisfait toues les conditions qui lui permet d'être modifiable, c'est-à-dire :

- La vue doit avoir exactement une entrée (une table ou une autre vue modifiable) dans la liste FROM.

- La définition de la vue ne doit pas contenir de clauses WITH, DISTINCT, GROUP  BY, HAVING, LIMIT ou OFFSET au niveau le plus haut.

- La définition de la vue ne doit pas contenir d’opérations sur des ensembles (UNION, INTERSECT ou EXCEPT) au niveau le plus haut.

- La liste de sélection de la vue ne doit pas contenir d’agrégats, de fonctions de  fenêtrage ou de fonctions renvoyant des ensembles de lignes.

### Exercice 6
>>>>>>> Stashed changes
