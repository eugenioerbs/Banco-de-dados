
CREATE INDEX cd_localidade_logradouro_idx ON logradouro(cd_localidade);
CREATE INDEX nm_localidade_localidade_idx ON localidade(nm_localidade);
/** -- para dropar as indexes das colunas

DROP INDEX cd_localidade_logradouro_idx ON logradouro;
DROP INDEX nm_localidade_localidade_idx ON localidade;
**/


-- Para mostrar todos os bairros da localidade blumenau
explain
SELECT DISTINCT b.nm_bairro, l.nm_localidade
FROM localidade l
JOIN logradouro lo ON lo.cd_localidade = l.cd_localidade
JOIN bairro b ON b.cd_bairro = lo.cd_bairro_inicio
WHERE l.nm_localidade = 'Blumenau'
ORDER BY b.nm_bairro;

-- Todas as cidades com nome de Indaial
explain
SELECT *
FROM localidade l
WHERE l.nm_localidade = 'Blumenau';


-- listar todas as ruas (logradouros) da cidade cujo ID é 500
explain
SELECT DISTINCT lo.nm_logradouro, lo.cd_localidade
FROM logradouro lo
WHERE lo.cd_localidade = 8377
ORDER BY lo.nm_logradouro;

SELECT *
FROM localidade
WHERE nm_localidade = 'Blumenau';




