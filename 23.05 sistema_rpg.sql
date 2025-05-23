CREATE DATABASE sistema_rpg;
USE sistema_rpg;


CREATE TABLE classe(
    idclasse INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT
);

CREATE TABLE item(
    iditem INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    efeito TEXT
);

CREATE TABLE personagem(
    idpersonagem INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    nivel INT DEFAULT 1,
    experiencia INT DEFAULT 0,
    id_classe INT NOT NULL,
	id_item INT NOT NULL,
    FOREIGN KEY (id_classe) REFERENCES classe(idclasse),
    FOREIGN KEY (id_item) REFERENCES item(iditem)
);


CREATE TABLE habilidade(
    idhabilidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    dano INT,
    custo_mana INT,
    id_classe INT NOT NULL,
    FOREIGN KEY (id_classe) REFERENCES classe(idclasse)
);

CREATE TABLE missao(
    idmissao INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    recompensa_ouro INT,
    recompensa_exp INT,
    id_personagem INT NOT NULL,
    FOREIGN KEY (id_personagem) REFERENCES personagem(idpersonagem)
);
