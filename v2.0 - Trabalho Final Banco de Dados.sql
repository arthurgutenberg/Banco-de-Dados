-- Criação do banco de dados
CREATE DATABASE caravana_de_grayhlander;
USE caravana_de_grayhlander;

USE caravana_de_grayhlander;

-- Tabela de expedições
CREATE TABLE expedicao (
    idexpedicao INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(100),
    reino_de_destino VARCHAR(100),
    data_de_chegada DATE NOT NULL,
    data_de_partida DATE NOT NULL,
    visitantes_estimados VARCHAR(10000)
);

-- Tabela de comerciantes
CREATE TABLE comerciante (
    idcomerciante INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    raca ENUM(
        'humano','elfo','anao','homem-fera','orc','halfling',
        'reptiliano','gnomo','draconato','meio-elfo','meio-orc',
        'satiro','centauro','minotauro'
    ) NOT NULL,
    especializacao VARCHAR(100),
    cidade_natal VARCHAR(100),
    contato_magico VARCHAR(100),
    tipo_acesso ENUM('gratuito', 'pago') NOT NULL
);

-- Classificação dos comerciantes
CREATE TABLE classificacao_comerciante (
    idclassificacao_comerciante INT PRIMARY KEY AUTO_INCREMENT,
    id_comerciante INT NOT NULL,
    classificacao ENUM('S','A','B','C','D','E','F') NOT NULL,
    FOREIGN KEY (id_comerciante) REFERENCES comerciante(idcomerciante)
);

-- Certificados de participação
CREATE TABLE certificado_participacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_comerciante INT NOT NULL,
    id_expedicao INT NOT NULL,
    data_emissao DATE NOT NULL,
    FOREIGN KEY (id_comerciante) REFERENCES comerciante(idcomerciante),
    FOREIGN KEY (id_expedicao) REFERENCES expedicao(idexpedicao)
);

-- Reserva de tendas
CREATE TABLE reserva_tenda (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_comerciante INT NOT NULL,
    id_expedicao INT NOT NULL,
    tipo_tenda ENUM('pequena', 'média', 'grande') NOT NULL,
    recurso_especial ENUM('nenhum', 'proteção mágica', 'espaço para animais', 'segurança reforçada', 'iluminação arcana') NOT NULL,
    forma_pagamento ENUM('ouro', 'gema mágica', 'troca de favores', 'crédito arcano') NOT NULL,
    data_pagamento DATE NOT NULL,
    FOREIGN KEY (id_comerciante) REFERENCES comerciante(idcomerciante),
    FOREIGN KEY (id_expedicao) REFERENCES expedicao(idexpedicao)
);

-- Produtos
CREATE TABLE produto (
    idproduto INT PRIMARY KEY AUTO_INCREMENT,
    id_comerciante INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    categoria ENUM('roupa_magica','armadura','alimento_magico','pocao','grimorio','artefato','amuleto','ingrediente_magico') NOT NULL,
    raridade ENUM('comum','incomum','raro','lendário','único') NOT NULL,
    forma_pagamento ENUM('ouro','gema mágica','troca de favores','crédito arcano') NOT NULL,
    preco DECIMAL(10,2),
    descricao TEXT,
    FOREIGN KEY (id_comerciante) REFERENCES comerciante(idcomerciante)
);

