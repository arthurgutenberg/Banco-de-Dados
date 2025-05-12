CREATE DATABASE exec1;

USE exec1;

CREATE TABLE autor(
	id_autor INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (25),
    titulo VARCHAR (25),
    ano_publicacao INTEGER

);

INSERT INTO autor
VALUES(null, "Rifujin na Magonote", "Mushoku Tensei", 2014);

INSERT INTO autor
VALUES(null, "Reki Kawahara", "Sword Art Online", 2009);

INSERT INTO autor(titulo, ano_publicacao)
VALUES("SAO: Project Alicization", 2017);

SELECT * FROM autor;

SELECT * FROM autor WHERE id_autor = 1;