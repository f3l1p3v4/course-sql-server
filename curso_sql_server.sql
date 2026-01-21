RETURN;

create table LivroAutor(
IdLivro smallint not null,
IdAutor smallint not null,
constraint fk_id_livros foreign key(IdLivro) references Livro(IdLivro),
constraint fk_id_autores foreign key(IdAutor) references Autor(IdAutor),
constraint pk_livro_autor primary key(IdLivro, IdAutor)
)

-- VERIFICA INFORMAÇÕES DETALHADAS DE UMA TABELA
sp_help Livro

-- VERIFICA NOMES DAS TABELAS DE UM BANCO E NA ORDEM DE CRIAÇÃO	
select name from Biblioteca.sys.tables;

-- ADICIONAR UMA NOVA COLUNA A UMA TABELA EXISTENTE
ALTER TABLE Livro
ADD Edicao SMALLINT;

-- ALTERAR O TIPO DE DADOS DE UMA COLUNA
ALTER TABLE Livro
ALTER COLUMN Edicao TINYINT

-- ADICIONAR CHAVE PRIMARIA (CASO TENHA ESQUECIDO DE ADCIONAR NA CRIACAO DE UMA TABELA)
ALTER TABLE Livro
ADD PRIMARY KEY (ISBN13);

-- EXCLUIR UMA CONSTRAINT DE UMA COLUNA
ALTER TABLE NomeTabela
DROP CONSTRAINT NomeConstraint;

-- EXCLUIR UMA COLUNA DE UMA TABELA
ALTER TABLE Livro
DROP COLUMN Edicao;

-- EXCLUIR UMA TABELA 
DROP TABLE NomeTabela;

-- RENOMEAR UMA TABELA
-- sp_rename 'nome atual', 'novo nome';

INSERT INTO Assunto (NomeAssunto)
VALUES
('Ficção Cientpifica'), ('Botânica'),
('Eletrônica'), ('Matemática'),
('Aventura'), ('Romance'),
('Finanças'), ('Gastronomia'),
('Terror'), ('Administração'),
('Informática'), ('Suspense');

update Assunto set NomeAssunto = 'Ficção Científica' where idAssunto = 1

SELECT * FROM Assunto

INSERT INTO Editora (NomeEditora)
VALUES 
('Pretice Hall'), ('O´Reilly');

SELECT * FROM Editora


INSERT INTO Autor (NomeAutor, SobrenomeAutor)
VALUES
('Umberto', 'Eco');

SELECT * FROM Autor

INSERT INTO Livro (NomeLivro, ISBN13, DataPub, PrecoLivro, NumeroPaginas, IdAssunto, IdEditora)
VALUES
('A Arte da Eletrônica', '9788582604342', '20170308', 300.74, 1160, 1, 1)

SELECT * FROM Livro

INSERT INTO LivroAutor(IdLivro, IdAutor)
VALUES
(100, 1)

SELECT * FROM LivroAutor

-- INNER JOIN
SELECT NomeLivro, NomeAutor, SobrenomeAutor 
FROM Livro
INNER JOIN LivroAutor
	ON Livro.IdLivro = LivroAutor.IdLivro
INNER JOIN Autor
	ON Autor.IdAutor = LivroAutor.IdAutor
ORDER BY NomeLivro;

-- CONSULTAS SIMPLES COM SELECT

/*
Sintaxe:
SELECT coluna(s) FROM tabela;
*/

SELECT IdEditora FROM Livro

SELECT * FROM Livro;

-- O COMANDO DISTINCT SERVE PARA ELIMINAR DUPLICATAS NOS RESULTADOS DE UMA CONSULTA
SELECT DISTINCT IdEditora FROM Livro

-- SELECT INTO:CRIAR UMA TABELA COM DADOS DE OUTRA

/*
SELECT coluna(s)
INTO nova_tabela
FROM tabela_atual;
*/

SELECT NomeLivro, ISBN13
INTO LivroISBN
FROM Livro;

SELECT NomeLivro, ISBN13
INTO LivroISBN
FROM Livro
WHERE IdEditora = 1;

SELECT * FROM LivroISBN;

-- COMANDO PARA APAGAR TABELA
DROP TABLE LivroISBN;

-- ORDENAÇÃO DE RESULTADOS COM CONSULTAS SQL:
-- CLÁUSULA ORDER BY

