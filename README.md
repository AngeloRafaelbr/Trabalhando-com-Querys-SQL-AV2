
RESUMO / ETAPAS DOS DESAFIOS:


#1º
- Primeiro foi fornecido o arquivo “back.sql” que nada mais é que o arquivo DUMP do BD de um restaurante;

#2º
- Deste arquivo, foi separado uma parte para criação das TABLES, criando-se o arquivo “Criação Schema tabelas.sql”;

#3º
- Além disso, foi separado uma parte de inserção dos valores nas TABLES, criando-se o arquivo “inserts.sql”;

#OBS> 
Outra maneira poderia ter sido seguida. Além do arquivo DUMP, foi disponibilizado 6 arquivos .csv, referentes a 06 tabelas que compõem o banco. Pode-se importá-las através de recursos da ferramenta  MYSQL Workbench, porém não foi o caminho escolhido;

#4º
- Como forma de validação da inserção, foi criado arquivo de contagem de linhas, para conferência dos valores totais inseridos, visto que foi uma informação passada, ou seja, torna-se possível a conferência para saber se a importação ocorreu sem intercorrências. Para isso, foi usado o arquivo “row_counts.sql”;

#5º
- Foi disponibilizado script SQL com diversas perguntas já respondidas, porém, havendo 03 perguntas como desafio de execução (apresentadas mais à frente). 

#6º
- Em outro momento, foi disponibilizado 02 arquivos .CSV, que se referem a 02 tabelas a serem inseridas no mesmo DB já utilizado.

#7º
- Após a segunda parte de importação, foi apresentado mais duas perguntas como desafios, dessa vez envolvendo as tabelas da primeira parte da importação, com as tabelas da segunda parte de importação.

#8º
- Ao final, como resumo, foi disponibilizado o seguinte documento (arquivo “trabalho.md”):


“ # 1. Proponha um modelo em estrela ou floco de neve com o fato pedido, as seguintes métricas serão obrigatórias- valor total do pedido, valor unitario do prato e quantidade. As dimensões obrigatórias serão, cliente, ano mes e dia.


# 2. Entregar as queries que respondam:

# Qual o cliente que mais fez pedidos por ano
# Qual o cliente que mais gastou em todos os anos
# Qual(is) o(s) cliente(s) que trouxe(ram) mais pessoas por ano

# Qual a empresa que tem mais funcionarios como clientes do restaurante;
# Qual empresa que tem mais funcionarios que consomem sobremesas no restaurante por ano;

- Entregar todos os scripts fisicos atraves de um repositorio git seu que será cadastrado até a segunda-feira 10/06. ”
