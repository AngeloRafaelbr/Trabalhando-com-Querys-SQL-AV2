####################### D E S A F I O ########################

# 1. Proponha um modelo em estrela ou floco de neve com o fato pedido, as seguintes métricas serão obrigatórias- valor total do pedido, valor unitario do prato e quantidade. As dimensões obrigatórias serão, cliente, ano mes e dia.


# 2. Entregar as queries que respondam:

# Qual o cliente que mais fez pedidos por ano
# Qual o cliente que mais gastou em todos os anos
# Qual(is) o(s) cliente(s) que trouxe(ram) mais pessoas por ano

# Qual a empresa que tem mais funcionarios como clientes do restaurante;
# Qual empresa que tem mais funcionarios que consomem sobremesas no restaurante por ano;

######################### R E S P O S T A S ###########################

use db_restaurante;

# Qual o cliente que mais fez pedidos por ano*DESAFIO 01*

#PRIMEIRO, PARA TESTE DA LÓGICA:
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(tp.quantidade_pedido) as qtd_pedido
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido tp
on tp.codigo_mesa  = ms.codigo_mesa
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 1;

#SEGUNDO, REALIZANDO “UNION” ENTRE OS ANOS:
select * from (
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(tp.quantidade_pedido) as qtd_pedido
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido tp
on tp.codigo_mesa  = ms.codigo_mesa
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 1)
union
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(tp.quantidade_pedido) as qtd_pedido
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido tp
on tp.codigo_mesa  = ms.codigo_mesa
where year(ms.data_hora_entrada) = 2023
group by 1,2
order by 3 desc
limit 1)
union
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(tp.quantidade_pedido) as qtd_pedido
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido tp
on tp.codigo_mesa  = ms.codigo_mesa
where year(ms.data_hora_entrada) = 2024
group by 1,2
order by 3 desc
limit 1)) as
tb_top1_major_consumer_per_order;

# Qual o cliente que mais gastou em todos os anos *DESAFIO 02*

select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(pr.preco_unitario_prato * pd.quantidade_pedido) as valor_total
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
left join tb_pedido pd
on ms.codigo_mesa  = pd.codigo_mesa
left join tb_prato pr
on pd.codigo_prato = pr.codigo_prato
group by 1,2
order by 3 desc
limit 1;

# Qual(is) o(s) cliente(s) que trouxe(ram) mais pessoas por ano *DESAFIO 03*

select * 
from (
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2022
group by 1,2
order by 3 desc
limit 1)
union
(select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2023
group by 1,2
order by 3 desc
limit 1)
union(
select year(ms.data_hora_entrada) as ano, cl.nome_cliente as cliente, sum(ms.num_pessoa_mesa) as qtd_pessoas 
from tb_mesa ms
left join tb_cliente cl
on ms.id_cliente = cl.id_cliente
where year(ms.data_hora_entrada) = 2024
group by 1,2
order by 3 desc
limit 1
)) as
tb_top1_major_consumer_per_year;

#OBS> Antes de qualquer envolvimento com as próximas atividades, foi percebido que os valores de telefone na tabela “tb_cliente” 
#contavam com valores de e-mail e, os valores da coluna de e-mail estavam na coluna de telefone. Segue o realizado:

# 1º - Percebe-se que as colunas email_cliente e telefone_cliente estão trocadas. Para isso:

 CREATE TABLE `tb_email_tel_stage` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `email_cliente` varchar(45) DEFAULT NULL,
  `telefone_cliente` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
);
INSERT INTO `tb_email_tel_stage` (email_cliente, telefone_cliente)
SELECT telefone_cliente, email_cliente
FROM tb_cliente;
;
SELECT * FROM tb_email_tel_stage;

#2º - Com a tabela temporária criada, agora é passar os valores corretos.
UPDATE tb_cliente tc
JOIN tb_email_tel_stage ts ON tc.telefone_cliente = ts.email_cliente
SET tc.email_cliente = ts.email_cliente, 
    tc.telefone_cliente = ts.telefone_cliente;
    
# Qual a empresa que tem mais funcionários como clientes do restaurante *DESAFIO 04*;

select tbe.nome_empresa as nome_empresa, count(tbbn.email_funcionario) as email_funcionario
from tb_empresa tbe
left join tb_beneficio tbbn
on tbe.codigo_empresa = tbbn.codigo_empresa
left join tb_cliente tbc
on tbc.email_cliente = tbbn.email_funcionario
where tbc.email_cliente = tbbn.email_funcionario
GROUP BY 1
ORDER BY 2 DESC
limit 1;

