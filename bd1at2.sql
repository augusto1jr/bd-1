CREATE DATABASE supermercado
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;

-- DROP DATABASE supermercado;--

USE supermercado;

-- ############ 0. CRIAÇÃO DAS TABELAS ############ --

CREATE TABLE vendas(
	id_venda INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(20),
    categoria VARCHAR(20),
    quantidade INT,
    preco_unidade DECIMAL(10,2),
    data_venda DATE
)DEFAULT CHARACTER SET utf8mb4;

DESCRIBE vendas;

INSERT INTO vendas(produto, categoria, quantidade, preco_unidade, data_venda) VALUES
('Arroz', 'Alimentos', 5, 10.00, '2024-09-01'),
('Feijão', 'Alimentos', 3, 7.50, '2024-09-02'),
('Sabão', 'Limpeza', 2, 12.00, '2024-09-02'),
('Café', 'Alimentos', 6, 8.00, '2024-09-03'),
('Detergente', 'Limpeza', 4, 5.00, '2024-09-03'),
('Leite', 'Alimentos', 10, 4.50, '2024-09-04'),
('Sabonete', 'Higiene', 6, 3.00, '2024-09-04'),
('Pão', 'Alimentos', 15, 1.50, '2024-09-05'),
('Shampoo', 'Higiene', 1, 15.00, '2024-09-05'),
('Creme dental', 'Higiene', 3, 8.00, '2024-09-06');

SELECT * FROM vendas;

-- ############ 1. Use a função COUNT para contar o 
-- número de vendas em diferentes categorias de produtos

-- a. Número de vendas na categoria "Alimentos"?
SELECT COUNT(*) AS vendas_alimentos
FROM vendas
WHERE categoria = 'Alimentos';

-- b. Quantas vendas foram realizadas no total?
SELECT COUNT(*) AS total_vendas
FROM vendas;

-- 2. Use a função AVG para calcular a 
-- média dos preços e a quantidade de vendas

-- a. Qual é o preço médio por unidade dos produtos vendidos?
SELECT ROUND(AVG(preco_unidade),2) AS preco_medio
FROM vendas;

-- b. Qual é a quantidade média de produtos vendidos por venda?
SELECT ROUND(AVG(quantidade), 1) AS media
FROM vendas;

-- 3. Use as funções MIN e MAX para encontrar o 
-- menor e o maior valor de preços e quantidades

-- a. Qual foi o menor preço por unidade vendido?
SELECT MIN(preco_unidade) AS menor_preco
FROM vendas;

-- b. Qual foi o maior preço por unidade vendido?
SELECT MAX(preco_unidade) AS maior_preco
FROM vendas;

-- c. Qual foi a menor e a maior quantidade de produtos vendidos em uma venda?
-- menor
SELECT MIN(quantidade) AS menor_quantidade
FROM vendas;

-- maior
SELECT MAX(quantidade) AS maior_quantidade
FROM vendas;

-- 4. Combine as funções agregadores para responder:

-- a. Qual foi o maior valor total de uma venda?
SELECT MAX(quantidade * preco_unidade) AS maior_valor
FROM vendas;

-- b. Qual é a média de valor das vendas realizadas na categoria "Higiene"?
SELECT ROUND(AVG(quantidade * preco_unidade),2) AS media_valor
FROM vendas
WHERE categoria = 'Higiene';
