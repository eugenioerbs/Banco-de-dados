CREATE TABLE pessoa2 -- criei uma tabela a partir de um select
AS
SELECT  CONCAT(p.id, ' - ',p.nome,' - ', p.email, ' - ',p.empresa, ' - ',p.departamento, ' - ',p.cor, ' - ',p.marca_automovel, ' - ',p.alimentos)
AS dados -- este concat vai juntar/concatenar todos os dados em um literal
FROM pessoa p;

-- alterando o tipo da tabela
ALTER TABLE pessoa2 ENGINE=MYISAM;

-- ver os indices
SHOW INDEX FROM pessoa2;

-- criando índice pra coluninha
CREATE INDEX pessoa2_dados_idx ON pessoa2(dados);

EXPLAIN
SELECT *
FROM pessoa2 p2
WHERE p2.dados LIKE '%%';


EXPLAIN
SELECT p.cor
FROM pessoa p
WHERE p.cor LIKE 'azul';


-- FULLTEXT INDEX
CREATE FULLTEXT INDEX pessoa2_dados_idx_full ON pessoa2(dados);

-- pesquisand utilizando o index fulltext, pesquisando textos
EXPLAIN  
SELECT *
FROM pessoa2 p2
WHERE MATCH (p2.dados) AGAINST ('microsoft sopas lexus');

-- usando boolean mode - bem mais específico, deve serguir todas as regras do select
-- + tenham obrigatóriamente, - de modo nenhum podem ter, lex* busca qualquer palavra que tenha lex no início, sem nenhum sinal pode ou nao conter essa palavra
EXPLAIN
SELECT *
FROM pessoa2 p2
WHERE MATCH(p2.dados) AGAINST ('microsoft +azul -sopas +lex*' IN BOOLEAN MODE);

