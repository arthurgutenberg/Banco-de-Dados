CREATE DATABASE cadastro;

USE cadastro;

CREATE TABLE pessoa(
	id_pessoa INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cpf VARCHAR(11),
    dtn DATE,
    email VARCHAR(50)
);

CREATE TABLE endereco(
	id_endereco INTEGER PRIMARY KEY AUTO_INCREMENT,
	fk_id_pessoa INTEGER,
	cep VARCHAR(9),
	logradouro VARCHAR(50),
	numero_casa VARCHAR(5),
	FOREIGN KEY (fk_id_pessoa) REFERENCES pessoa(id_pessoa)
);

INSERT INTO Pessoa VALUES
(null, "Luan", "12345678910", "1990-05-16", "teste@gmail.com");

INSERT INTO endereco VALUES
(null, 1, "73900-0000", "rua_inventada", "d27"); 

SELECT * FROM pessoa;