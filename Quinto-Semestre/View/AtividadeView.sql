-- a) Criação de uma view para listar a marca,
-- o modelo e a quantidade de veículos cadastrados;
create view marca_modelo_qntVeiculos as
select ma.ds_marca, mo.ds_modelo, count(*) as quantidade_veiculos
from veiculo v
join modelo mo on mo.cd_modelo = v.cd_modelo
join marca ma on ma.cd_marca = mo.cd_marca
group by ma.ds_marca, mo.ds_modelo;

-- c) Criação de uma view para listar o nome da localidade 
-- com a respectiva quantidade proprietários associada (que residem na respectiva localidade);

create view localidade_proprietarios as
select l.cd_localidade, l.nm_localidade, count(*) proprietarios_queResidem
from localidade l
join proprietario p on p.cd_localidade = l.cd_localidade
group by l.cd_localidade, l.nm_localidade;

-- d) Criação de uma view para listar o acessório com a respectiva
-- quantidade de veículos associados a cada acessório listado;

create view acessorio_qntVeiculo as
select a.cd_acessorio, a.ds_acessorio, count(*) as veiculos_quePossuem
from veiculo v
join veiculo_acessorio va on va.nr_placa = v.nr_placa
join acessorio a on a.cd_acessorio = va.cd_acessorio
group by a.cd_acessorio
order by veiculos_quePossuem desc;

-- e) Criação de uma view para listar o modelo, 
-- a marca, ano do modelo e a respectiva cor de cada veículo;

create view tudo_sobre_veiculos as
select mo.ds_modelo, ma.ds_marca, v.nr_ano_mod, c.ds_cor
from veiculo v
join modelo mo on mo.cd_modelo = v.cd_modelo
join marca ma on ma.cd_marca = mo.cd_marca
join cor c on c.cd_cor = v.cd_cor
order by v.nr_ano_mod;