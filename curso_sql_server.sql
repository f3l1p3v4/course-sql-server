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
