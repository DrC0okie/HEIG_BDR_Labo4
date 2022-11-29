# HEIG_BDR_Labo4

### Exercice3.1

```sql
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

```sql
INSERT INTO payment(payment_id, customer_id, staff_id, rental_id, amount, payment_date)
VALUES (8, 269, 2, 7, 100, '2017-01-24 21:40:19.996577 +00:00');

SELECT *
FROM payment
WHERE payment_id = 8;
```

