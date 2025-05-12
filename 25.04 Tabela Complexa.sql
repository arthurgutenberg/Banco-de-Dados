CREATE DATABASE cadastro;

USE cadastro;

CREATE TABLE pessoa(
	id_pessoa INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
	telefone VARCHAR(16),
    cpf VARCHAR(15),
    email VARCHAR(50)
);

CREATE TABLE endereco(
	id_endereco INTEGER PRIMARY KEY AUTO_INCREMENT,
    CEP VARCHAR(14),
    legradouro VARCHAR(50),
    cidade VARCHAR(50),
    estado CHAR(2),
    fk_id_pessoa INTEGER,
	FOREIGN KEY (fk_id_pessoa) REFERENCES pessoa(id_pessoa)
);

CREATE TABLE telefone(
	id_telefone INTEGER PRIMARY KEY AUTO_INCREMENT,
    telefone VARCHAR(9),
    ddd CHAR(3),
    fk_id_pessoa INTEGER,
    FOREIGN KEY (fk_id_pessoa) REFERENCES pessoa(id_pessoa)
);

INSERT INTO pessoa (nome, telefone, cpf, email) VALUES
('Ana Clara', '21999998888', '123.456.789-00', 'ana@email.com'),
('Bruno Silva', NULL, '987.654.321-00', 'bruno@email.com'),
('Carlos Oliveira', '31988887777', '456.123.789-00', NULL);

INSERT INTO endereco (CEP, legradouro, cidade, estado) VALUES
('21000-000', 'Rua das Flores', 'Rio de Janeiro', 'RJ'),
(NULL, 'Av. Paulista', 'São Paulo', 'SP'),
('30123-456', NULL, 'Belo Horizonte', 'MG');

INSERT INTO telefone (telefone, ddd) VALUES
('99998888', '021'),
('98887777', '011'),
('97776666', NULL);

SELECT *FROM pessoa;
SELECT * FROM endereco;
SELECT * FROM telefone;

SELECT * FROM  pessoa WHERE nome LIKE "Ana%";

SELECT * FROM  pessoa WHERE nome LIKE "A%"; -- comeca com a letra "A"
SELECT * FROM  pessoa WHERE nome LIKE "%RA"; -- termina com "RA"
SELECT * FROM  pessoa WHERE nome LIKE "%SILVA%"; -- contem "SILVA"

SELECT * FROM telefone WHERE telefone IS NULL;
SELECT * FROM telefone WHERE telefone IS NOT NULL;

SELECT * FROM pessoa ORDER BY nome; -- sintaxe normal
SELECT * FROM pessoa ORDER BY nome ASC; -- do menor valor para o maoir
SELECT * FROM pessoa ORDER BY nome DESC; -- do maior valor para o menor

SELECT * FROM telefone WHERE telefone IS NOT NULL OR ddd = "61";

UPDATE telefone SET telefone = "542263322" WHERE id_telefone = 3 ;