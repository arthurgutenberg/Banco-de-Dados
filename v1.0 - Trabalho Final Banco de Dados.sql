CREATE DATABASE caravana_de_grayhlander;

USE caravana_de_grayhlander;

CREATE TABLE expedição(
	idexpedicao INT PRIMARY KEY AUTO_INCREMENT, 
	nome VARCHAR(100),
    reino_de_destino VARCHAR(100),
    data_de_chegada DATE NOT NULL,
    data_de_partida DATE NOT NULL,
    visitantes_estimados VARCHAR(10000)
);

CREATE TABLE classificacao_comerciante(
	idclassificacao_comerciante INT PRIMARY KEY AUTO_INCREMENT,
    id_comerciante INT NOT NULL,
	classificacao ENUM(
        'S',
        'A',
        'B',
        'C',
        'D',
        'E',
        'F'
    ) NOT NULL,
    FOREIGN KEY (id_comerciante) REFERENCES comerciante(idcomerciante)
);

CREATE TABLE comerciante(
	idcomerciante INT PRIMARY KEY AUTO_INCREMENT,
    id_classificacao_comerciante INT NOT NULL,
	nome VARCHAR(100),
    raça ENUM(
		'humano','elfo','anao',
        'homem-fera','orc','halfling',
        'reptiliano','gnomo','draconato',
        'meio-elfo','meio-orc','satiro',
        'centauro','minotauro'
	) NOT NULL,
    especializacao VARCHAR(100),
    cidade_natal VARCHAR(100),
    contato_magico VARCHAR(100),
    tipo_acesso ENUM('gratuito', 'pago') NOT NULL,
    FOREIGN KEY (id_classificacao_comerciante) REFERENCES classificacao_comerciante(idclassificacao_comerciante)
);

CREATE TABLE certificado_participacao(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_comerciante INT NOT NULL,
    id_expedicao INT NOT NULL,
    data_emissao DATE NOT NULL,
    FOREIGN KEY (id_comerciante) REFERENCES comerciante(idcomerciante),
    FOREIGN KEY (id_expedicao) REFERENCES expedicao(idexpedicao)
);

CREATE TABLE reserva_tenda(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_comerciante INT NOT NULL,
    id_expedicao INT NOT NULL,
    tipo_tenda ENUM(
		'pequena',
        'média', 
        'grande'
	) NOT NULL,
    recurso_especial ENUM(
        'nenhum',
        'proteção mágica',
        'espaço para animais',
        'segurança reforçada',
		'iluminação arcana'
    ) NOT NULL,
    forma_pagamento ENUM(
		'ouro',
		'gema mágica',
		'troca de favores',
		'crédito arcano'
    ) NOT NULL,
    data_pagamento DATE NOT NULL,
    FOREIGN KEY (id_comerciante) REFERENCES comerciante(idcomerciante),
    FOREIGN KEY (id_expedicao) REFERENCES expedicao(idexpedicao)
);

CREATE TABLE produto(
	idproduto INT PRIMARY KEY AUTO_INCREMENT,
    id_comerciante INT NOT NULL,
    id_roupa_magia INT NOT NULL,
    id_armadura INT NOT NULL,
    id_alimento_magico INT NOT NULL,
    id_pocao INT NOT NULL,
    id_grimorio INT NOT NULL,
    id_artefato INT NOT NULL,
    id_amuleto INT NOT NULL,
    id_ingrediente_magico INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    categoria ENUM(
		'roupa_magica',
        'armadura',
        'alimento_magico',
        'pocao',
        'grimorio',
        'artefato',
        'amuleto',
        'ingrediente_magico'
    ) NOT NULL,
	raridade ENUM(
		'comum',
		'incomum',
		'raro',
		'lendário',
		'único'
    ) NOT NULL,
	forma_pagamento ENUM(
		'ouro',
		'gema mágica',
		'troca de favores',
		'crédito arcano'
    ) NOT NULL,
    preco DECIMAL(1000000),
    descricao TEXT,
    FOREIGN KEY (id_comerciante) REFERENCES comerciante(idcomerciante),
    FOREIGN KEY (id_roupa_magia) REFERENCES roupa_magia(idroupa_magia),
    FOREIGN KEY (id_armadura) REFERENCES armadura(idarmadura),
    FOREIGN KEY (id_alimento_magico) REFERENCES alimento_magico(idalimento_magico),
    FOREIGN KEY (id_pocao) REFERENCES pocao(idpocao),
    FOREIGN KEY (id_grimorio) REFERENCES grimorio(idgrimorio),
    FOREIGN KEY (id_artefato) REFERENCES artefato(idartefato),
    FOREIGN KEY (id_amuleto) REFERENCES amuleto(idamuleto),
    FOREIGN KEY (id_ingrediente_magico) REFERENCES ingrediente_magico(idingrediente_magico)    
);

