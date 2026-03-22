/**
SELECT count(*) total_veiculos
FROM veiculo v
**/

/**
select v.cd_modelo, m.ds_modelo, count(*) total_veiculos_existentes
from veiculo v
join modelo m on m.cd_modelo = v.cd_modelo
group by v.cd_modelo;
**/

/**
select v.cd_cor, c.ds_cor, count(*) total_veiculos
from veiculo v
join cor c on c.cd_cor = v.cd_cor
group by v.cd_cor;
**/

/**
select ma.ds_marca, count(*) total_veiculos_associados
from veiculo v
join modelo mo on mo.cd_modelo = v.cd_modelo
join marca ma on ma.cd_marca = mo.cd_marca
group by ma.ds_marca;
**/

/**
select p.cd_proprietario, p.nm_proprietario, count(*) quantidade_veiculos_associados
from veiculo v
join proprietario p on p.cd_proprietario = v.cd_proprietario
group by p.cd_proprietario
order by p.nm_proprietario;
**/

/**
select l.cd_localidade, l.nm_localidade, count(*) quantidade_veiculos_associados
from veiculo v
join proprietario p on p.cd_proprietario = v.cd_proprietario
join localidade l on l.cd_localidade = p.cd_localidade
group by l.cd_localidade
order by quantidade_veiculos_associados desc;
**/

/**
select m.ds_modelo, sum(v.qt_km_rodado) quilometragem_total
from veiculo v
join modelo m on m.cd_modelo = v.cd_modelo
group by m.ds_modelo
order by quilometragem_total;
**/

/**
select m.ds_modelo, avg(v.qt_km_rodado) as media_quilometragem_rodada
from veiculo v
join modelo m on m.cd_modelo = v.cd_modelo
group by m.ds_modelo
order by media_quilometragem_rodada;
**/

/**
select m.ds_modelo, max(v.qt_km_rodado) as maior_kilometragem_rodada, min(v.qt_km_rodado) as menor_kilometragem_rodada
from veiculo v
join modelo m on m.cd_modelo = v.cd_modelo
group by m.ds_modelo;
**/




