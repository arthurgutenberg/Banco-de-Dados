-- Criação do banco de dados
CREATE DATABASE caravana_de_grayhlander;
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
    fk_idcomerciante INT NOT NULL,
    classificacao ENUM('S','A','B','C','D','E','F') NOT NULL,
    FOREIGN KEY (fk_idcomerciante) REFERENCES comerciante(idcomerciante)
);

-- Certificados de participação
CREATE TABLE certificado_participacao (
    idcertificado_participacao INT PRIMARY KEY AUTO_INCREMENT,
    id_comerciante INT NOT NULL,
    id_expedicao INT NOT NULL,
    data_emissao DATE NOT NULL,
    FOREIGN KEY (fk_idcomerciante) REFERENCES comerciante(idcomerciante),
    FOREIGN KEY (fk_idexpedicao) REFERENCES expedicao(idexpedicao)
);

-- Reserva de tendas
CREATE TABLE reserva_tenda (
    idreserva_tenda INT PRIMARY KEY AUTO_INCREMENT,
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
    idroupa_magica INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT PRIMARY KEY,
    tipo ENUM('manto', 'chapéu', 'botas', 'luvas', 'túnica', 'capa') NOT NULL,
    bonus_magico TEXT,
    cor_predominante VARCHAR(50),
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE armadura (
    idarmadura INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT PRIMARY KEY,
    tipo ENUM('leve', 'média', 'pesada', 'escudo') NOT NULL,
    defesa_fisica INT,
    defesa_magica INT,
    nivel_minimo INT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE alimento_magico (
    idalimento_magico INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT PRIMARY KEY,
    tipo ENUM('comida', 'bebida', 'doce', 'poção comestível') NOT NULL,
    efeito TEXT,
    sabor VARCHAR(50),
    duracao_efeito_min INT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE pocao (
    idpocao INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT PRIMARY KEY,
    tipo ENUM('cura', 'mana', 'veneno', 'visão', 'força') NOT NULL,
    duracao_min INT,
    concentracao BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE grimorio (
    idgrimorio INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT PRIMARY KEY,
    escola_magia ENUM('fogo', 'gelo', 'cura', 'ilusão', 'transmutação', 'necromancia') NOT NULL,
    nivel_requerido INT,
    quantidade_feiticos INT,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE artefato (
    idartefato INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT PRIMARY KEY,
    uso_principal VARCHAR(100),
    tempo_recarga_min INT,
    ativacao ENUM('manual', 'verbal', 'mental', 'automática') NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE amuleto (
    idamuleto INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT PRIMARY KEY,
    efeito_passivo TEXT,
    material VARCHAR(100),
    sintonizavel BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE ingrediente_magico (
    idingrediente magico INT PRIMARY KEY AUTO_INCREMENT,
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
    idregistro_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_visitante INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    data_compra DATE NOT NULL,
    FOREIGN KEY (id_visitante) REFERENCES visitante(idvisitante),
    FOREIGN KEY (id_produto) REFERENCES produto(idproduto)
);

-- Avaliações
CREATE TABLE avaliacao (
    idavaliacao INT PRIMARY KEY AUTO_INCREMENT,
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

-- -----------------------------INSERÇÕES------------------------------

INSERT INTO expedicao (nome, reino_de_destino, data_de_chegada, data_de_partida, visitantes_estimados) VALUES
('Luar de Lunaris', 'Aeloria', '2025-03-21', '2025-03-28', 1200),
('Marcha das Runas', 'Drakmor', '2025-04-15', '2025-04-25', 980),
('Eco das Estrelas', 'Thundraal', '2025-05-02', '2025-05-10', 1430),
('Aurora de Nyssara', 'Nyssara', '2025-06-01', '2025-06-12', 1100),
('Feira dos Vagalumes', 'Verenthia', '2025-07-10', '2025-07-18', 1650),
('Celebração dos Quatro Ventos', 'FalHareth', '2025-08-03', '2025-08-10', 1005),
('Rastro dos Dragões', 'Grimreach', '2025-09-12', '2025-09-20', 980),
('Caminho dos Cristais', 'ThalDor', '2025-10-01', '2025-10-08', 875),
('Brumas da Ancestralidade', 'Eldoria', '2025-11-05', '2025-11-14', 1540),
('Lua de Sangue em Stormhold', 'Stormhold', '2025-12-20', '2025-12-28', 1890),
('Festival das Marés Vivas', 'Aethergard', '2026-01-10', '2026-01-17', 1120),
('Chama Eterna', 'Oakshade', '2026-02-18', '2026-02-25', 1325),
('Marcha Lunar', 'Caer Vanyr', '2026-03-12', '2026-03-18', 905),
('Eco do Relâmpago', 'Nethervale', '2026-04-07', '2026-04-13', 1440),
('Caminho da Rosa Branca', 'Mooncliff', '2026-05-01', '2026-05-08', 1235),
('Encontro das Feras', 'Drakmor', '2026-06-22', '2026-06-29', 1675),
('Rota do Vórtice', 'Glimmerdeep', '2026-07-18', '2026-07-25', 930),
('Dança dos Espíritos', 'Silverfen', '2026-08-15', '2026-08-22', 1010),
('Trilha da Névoa Azul', 'Viremoor', '2026-09-10', '2026-09-16', 885),
('Comércio do Crepúsculo', 'Ithilien', '2026-10-03', '2026-10-10', 1140),
('Alvorada Carmesim', 'KarnThalas', '2026-11-01', '2026-11-08', 1220),
('Feira das Areias Mágicas', 'Dreadspire', '2026-12-05', '2026-12-12', 1600),
('Chamada de Mystralis', 'Mystralis', '2027-01-06', '2027-01-13', 900),
('Ventos de Ravenholm', 'Ravenholm', '2027-02-15', '2027-02-22', 980),
('Fronteiras da Essência', 'Verenthia', '2027-03-21', '2027-03-29', 1345),
('Solstício das Sombras', 'Oakshade', '2027-04-20', '2027-04-28', 1070),
('Marcha da Rosa Negra', 'FalHareth', '2027-05-12', '2027-05-19', 1390),
('Estrelas de Gelo', 'Aeloria', '2027-06-10', '2027-06-17', 1125),
('Trovão Sagrado', 'Thundraal', '2027-07-01', '2027-07-09', 1565),
('Expedição do Coração Rúnico', 'Drakmor', '2027-08-05', '2027-08-12', 1015),
('Caminho dos Lamentos', 'Nethervale', '2027-09-01', '2027-09-07', 880),
('Luz dos Vales', 'Eldoria', '2027-10-02', '2027-10-10', 990),
('Portões de Cristal', 'ThalDor', '2027-11-11', '2027-11-18', 1230),
('Festa das Almas Antigas', 'Mooncliff', '2027-12-07', '2027-12-14', 1105),
('Cantiga das Montanhas', 'Drakmor', '2028-01-05', '2028-01-12', 960),
('Véu das Tempestades', 'Stormhold', '2028-02-03', '2028-02-10', 1170),
('Mistérios de Glimmerdeep', 'Glimmerdeep', '2028-03-08', '2028-03-15', 1295),
('Caminho dos Ecos', 'Caer Vanyr', '2028-04-10', '2028-04-16', 995),
('Trilha do Fogo Eterno', 'Silverfen', '2028-05-05', '2028-05-12', 1060),
('Cores de Ithilien', 'Ithilien', '2028-06-01', '2028-06-08', 1080),
('Jornada dos Céus', 'Aethergard', '2028-07-06', '2028-07-13', 1400),
('Sombras de KarnThalas', 'KarnThalas', '2028-08-04', '2028-08-11', 970),
('Almas da Névoa', 'Nyssara', '2028-09-09', '2028-09-16', 1155),
('Luz dos Ancestrais', 'FalHareth', '2028-10-07', '2028-10-14', 1235),
('Festival das Fontes Eternas', 'Verenthia', '2028-11-08', '2028-11-15', 1395),
('Onda Mística', 'Mystralis', '2028-12-10', '2028-12-17', 1040),
('Trégua das Tribos', 'Thundraal', '2029-01-08', '2029-01-15', 950),
('Expedição das Relíquias', 'Stormhold', '2029-02-12', '2029-02-19', 1000),
('Encantos de Viremoor', 'Viremoor', '2029-03-14', '2029-03-21', 990),
('Encontro de Sábios', 'Ravenholm', '2029-04-18', '2029-04-25', 880),
('Lua de Cristal', 'Grimreach', '2029-05-20', '2029-05-27', 1115);

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

INSERT INTO classificacao_comerciante (id_comerciante, classificacao) VALUES
(1, 'E'), (2, 'S'), (3, 'S'), (4, 'E'), (5, 'B'),
(6, 'F'), (7, 'E'), (8, 'A'), (9, 'B'), (10, 'C'),
(11, 'A'), (12, 'A'), (13, 'B'), (14, 'D'), (15, 'F'),
(16, 'S'), (17, 'B'), (18, 'S'), (19, 'C'), (20, 'A'),
(21, 'A'), (22, 'E'), (23, 'F'), (24, 'C'), (25, 'F'),
(26, 'E'), (27, 'F'), (28, 'C'), (29, 'F'), (30, 'A'),
(31, 'C'), (32, 'F'), (33, 'C'), (34, 'F'), (35, 'C'),
(36, 'D'), (37, 'E'), (38, 'E'), (39, 'E'), (40, 'D'),
(41, 'C'), (42, 'F'), (43, 'S'), (44, 'C'), (45, 'F'),
(46, 'B'), (47, 'S'), (48, 'C'), (49, 'B'), (50, 'A');

INSERT INTO certificado_participacao (id_comerciante, id_expedicao, data_emissao) VALUES
(6, 7, '2025-03-26'), (23, 14, '2024-11-19'), (39, 5, '2024-03-27'),
(3, 12, '2024-09-21'), (35, 2, '2024-11-02'), (12, 13, '2024-10-18'),
(48, 6, '2024-05-09'), (31, 11, '2024-08-25'), (43, 2, '2024-07-28'),
(24, 9, '2024-04-16'), (13, 6, '2024-06-06'), (1, 10, '2024-04-07'),
(2, 5, '2024-09-12'), (45, 15, '2024-07-20'), (4, 11, '2025-02-01'),
(25, 3, '2024-10-26'), (40, 14, '2024-06-25'), (10, 8, '2025-01-27'),
(16, 4, '2024-04-24'), (22, 7, '2024-11-07'), (30, 5, '2024-09-07'),
(20, 1, '2024-08-10'), (5, 12, '2024-06-01'), (17, 9, '2024-12-21'),
(27, 10, '2025-02-14'), (9, 6, '2025-02-27'), (46, 13, '2025-01-22'),
(26, 8, '2024-10-08'), (44, 5, '2025-03-07'), (47, 2, '2024-12-14'),
(33, 11, '2025-01-02'), (28, 7, '2024-12-01'), (14, 1, '2024-03-27'),
(21, 3, '2024-07-04'), (11, 14, '2025-03-15'), (49, 4, '2024-04-28'),
(34, 10, '2024-09-26'), (18, 9, '2024-10-03'), (7, 6, '2025-02-21'),
(29, 12, '2024-06-16'), (41, 15, '2024-10-12'), (8, 11, '2024-08-16'),
(15, 7, '2024-11-25'), (50, 13, '2024-09-01'), (42, 4, '2025-02-08'),
(32, 8, '2024-12-09'), (36, 5, '2024-06-11'), (37, 2, '2024-07-17'),
(19, 15, '2024-03-24'), (38, 3, '2024-11-12'), (16, 14, '2025-01-15'),
(6, 9, '2024-06-22'), (23, 1, '2024-08-06'), (12, 13, '2024-04-21'),
(48, 10, '2024-11-29'), (31, 6, '2025-01-10'), (43, 7, '2024-07-11'),
(24, 11, '2024-03-29'), (13, 2, '2024-09-16'), (1, 4, '2024-12-17'),
(2, 12, '2024-10-22'), (45, 14, '2024-09-29'), (4, 3, '2024-06-18'),
(25, 8, '2024-12-25'), (40, 5, '2024-07-31'), (10, 9, '2025-03-12'),
(22, 15, '2024-11-15'), (30, 13, '2025-01-04'), (20, 1, '2024-07-08'),
(5, 11, '2025-03-01'), (17, 10, '2024-06-14'), (27, 6, '2025-02-25'),
(9, 7, '2024-08-01'), (46, 4, '2024-04-25'), (26, 2, '2025-02-04');

INSERT INTO reserva_tenda (id_comerciante, id_expedicao, tipo_tenda, recurso_especial, forma_pagamento, data_pagamento) VALUES
(1, 1, 'média', 'proteção mágica', 'ouro', '2025-03-15'),
(2, 2, 'grande', 'espaço para animais', 'gema mágica', '2025-03-18'),
(3, 3, 'pequena', 'nenhum', 'troca de favores', '2025-03-20'),
(4, 4, 'média', 'segurança reforçada', 'crédito arcano', '2025-03-22'),
(5, 5, 'grande', 'iluminação arcana', 'ouro', '2025-03-25'),
(6, 1, 'média', 'proteção mágica', 'gema mágica', '2025-03-27'),
(7, 2, 'pequena', 'espaço para animais', 'troca de favores', '2025-03-30'),
(8, 3, 'grande', 'segurança reforçada', 'crédito arcano', '2025-04-01'),
(9, 4, 'média', 'iluminação arcana', 'ouro', '2025-04-03'),
(10, 5, 'pequena', 'nenhum', 'gema mágica', '2025-04-05'),
(1, 2, 'grande', 'proteção mágica', 'troca de favores', '2025-04-07'),
(2, 3, 'média', 'espaço para animais', 'ouro', '2025-04-09'),
(3, 4, 'pequena', 'segurança reforçada', 'crédito arcano', '2025-04-11'),
(4, 5, 'grande', 'iluminação arcana', 'gema mágica', '2025-04-13'),
(5, 1, 'média', 'nenhum', 'ouro', '2025-04-15'),
(6, 2, 'grande', 'proteção mágica', 'troca de favores', '2025-04-17'),
(7, 3, 'média', 'espaço para animais', 'crédito arcano', '2025-04-19'),
(8, 4, 'pequena', 'segurança reforçada', 'ouro', '2025-04-21'),
(9, 5, 'grande', 'iluminação arcana', 'troca de favores', '2025-04-23'),
(10, 1, 'média', 'nenhum', 'gema mágica', '2025-04-25'),
(1, 3, 'pequena', 'proteção mágica', 'ouro', '2025-04-27'),
(2, 4, 'grande', 'espaço para animais', 'crédito arcano', '2025-04-29'),
(3, 5, 'média', 'segurança reforçada', 'troca de favores', '2025-05-01'),
(4, 1, 'pequena', 'iluminação arcana', 'gema mágica', '2025-05-03'),
(5, 2, 'grande', 'nenhum', 'ouro', '2025-05-05'),
(6, 3, 'média', 'proteção mágica', 'gema mágica', '2025-05-07'),
(7, 4, 'grande', 'espaço para animais', 'crédito arcano', '2025-05-09'),
(8, 5, 'pequena', 'segurança reforçada', 'ouro', '2025-05-11'),
(9, 1, 'média', 'iluminação arcana', 'troca de favores', '2025-05-13'),
(10, 2, 'grande', 'nenhum', 'gema mágica', '2025-05-15'),
(1, 4, 'média', 'proteção mágica', 'ouro', '2025-05-17'),
(2, 5, 'pequena', 'espaço para animais', 'troca de favores', '2025-05-19'),
(3, 1, 'grande', 'segurança reforçada', 'crédito arcano', '2025-05-21'),
(4, 2, 'média', 'iluminação arcana', 'ouro', '2025-05-23'),
(5, 3, 'pequena', 'nenhum', 'gema mágica', '2025-05-25'),
(6, 4, 'grande', 'proteção mágica', 'troca de favores', '2025-05-27'),
(7, 5, 'média', 'espaço para animais', 'crédito arcano', '2025-05-29'),
(8, 1, 'grande', 'segurança reforçada', 'ouro', '2025-05-31'),
(9, 2, 'pequena', 'iluminação arcana', 'troca de favores', '2025-06-02'),
(10, 3, 'média', 'nenhum', 'gema mágica', '2025-06-04'),
(1, 5, 'grande', 'proteção mágica', 'ouro', '2025-06-06'),
(2, 1, 'pequena', 'espaço para animais', 'troca de favores', '2025-06-08'),
(3, 2, 'grande', 'segurança reforçada', 'crédito arcano', '2025-06-10'),
(4, 3, 'média', 'iluminação arcana', 'gema mágica', '2025-06-12'),
(5, 4, 'pequena', 'nenhum', 'ouro', '2025-06-14'),
(6, 5, 'grande', 'proteção mágica', 'troca de favores', '2025-06-16'),
(7, 1, 'média', 'espaço para animais', 'crédito arcano', '2025-06-18'),
(8, 2, 'grande', 'segurança reforçada', 'gema mágica', '2025-06-20'),
(9, 3, 'pequena', 'iluminação arcana', 'ouro', '2025-06-22'),
(10, 4, 'média', 'nenhum', 'troca de favores', '2025-06-24');

