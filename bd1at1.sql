CREATE DATABASE loja
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;

-- DROP DATABASE loja;--

USE loja;

-- ############ 1. CRIAÇÃO DAS TABELAS ############ --

CREATE TABLE produtos(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    categoria VARCHAR(50),
    preco DECIMAL(10,2),
    estoque INT
)DEFAULT CHARACTER SET utf8mb4;

DESCRIBE produtos;

CREATE TABLE clientes(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    email VARCHAR(50),
    telefone VARCHAR(16)
)DEFAULT CHARACTER SET utf8mb4;

DESCRIBE clientes;

CREATE TABLE vendas(
	id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT, CONSTRAINT fk_produto 
		FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    id_cliente INT, CONSTRAINT fk_cliente 
		FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    quantidade INT,
    data_venda DATE
);

DESCRIBE vendas;


-- ############ 2. INSERÇÃO DE DADOS ############ --

INSERT INTO produtos(nome, categoria, preco, estoque) VALUES 
('Whey Protein', 'Suplementação', 100, 10),
('Creatina', 'Suplementação', 80, 15),
('Pré-Treino', 'Suplementação', 100, 5),
('Camisa Regata', 'Vestuário', 50, 10),
('Camisa Dri-fit', 'Vestuário', 70, 10),
('Camisa Oversized', 'Vestuário', 90, 5);

SELECT * FROM produtos;

INSERT INTO clientes(nome, email, telefone) VALUES
('Cariani', 'heisenberg@gmail.com', '1111-1111'),
('Balestrin', 'balesgreen@gmail.com', '2222-2222'),
('Ramon Dino', 'dinoacre@hotmail.com', '3333-3333'),
('Leo Stronda', 'fabricademonstros@contato', '4444-4444'),
('Paulo Muzy', 'drmuzy@gmail.com', '5555-5555');

SELECT * FROM clientes;

INSERT INTO vendas(id_produto, id_cliente, quantidade, data_venda) VALUES
(1, 3, 4, '2024-09-18'),
(2, 1, 5, '2024-01-10'),
(3, 4, 2, '2024-06-27'),
(4, 5, 3, '2024-05-09'),
(6, 2, 1, '2024-11-25'),
(1, 1, 1, '2024-07-19'),
(2, 3, 2, '2024-09-18'),
(3, 2, 1, '2024-02-13'),
(4, 4, 2, '2024-12-24'),
(5, 5, 3, '2024-09-18');

SELECT * FROM vendas;

-- ############ 3. ATUALIZAÇÃO DE DADOS ############ --

UPDATE produtos SET preco = 110 WHERE id_produto = 1; -- Muda o preço do Whey para 110
UPDATE clientes SET telefone = '0000-0000' WHERE id_cliente = 1; -- Muda o telefone de Cariani para 0000-0000

-- ############ 4. REMOÇÃO DE DADOS ############ --

DELETE FROM produtos WHERE id_produto = 4; -- Remove a Camisa Regata da tabela de produtos
DELETE FROM clientes WHERE id_cliente = 1; -- Remove Cariani da tabela de clientes

-- ############ 5. CONSULTAS ############ --

-- A. CONSULTA COM WHERE
SELECT * FROM produtos WHERE categoria = 'Suplementação';
SELECT * FROM vendas WHERE data_venda = '2024-09-18';

-- B. CONSULTA COM GROUP BY
SELECT id_produto, SUM(quantidade) AS total_vendas FROM vendas GROUP BY id_produto; 

SELECT c.nome, SUM(v.quantidade * p.preco) AS receita_total 
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY c.id_cliente;

-- C. ORDENAÇÃO COM ASC E DESC
SELECT * FROM produtos ORDER BY nome ASC;
SELECT * FROM clientes ORDER BY nome DESC;

-- ############ DESAFIOS ADICIONAIS ############ --

-- ATUALIZAR ESTOQUE
-- É necessário desativar o Safe Mode para executar essa Query:
-- Edit -> Preferences -> SQL Editor -> Other -> Reconnect
UPDATE produtos p
JOIN vendas v ON p.id_produto = v.id_produto
SET p.estoque = p.estoque - v.quantidade
WHERE v.id_venda = id_venda;

-- PRODUTOS MAIS VENDIDOS
-- (Não considera os produtos excluídos, diferente da consulta 5.B.I)
SELECT p.nome, SUM(v.quantidade) AS numero_vendas 
FROM vendas v
JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY v.id_produto
ORDER BY SUM(v.quantidade) DESC;

-- CLIENTES QUE MAIS COMPRARAM
SELECT c.nome, SUM(v.quantidade * p.preco) AS receita_total 
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY c.id_cliente
ORDER BY SUM(v.quantidade * p.preco) DESC;