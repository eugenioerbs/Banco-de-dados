-- identificando os dados do seu cep
EXPLAIN
SELECT lg.tp_logradouro, lg.nm_logradouro, lg.cd_logradouro, lg.cd_bairro_inicio, lg.cd_localidade, lg.sg_uf, lg.nr_cep
FROM logradouro lg
JOIN bairro b ON b.cd_bairro = lg.cd_bairro_inicio
JOIN localidade l ON l.cd_localidade = lg.cd_localidade
WHERE lg.sg_uf = 'SC';
-- WHERE lg.nr_cep = '89037585';

CREATE INDEX logradouro_cd_bairro_idx ON logradouro(cd_bairro_inicio);
CREATE INDEX logradouro_cd_localidade_idx ON logradouro(cd_localidade);
CREATE INDEX logradouro_nr_cep_idx ON logradouro(nr_cep);

CREATE INDEX logradouro_sg_uf_idx ON logradouro(sg_uf);

-- eliminando um índice
DROP INDEX logradouro_sg_uf_idx ON logradouro;

SHOW INDEXES FROM logradouro;

DESC grande_usuario;

EXPLAIN 
SELECT gu.nm_grande_usuario, lg.nm_logradouro_comp, ba.nm_bairro, lo.nm_localidade, gu.sg_uf
FROM grande_usuario gu
JOIN localidade lo ON lo.cd_localidade = gu.cd_localidade
JOIN bairro ba ON ba.cd_bairro = gu.cd_bairro 
JOIN logradouro lg ON lg.cd_logradouro = gu.cd_logradouro
WHERE lo.nm_localidade = 'blumenau';

-- plano de execução e estudar sobre explorar ao máximo essa base de dados com criação de indexes e como eles funcionam
