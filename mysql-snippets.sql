CREATE DATABASE mytodo;
/* SHOW databases; */

USE mytodo;
/* SHOW tables; */

CREATE TABLE todos (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  description TEXT NOT NULL,
  completed BOOLEAN NOT NULL
);


/* DESCRIBE todos; */

/* delete a table */
DROP TABLE todos;


INSERT INTO todos (description, completed)
VALUES ('Go to the store', FALSE);

/* show all collumns from table */
SELECT * FROM todos;

/* show all collumns from table with unique id */
SELECT * FROM todos WHERE id = 1;

