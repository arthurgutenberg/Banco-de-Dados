CREATE DATABASE supermercado;

USE supermercado;
    
    CREATE TABLE categoria(
    idcategoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_criacao DATE
    );
    
    CREATE TABLE cliente(
    idcliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(15),
    endereco TEXT
);

    CREATE TABLE fornecedor(
    idfornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(15)
);

CREATE TABLE produto(
    idproduto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
	id_categoria INT NOT NULL,
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(idcategoria),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(idfornecedor)
);

CREATE TABLE venda(
    idvenda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_venda DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    id_produto INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(idcliente),
    FOREIGN KEY (id_produto) REFERENCES produto(produto)
);