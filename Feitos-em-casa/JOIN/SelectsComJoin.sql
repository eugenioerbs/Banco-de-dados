
/**
select v.nr_placa, m.ds_modelo
from veiculo v, modelo m
where v.cd_modelo = m.cd_modelo
order by nr_placa;

-- versão moderna join
SELECT v.nr_placa, m.ds_modelo
FROM veiculo v
JOIN modelo m ON m.cd_modelo = v.cd_modelo
order by v.nr_placa;
**/


/**
select ve.nr_placa, mo.ds_modelo, ma.ds_marca
from veiculo ve
join modelo mo on ve.cd_modelo = mo.cd_modelo
join marca ma
order by ma.ds_marca;
**/

/**
select v.nr_placa, p.nm_proprietario
from veiculo v
join proprietario p on p.cd_proprietario = v.cd_proprietario
order by p.nm_proprietario;
**/

/**
select v.nr_placa, p.nm_proprietario, l.nm_localidade
from veiculo v
join proprietario p on p.cd_proprietario = v.cd_proprietario 
join localidade l on l.cd_localidade = p.cd_localidade
order by l.nm_localidade;
**/

/**
select v.nr_placa, c.ds_combustivel
from veiculo v
join veiculo_combustivel vc on vc.nr_placa = v.nr_placa
join combustivel c on c.cd_combustivel = vc.cd_combustivel
order by v.nr_placa, c.ds_combustivel;
**/

/**
select p.nm_proprietario, v.nr_placa, m.ds_modelo, ma.ds_marca, l.nm_localidade
from veiculo v
join  modelo m on m.cd_modelo = v.cd_modelo
join marca ma on ma.cd_marca = m.cd_marca
join proprietario p on p.cd_proprietario = v.cd_proprietario
join localidade l on l.cd_localidade = p.cd_localidade
order by p.nm_proprietario;
**/

/**
SELECT v.nr_placa, m.ds_modelo, ma.ds_marca, a.ds_acessorio
FROM veiculo v
join modelo m on m.cd_modelo = v.cd_modelo
join marca ma on ma.cd_marca = m.cd_marca
join veiculo_acessorio va on va.nr_placa = v.nr_placa
join acessorio a on a.cd_acessorio = va.cd_acessorio
order by v.nr_placa, a.ds_acessorio;
**/