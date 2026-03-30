



CREATE INDEX logradour

SHOW INDEX from logradouro;

CREATE INDEX logradouro_cd_bairro_inicio_idx ON logradouro(cd_bairro_inicio);
CREATE INDEX logradouro_nm_logradouro_idx ON logradouro(nm_logradouro);

CREATE INDEX bairro_nm_bairro_idx ON bairro(nm_bairro);
CREATE INDEX bairro_cd_bairro_idx ON bairro(cd_bairro);





/** a) Listar todos os logradouros/ruas da cidade de "Blumenau", seus respectivos bairros e CEPs, ordenados alfabeticamente pelo nome do bairro, 
seguido pelo nome do logradouro **/

CREATE INDEX logradouro_cd_localidade_idx ON logradouro(cd_localidade);
CREATE INDEX localidade_nm_localidade_idx ON localidade(nm_localidade);

EXPLAIN
SELECT DISTINCT lo.nm_logradouro, b.nm_bairro, lo.nr_cep
FROM logradouro lo
JOIN bairro b ON b.cd_bairro = lo.cd_bairro_inicio
JOIN localidade l ON l.cd_localidade = lo.cd_localidade
WHERE l.nm_localidade LIKE 'Blumenau'
ORDER BY b.nm_bairro, lo.nm_logradouro;



-- b) Listar o nome dos distritos (fl_tipo_localidade= 'D') e do respectivo município que cada distrito está associado. 
-- Considerar como filtro apenas a UF "SC" e ordenar pelo nome do município, seguido do distrito;
CREATE INDEX localidade_nm_localidade_comp_idx ON localidade(nm_localidade_comp);
CREATE INDEX localidade_fl_tipo_localidade_idx ON localidade(fl_tipo_localidade);
CREATE INDEX localidade_sg_uf_idx ON localidade(sg_uf);

EXPLAIN
SELECT l.nm_localidade, dis.nm_localidade_comp
FROM localidade l
JOIN localidade dis ON dis.cd_localidade_sub = l.cd_localidade
WHERE dis.fl_tipo_localidade = 'D'
AND dis.sg_uf = 'SC'
ORDER by l.nm_localidade, dis.nm_localidade_comp;



-- e) Listar qual o número de total de CEPs encontrados em cada município, com respectiva UF, ordenados pelo maior número (de CEPs listados). 
-- Considerar apenas os municípios que possuem mais de um CEP (tabela logradouro);
EXPLAIN
SELECT l.sg_uf, l.nm_localidade, COUNT(*) total_ceps_encontrados
FROM localidade l
JOIN logradouro lo ON lo.cd_localidade = l.cd_localidade
GROUP BY l.cd_localidade, l.sg_uf, l.nm_localidade
HAVING COUNT(*) > 1
ORDER BY total_ceps_encontrados DESC;







