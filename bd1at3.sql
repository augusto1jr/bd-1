CREATE DATABASE biblioteca
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;
 
-- DROP DATABASE biblioteca;--
 
USE biblioteca;
 
-- ############ 0. CRIAÇÃO DAS TABELAS ############ --
 
CREATE TABLE usuario(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20),
    telefone VARCHAR(20),
    endereco VARCHAR(20)
)DEFAULT CHARACTER SET utf8mb4;
 
CREATE TABLE autor(
	id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20)
)DEFAULT CHARACTER SET utf8mb4;
 
CREATE TABLE editora(
	id_editora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20)
)DEFAULT CHARACTER SET utf8mb4;
 
CREATE TABLE livro(
	id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(20),
    genero VARCHAR(20),
    ano DATE
)DEFAULT CHARACTER SET utf8mb4;
 
CREATE TABLE reserva(
	id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT, CONSTRAINT fk_usuario 
		FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
	id_livro INT, CONSTRAINT fk_livro 
		FOREIGN KEY (id_livro) REFERENCES livro(id_livro),
	data_reserva DATE,
    data_retirada DATE
)DEFAULT CHARACTER SET utf8mb4;
 
CREATE TABLE emprestimo(
	id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT, CONSTRAINT fk_usuario 
		FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
	id_livro INT, CONSTRAINT fk_livro 
		FOREIGN KEY (id_livro) REFERENCES livro(id_livro),
	data_empréstimo DATE,
    data_devolucao DATE
)DEFAULT CHARACTER SET utf8mb4;
