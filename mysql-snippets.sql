CREATE DATABASE mytodo;
/* SHOW databases; */

USE mytodo;
/* SHOW tables; */

CREATE TABLE todos (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  description TEXT NOT NULL,
  completed BOOLEAN NOT NULL
);


/* ad a foreign key constraint to an existing table */
ALTER TABLE comments
ADD FOREIGN KEY (post_id) REFERENCES posts(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

/* DESCRIBE todos; */

/* delete a table */
DROP TABLE todos;


INSERT INTO todos (description, completed)
VALUES ('Go to the store', FALSE);

/* show all collumns from table */
SELECT * FROM todos;

/* show all collumns from table with unique id */
SELECT * FROM todos WHERE id = 1;

/* delete a line with specific id */
DELETE FROM todos WHERE id = 1;

/*************** JOINS ***************/
/* INNER JOIN - default in MySQL - keyword INNER not necessary */
/* match on both tables */
SELECT *
FROM store
JOIN address
ON store.address_id = address.address_id;

SELECT *
FROM store
INNER JOIN address
ON store.address_id = address.address_id;

/* LEFT JOIN and LEFT OUTER JOIN (same IN MySQL)
  - get all records from store table even if there is no match */

SELECT *
FROM store
LEFT JOIN address
ON store.address_id = address.address_id;

/* RIGHT JOIN or RIGHT OUTER JOIN
 - get all records from address table even if there is no match */
SELECT *
FROM store
RIGHT JOIN address
ON store.address_id = address.address_id;

/* AGGREGATE FUNCTIONS */
SELECT
	customer.customer_id,
  customer.first_name,
  customer.last_name,
  COUNT(rental.rental_id) AS rentals_checked_out
  /* column alias - AS not mandatory */
FROM customer
LEFT JOIN rental
ON  rental.customer_id = customer.customer_id
GROUP BY customer.customer_id; /* group by an unique id */

/* SUBQUERY - subqueries come with a cost - cca 80ms */
SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
 	COUNT(rental.rental_id) AS rentals_checked_out,
	address.address AS store_address
FROM customer AS c /*used alias for customer */
LEFT JOIN rental
ON  rental.customer_id = c.customer_id
LEFT JOIN address
ON address.address_id = (
	SELECT address_id FROM store WHERE store.store_id = c.store_id
) /* store.address_id */
GROUP BY c.customer_id, address.address;

/* upper query optimised with joins - cca 47ms*/
SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
 	COUNT(rental.rental_id) AS rentals_checked_out,
	address.address AS store_address
FROM customer AS c
LEFT JOIN rental
ON  rental.customer_id = c.customer_id
LEFT JOIN store
ON store.store_id = c.store_id
LEFT JOIN address
ON address.address_id = store.address_id
GROUP BY c.customer_id, address.address;

/* popular rentals - most profitable */
SELECT
	title,
    SUM(amount) AS sales,
    COUNT(*) rentals
FROM rental
JOIN payment
ON payment.rental_id = rental.rental_id
JOIN inventory
ON inventory.inventory_id = rental.inventory_id
JOIN film
ON film.film_id = inventory.film_id
GROUP BY title
HAVING sales > 200 /* HAVING is for aggregated columns */
ORDER BY sales DESC;

/* RELATIONSHIPS */
/* one to one relationship
   returns one row - one user has one profile
   profile belongs to one user
*/
SELECT * FROM users
JOIN profiles
ON profiles.user_id = users.id;


/* one to many relationship
   returns multiple rows
   user has many blog posts, but a post has only one user
*/
SELECT
	posts.id, title, body
FROM posts
JOIN users
ON users.id = posts.user_id
WHERE user_id = 1;


/* many to many relationship
   a post can have many tags
   a tag can belong to many posts
   post_tag is a linking table
*/
SELECT * FROM posts
LEFT JOIN post_tag
ON post_tag.post_id = posts.id
WHERE post_tag.post_id = 200;

/* prevent duplication  - post_id and tag_ud combination must be unique
   in the linking table post_tag
*/
CREATE TABLE post_tag (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  post_id INT UNSIGNED NOT NULL,
  tag_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (post_id, tag_id) /* UNIQUE KEYWORD */
);

/* INDEX */
/* EXPLAIN keyword in front of a query is useful for finding index type
   and how much row does it have to search to find a result
*/
EXPLAIN SELECT * FROM rental;