CREATE TABLE roupa_magica (
    id_produto INT PRIMARY KEY,
    tipo ENUM('manto', 'chapéu', 'botas', 'luvas', 'túnica', 'capa') NOT NULL,
    bonus_magico TEXT,
    cor_predominante VARCHAR(50),

    FOREIGN KEY (id_produto) REFERENCES ProdutoMagico(id)
);

CREATE TABLE armadura(
    id_produto INT PRIMARY KEY,
    tipo ENUM('leve', 'média', 'pesada', 'escudo') NOT NULL,
    defesa_fisica INT,
    defesa_magica INT,
    nivel_minimo INT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE alimento_magico(
    id_produto INT PRIMARY KEY,
    tipo ENUM('comida', 'bebida', 'doce', 'poção comestível') NOT NULL,
    efeito TEXT,
    sabor VARCHAR(50),
    duracao_efeito_min INT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE pocao(
    id_produto INT PRIMARY KEY,
    tipo ENUM('cura', 'mana', 'veneno', 'visão', 'força') NOT NULL,
    duracao_min INT,
    concentracao BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE grimorio(
    id_produto INT PRIMARY KEY,
    escola_magia ENUM('fogo', 'gelo', 'cura', 'ilusão', 'transmutação', 'necromancia') NOT NULL,
    nivel_requerido INT,
    quantidade_feiticos INT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE artefato(
    id_produto INT PRIMARY KEY,
    uso_principal VARCHAR(100),
    tempo_recarga_min INT,
    ativacao ENUM('manual', 'verbal', 'mental', 'automática') NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE amuleto(
    id_produto INT PRIMARY KEY,
    efeito_passivo TEXT,
    material VARCHAR(100),
    sintonizavel BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE ingrediente_magico(
    id_produto INT PRIMARY KEY,
    origem ENUM('animal', 'vegetal', 'mineral', 'místico') NOT NULL,
    raro BOOLEAN DEFAULT FALSE,
    usado_em TEXT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);


CREATE TABLE registo_compra(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_visitante INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    data_compra DATE NOT NULL,
    FOREIGN KEY (id_visitante) REFERENCES visitante(idvisitante),
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE visitante(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    reino_origem VARCHAR(100),
    email VARCHAR(100),
    deseja_receber_novidades BOOLEAN DEFAULT FALSE -- caso ele queira ser informado das novidades da loja
);

CREATE TABLE avaliacao( -- pode ser tanto do visitante como do comerciante
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_visitante INT NOT NULL,
    id_comerciante INT NOT NULL,
    id_produto INT, -- opcional (pode ser NULL se for uma avaliação geral do comerciante)
    tipo_interacao ENUM('avaliação', 'favorito') NOT NULL,
    estrelas INT CHECK (estrelas BETWEEN 1 AND 5), -- só se for avaliação
    comentario TEXT,
    data_interacao DATE NOT NULL,
    FOREIGN KEY (id_visitante) REFERENCES visitante(idvisitante),
    FOREIGN KEY (id_comerciante) REFERENCES comerciante(idcomerciante),
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);