# Qual empresa que tem mais funcionarios que consomem sobremesas no restaurante por ano*DESAFIO 05*;

#PRIMEIRO(Para entender a lógica):
select tbe.nome_empresa as nome_empresa, count(tbbn.email_funcionario) as email_funcionario
from tb_empresa tbe
left join tb_beneficio tbbn
on tbe.codigo_empresa = tbbn.codigo_empresa
left join tb_cliente tbc
on tbc.email_cliente = tbbn.email_funcionario
left join tb_mesa tbms
on tbms.id_cliente = tbc.id_cliente
left join tb_pedido tbpd
on tbpd.codigo_mesa = tbms.codigo_mesa
left join tb_prato tbpt
on tbpt.codigo_prato = tbpd.codigo_prato
left join tb_tipo_prato tbtppt
on tbtppt.codigo_tipo_prato = tbpt.codigo_tipo_prato 
where (tbc.email_cliente = tbbn.email_funcionario) and (tbtppt.codigo_tipo_prato = 3)
GROUP BY 1
ORDER BY 2 DESC;

#SEGUNDO(aplicando a lógica):
select * from (
(select year(tbms.data_hora_entrada) as ano, tbe.nome_empresa as nome_empresa, count(tbbn.email_funcionario) as email_funcionario
from tb_empresa tbe
left join tb_beneficio tbbn
on tbe.codigo_empresa = tbbn.codigo_empresa
left join tb_cliente tbc
on tbc.email_cliente = tbbn.email_funcionario
left join tb_mesa tbms
on tbms.id_cliente = tbc.id_cliente
left join tb_pedido tbpd
on tbpd.codigo_mesa = tbms.codigo_mesa
left join tb_prato tbpt
on tbpt.codigo_prato = tbpd.codigo_prato
left join tb_tipo_prato tbtppt
on tbtppt.codigo_tipo_prato = tbpt.codigo_tipo_prato 
where (tbc.email_cliente = tbbn.email_funcionario) and (tbtppt.codigo_tipo_prato = 3) and (year(tbms.data_hora_entrada) = 2022)
GROUP BY 1, 2  
ORDER BY 3 DESC
limit 1)
union
(select year(tbms.data_hora_entrada), tbe.nome_empresa as nome_empresa, count(tbbn.email_funcionario) as email_funcionario
from tb_empresa tbe
left join tb_beneficio tbbn
on tbe.codigo_empresa = tbbn.codigo_empresa
left join tb_cliente tbc
on tbc.email_cliente = tbbn.email_funcionario
left join tb_mesa tbms
on tbms.id_cliente = tbc.id_cliente
left join tb_pedido tbpd
on tbpd.codigo_mesa = tbms.codigo_mesa
left join tb_prato tbpt
on tbpt.codigo_prato = tbpd.codigo_prato
left join tb_tipo_prato tbtppt
on tbtppt.codigo_tipo_prato = tbpt.codigo_tipo_prato 
where (tbc.email_cliente = tbbn.email_funcionario) and (tbtppt.codigo_tipo_prato = 3) and (year(tbms.data_hora_entrada) = 2023)
GROUP BY 1, 2  
ORDER BY 3 DESC
limit 1)
union
(select year(tbms.data_hora_entrada), tbe.nome_empresa as nome_empresa, count(tbbn.email_funcionario) as email_funcionario
from tb_empresa tbe
left join tb_beneficio tbbn
on tbe.codigo_empresa = tbbn.codigo_empresa
left join tb_cliente tbc
on tbc.email_cliente = tbbn.email_funcionario
left join tb_mesa tbms
on tbms.id_cliente = tbc.id_cliente
left join tb_pedido tbpd
on tbpd.codigo_mesa = tbms.codigo_mesa
left join tb_prato tbpt
on tbpt.codigo_prato = tbpd.codigo_prato
left join tb_tipo_prato tbtppt
on tbtppt.codigo_tipo_prato = tbpt.codigo_tipo_prato 
where (tbc.email_cliente = tbbn.email_funcionario) and (tbtppt.codigo_tipo_prato = 3) and (year(tbms.data_hora_entrada) = 2024)
GROUP BY 1, 2  
ORDER BY 3 DESC
limit 1)) as tb_grandona;
    
    