/* Sintaxe
SELECT coluna
FROM tabela
ORDER BY coluna_a_ordenar [ASC = padrao | DESC]
*/

-- Exemplos
SELECT NomeLivro
FROM Livro
ORDER BY NomeLivro

SELECT NomeLivro, IdEditora
FROM Livro
ORDER BY IdEditora


SELECT NomeLivro, PrecoLivro
FROM Livro
ORDER BY PrecoLivro DESC

SELECT NomeLivro, PrecoLivro, IdEditora
FROM Livro
ORDER BY IdEditora, PrecoLivro ASC

SELECT NomeLivro, PrecoLivro, IdEditora
FROM Livro
ORDER BY IdEditora ASC, PrecoLivro DESC


-- RESTRIÇÃO DE RESULTADOS: SELECT TOP
/* Sintaxe
SELECT TOP (número|PERCENT) colunas
FROM tabela
ORDER BY
*/

-- Exemplos
SELECT TOP (2) NomeLivro
FROM Livro
ORDER BY NomeLivro


-- Exemplos
SELECT TOP (2) NomeLivro
FROM Livro
ORDER BY NomeLivro


SELECT TOP (15) PERCENT NomeLivro
FROM Livro
ORDER BY NomeLivro


-- WITH TIES
SELECT TOP (3) WITH TIES NomeLivro, IdAssunto
FROM Livro
ORDER BY IdAssunto DESC;

-- CLÁUSULA WHERE: SUBCONSULTAS
SELECT NomeLivro, DataPub
FROM Livro
WHERE IdEditora = (
		SELECT IdEditora
		FROM Editora
		WHERE NomeEditora = 'Aleph'
)
ORDER BY NomeLivro

-- VERIFICAR O VALOR ATUAL DE IDENTY
SELECT IDENT_CURRENT('Teste');

-- AUMENTAR 10% NO VALOR DO LIVRO
UPDATE Livro
SET PrecoLivro = PrecoLivro * 1.1
WHERE IdLivro = 105;

-- DIMINUIR 20% NO VALOR DO LIVRO
UPDATE Livro
SET PrecoLivro = PrecoLivro * 0.8
WHERE IdLivro = 105


/*
COMBINAR CONSULTAS COM O OPERADOR UNION

SINTAXE:

SELECT colunas
FROM tabela1
UNION
SELECT colunas FROM tabela2... 
*/

-- EXEMPLO 01
SELECT NomeAutor Nome, 'Autor' AS Tipo FROM Autor
UNION
SELECT NomeEditora Nome, 'Editora' AS Tipo FROM Editora;

-- EXEMPLO 02
SELECT NomeLivro AS Nome, 'Livro' AS Tipo FROM Livro
UNION
SELECT NomeAssunto AS Nome, 'Assunto' AS Tipo FROM Assunto;

-- EXEMPLO 03
SELECT NomeAutor AS Nome, 'Autor' AS Tipo FROM Autor
UNION
SELECT NomeEditora AS Nome, 'Editora' AS Tipo FROM Editora
UNION
SELECT NomeAssunto AS Nome, 'Assunto' AS Tipo FROM Assunto
UNION
SELECT NomeLivro AS Nome, 'Livro' AS Tipo FROM Livro;


-- FUNÇÕES DE AGREGAÇÃO
/*
MIN, MAX, AVG, SUM, COUNT
*/

SELECT COUNT(*) 'Total Linhas'
FROM Autor;

SELECT MAX(PrecoLivro) 'Mais Caro'
FROM Livro;

SELECT MIN(NumeroPaginas) 'Menor nº Páginas'
FROM Livro;

SELECT AVG(PrecoLivro) 'Preço Médio'
FROM Livro;

SELECT SUM(PrecoLivro) 'Valor Total'
FROM Livro;

SELECT AVG(PrecoLivro) 'Preço Médio'
FROM Livro;

SELECT COUNT(*) 'Total Linhas do assunto = 1'
FROM Livro
WHERE IdAssunto = 1;

SELECT AVG(PrecoLivro) 'Preço Médio'
FROM Livro;

-- MESMO RESULTADO DE USAR A FUNÇÃO AVG
SELECT SUM(PrecoLivro) / COUNT(*) AS 'Preço Médio'
FROM Livro;

SELECT NomeLivro, PrecoLivro
FROM Livro
WHERE PrecoLivro = (
		SELECT MAX(PrecoLivro)
		FROM Livro
	 );

