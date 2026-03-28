/** Para criação da fila índice na coluna "nome do proprietario"
create index nm_proprietario_proprietario_idx on proprietario(nm_proprietario);
**/
/** Para se quiser apagar ela
drop index nm_proprietario_proprietario_idx on proprietario;
**/

-- Se eu pesquisar a proprietária Jéssica sem a coluna do nome indexada, a pesquisa resultatá em 40 rows/linhas lidas, mas se eu eu usar os indexes isso passa a ser 1 row lida.
explain -- se quiser ver a análise do select, junte isso ao select apagando a quebra de linha abaixo

select p.nm_proprietario, v.nr_placa
from veiculo v
join proprietario p on p.cd_proprietario = v.cd_proprietario
where p.nm_proprietario like 'Jessica%';


/**
select *
from proprietario
order by proprietario.nm_proprietario;
**/
