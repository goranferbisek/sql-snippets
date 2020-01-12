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