-- Tabelas específicas de produtos
CREATE TABLE roupa_magica (
    id_produto INT PRIMARY KEY,
    tipo ENUM('manto', 'chapéu', 'botas', 'luvas', 'túnica', 'capa') NOT NULL,
    bonus_magico TEXT,
    cor_predominante VARCHAR(50),
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE armadura (
    id_produto INT PRIMARY KEY,
    tipo ENUM('leve', 'média', 'pesada', 'escudo') NOT NULL,
    defesa_fisica INT,
    defesa_magica INT,
    nivel_minimo INT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE alimento_magico (
    id_produto INT PRIMARY KEY,
    tipo ENUM('comida', 'bebida', 'doce', 'poção comestível') NOT NULL,
    efeito TEXT,
    sabor VARCHAR(50),
    duracao_efeito_min INT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE pocao (
    id_produto INT PRIMARY KEY,
    tipo ENUM('cura', 'mana', 'veneno', 'visão', 'força') NOT NULL,
    duracao_min INT,
    concentracao BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE grimorio (
    id_produto INT PRIMARY KEY,
    escola_magia ENUM('fogo', 'gelo', 'cura', 'ilusão', 'transmutação', 'necromancia') NOT NULL,
    nivel_requerido INT,
    quantidade_feiticos INT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE artefato (
    id_produto INT PRIMARY KEY,
    uso_principal VARCHAR(100),
    tempo_recarga_min INT,
    ativacao ENUM('manual', 'verbal', 'mental', 'automática') NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE amuleto (
    id_produto INT PRIMARY KEY,
    efeito_passivo TEXT,
    material VARCHAR(100),
    sintonizavel BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE ingrediente_magico (
    id_produto INT PRIMARY KEY,
    origem ENUM('animal', 'vegetal', 'mineral', 'místico') NOT NULL,
    raro BOOLEAN DEFAULT FALSE,
    usado_em TEXT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

-- Visitantes
CREATE TABLE visitante (
    idvisitante INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    raca ENUM(
        'humano','elfo','anao','homem-fera','orc','halfling',
        'reptiliano','gnomo','draconato','meio-elfo','meio-orc',
        'satiro','centauro','minotauro'
    ) NOT NULL,
    reino_origem VARCHAR(100),
    email VARCHAR(100),
    deseja_receber_novidades BOOLEAN DEFAULT FALSE
);

-- Registro de compras
CREATE TABLE registo_compra (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_visitante INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    data_compra DATE NOT NULL,
    FOREIGN KEY (id_visitante) REFERENCES visitante(idvisitante),
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

-- Avaliações
CREATE TABLE avaliacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_visitante INT NOT NULL,
    id_comerciante INT NOT NULL,
    id_produto INT,
    tipo_interacao ENUM('avaliação', 'favorito') NOT NULL,
    estrelas INT CHECK (estrelas BETWEEN 1 AND 5),
    comentario TEXT,
    data_interacao DATE NOT NULL,
    FOREIGN KEY (id_visitante) REFERENCES visitante(idvisitante),
    FOREIGN KEY (id_comerciante) REFERENCES comerciante(idcomerciante),
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

INSERT INTO comerciante (nome, raca, especializacao, cidade_natal, contato_magico, tipo_acesso) VALUES
('Weylin', 'humano', 'Sabedoria Dracônica', 'FalHareth', 'weylin@magiafantastica.com', 'gratuito'),
('Quorin', 'meio-elfo', 'Cartografia Mágica', 'Drakmor', 'quorin@magiafantastica.com', 'pago'),
('Lyra', 'halfling', 'Cartografia Mágica', 'Dreadspire', 'lyra@magiafantastica.com', 'gratuito'),
('Wynna', 'meio-orc', 'Gemologia Mística', 'FalHareth', 'wynna@magiafantastica.com', 'pago'),
('Orion', 'anao', 'Gemologia Mística', 'ThalDor', 'orion@magiafantastica.com', 'pago'),
('Faelar', 'centauro', 'Poções Elementais', 'FalHareth', 'faelar@magiafantastica.com', 'gratuito'),
('Bryndis', 'humano', 'Curas Naturais', 'Eldoria', 'bryndis@magiafantastica.com', 'pago'),
('Caelum', 'humano', 'Armas Encantadas', 'Caer Vanyr', 'caelum@magiafantastica.com', 'gratuito'),
('Rhiannon', 'minotauro', 'Curas Naturais', 'Ithilien', 'rhiannon@magiafantastica.com', 'pago'),
('Ylva', 'minotauro', 'Sabedoria Dracônica', 'Glimmerdeep', 'ylva@magiafantastica.com', 'pago'),
('Fendrel', 'homem-fera', 'Armas Encantadas', 'Drakmor', 'fendrel@magiafantastica.com', 'pago'),
('Oryn', 'draconato', 'Gemologia Mística', 'Oakshade', 'oryn@magiafantastica.com', 'gratuito'),
('Nymira', 'meio-elfo', 'Têxteis Arcanos', 'Nethervale', 'nymira@magiafantastica.com', 'gratuito'),
('Ivar', 'minotauro', 'Bestiário Exótico', 'Grimreach', 'ivar@magiafantastica.com', 'gratuito'),
('Helion', 'homem-fera', 'Gemologia Mística', 'Aethergard', 'helion@magiafantastica.com', 'pago'),
('Jareth', 'satiro', 'Sabedoria Dracônica', 'Silverfen', 'jareth@magiafantastica.com', 'gratuito'),
('Lirael', 'halfling', 'Têxteis Arcanos', 'Drakmor', 'lirael@magiafantastica.com', 'pago'),
('Kael', 'draconato', 'Gemologia Mística', 'Grimreach', 'kael@magiafantastica.com', 'pago'),
('Daeris', 'meio-elfo', 'Curas Naturais', 'ThalDor', 'daeris@magiafantastica.com', 'gratuito'),
('Vaelis', 'centauro', 'Cartografia Mágica', 'Eldoria', 'vaelis@magiafantastica.com', 'pago'),
('Isolde', 'homem-fera', 'Têxteis Arcanos', 'Glimmerdeep', 'isolde@magiafantastica.com', 'gratuito'),
('Miriel', 'meio-orc', 'Bestiário Exótico', 'Caer Vanyr', 'miriel@magiafantastica.com', 'pago'),
('Aelric', 'meio-orc', 'Sabedoria Dracônica', 'Mooncliff', 'aelric@magiafantastica.com', 'pago'),
('Caladrel', 'satiro', 'Têxteis Arcanos', 'Dreadspire', 'caladrel@magiafantastica.com', 'gratuito'),
('Thorne', 'draconato', 'Sabedoria Dracônica', 'Aethergard', 'thorne@magiafantastica.com', 'gratuito'),
('Kethril', 'satiro', 'Relíquias Perdidas', 'Stormhold', 'kethril@magiafantastica.com', 'pago'),
('Galad', 'reptiliano', 'Têxteis Arcanos', 'Aethergard', 'galad@magiafantastica.com', 'pago'),
('Talion', 'minotauro', 'Têxteis Arcanos', 'FalHareth', 'talion@magiafantastica.com', 'gratuito'),
('Jorund', 'meio-orc', 'Curas Naturais', 'ThalDor', 'jorund@magiafantastica.com', 'gratuito'),
('Penumbra', 'reptiliano', 'Gemologia Mística', 'Eldoria', 'penumbra@magiafantastica.com', 'gratuito'),
('Ulric', 'minotauro', 'Armas Encantadas', 'Stormhold', 'ulric@magiafantastica.com', 'pago'),
('Ragnar', 'minotauro', 'Armas Encantadas', 'Ithilien', 'ragnar@magiafantastica.com', 'pago'),
('Zarek', 'anao', 'Relíquias Perdidas', 'Drakmor', 'zarek@magiafantastica.com', 'gratuito'),
('Seraphine', 'halfling', 'Relíquias Perdidas', 'KarnThalas', 'seraphine@magiafantastica.com', 'pago'),
('Quira', 'anao', 'Runas Antigas', 'KarnThalas', 'quira@magiafantastica.com', 'gratuito'),
('Nolric', 'halfling', 'Sabedoria Dracônica', 'Ravenholm', 'nolric@magiafantastica.com', 'pago'),
('Zephra', 'meio-orc', 'Têxteis Arcanos', 'Silverfen', 'zephra@magiafantastica.com', 'pago'),
('Hrothgar', 'homem-fera', 'Relíquias Perdidas', 'Dreadspire', 'hrothgar@magiafantastica.com', 'pago'),
('Umbra', 'satiro', 'Poções Elementais', 'Nethervale', 'umbra@magiafantastica.com', 'gratuito'),
('Gwendal', 'meio-orc', 'Cartografia Mágica', 'Mystralis', 'gwendal@magiafantastica.com', 'gratuito'),
('Elandra', 'gnomo', 'Curas Naturais', 'Grimreach', 'elandra@magiafantastica.com', 'pago'),
('Borin', 'reptiliano', 'Poções Elementais', 'Viremoor', 'borin@magiafantastica.com', 'gratuito'),
('Elaith', 'halfling', 'Relíquias Perdidas', 'Eldoria', 'elaith@magiafantastica.com', 'pago'),
('Darian', 'humano', 'Runas Antigas', 'Stormhold', 'darian@magiafantastica.com', 'gratuito'),
('Xandor', 'elfo', 'Curas Naturais', 'Mooncliff', 'xandor@magiafantastica.com', 'gratuito'),
('Maelis', 'halfling', 'Gemologia Mística', 'Mooncliff', 'maelis@magiafantastica.com', 'pago'),
('Valen', 'centauro', 'Têxteis Arcanos', 'Mystralis', 'valen@magiafantastica.com', 'pago'),
('Aeris', 'reptiliano', 'Sabedoria Dracônica', 'Mystralis', 'aeris@magiafantastica.com', 'pago'),
('Sylvar', 'humano', 'Cartografia Mágica', 'Glimmerdeep', 'sylvar@magiafantastica.com', 'pago'),
('Peregrin', 'halfling', 'Relíquias Perdidas', 'KarnThalas', 'peregrin@magiafantastica.com', 'gratuito');
