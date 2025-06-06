
-- Criação do banco
CREATE DATABASE revisao_para_prova;
USE revisao_para_prova;

-- Tabela aluno
CREATE TABLE aluno(
    idaluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    data_de_nascimento DATE,
    RA VARCHAR(8),
    curso VARCHAR(100)
);

-- Tabela professor
CREATE TABLE professor(
    idprofessor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    data_de_nascimento DATE,
    RP VARCHAR(100),
    materia VARCHAR(100),
    cursos VARCHAR(500)
);

-- Tabela prova
CREATE TABLE prova (
    idprova INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT NOT NULL,
    id_professor INT NOT NULL,
    pontuacao VARCHAR(10),
    mencao ENUM('SR', 'II', 'MI', 'MM', 'MS', 'SS') NOT NULL,
    comentario TEXT,
    FOREIGN KEY (id_aluno) REFERENCES aluno(idaluno),
    FOREIGN KEY (id_professor) REFERENCES professor(idprofessor)
);

-- Inserção de aluno
INSERT INTO aluno (nome, data_de_nascimento, RA, curso) VALUES
('ralielison', '2000-04-07', '12345678', 'Ciencia da Computação');

-- Inserção de professor
INSERT INTO professor (nome, data_de_nascimento, RP, materia, cursos) VALUES
('mikaele', '1980-07-04', '87654321', 'banco de dados', 'Ciencia da Computação, ADS');

-- Seleções
SELECT * FROM aluno;

SELECT * FROM professor WHERE cursos LIKE 'C%';

SELECT nome FROM aluno
UNION
SELECT nome FROM professor;
