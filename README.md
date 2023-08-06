# PersonalizandoBancodeDadosIndicesProcedures


Parte 1 – Criando índices em Banco de Dados 

Criação de índices para consultas para o cenário de company com as perguntas (queries sql) para recuperação de informações. Sendo assim, dentro do script será criado os índices com base na consulta SQL.  

O que será levado em consideração para criação dos índices? 

Quais os dados mais acessados 

Quais os dados mais relevantes no contexto 

Lembre-se da função do índice... ele impacta diretamente na velocidade da buca pelas informações no SGBD. Crie apenas aqueles que são importantes. Sendo assim, adicione um README dentro do repositório do Github explicando os motivos que o levaram a criar tais índices. Para que outras pessoas possam se espelhar em seu trabalho, crie uma breve descrição do projeto. 

 

A criação do índice pode ser criada via ALTER TABLE ou CREATE Statement, como segue o exemplo: 

ALTER TABLE customer ADD UNIQUE index_email(email); 

CREATE INDEX index_ativo_hash ON exemplo(ativo) USING HASH; 

 

Perguntas:  

Qual o departamento com maior número de pessoas? 

Quais são os departamentos por cidade? 

Relação de empregrados por departamento 

 

Entregável: 

Crie as queries para responder essas perguntas 

Crie o índice para cada tabela envolvida (de acordo com a necessidade) 

Tipo de indice utilizado e motivo da escolha (via comentário no script ou readme) 

 

Parte 2 - Utilização de procedures para manipulação de dados em Banco de Dados 

Objetivo:  

Criar uma procedure que possua as instruções de inserção, remoção e atualização de dados no banco de dados. As instruções devem estar dentro de estruturas condicionais (como CASE ou IF).  

Além das variáveis de recebimento das informações, a procedure deverá possuir uma variável de controle. Essa variável de controle irá determinar a ação a ser executada. Ex: opção 1 – select, 2 – update, 3 – delete. 

 

Sendo assim, altere a procedure abaixo para receber as informações supracitadas. 

 

Entregável: 

Script SQL com a procedure criada e chamada para manipular os dados de universidade e e-commerce. Podem ser criados dois arquivos distintos, assim como a utilização do mesmo script para criação das procedures. Fique atento para selecionar o banco de dados antes da criação da procedure.  

 

E agora... Finalizou seu desafio ? 

Adicione o link do github com o projeto e submeta para avaliação.





---------------------------------------------------------------------


Parte 1 – Personalizando acessos com views 

Neste desafio você irá criar visões para os seguintes cenários 

Número de empregados por departamento e localidade 

Lista de departamentos e seus gerentes 

Projetos com maior número de empregados (ex: por ordenação desc) 

Lista de projetos, departamentos e gerentes 

Quais empregados possuem dependentes e se são gerentes 

 

Além disso, serão definidas as permissões de acesso as views de acordo com o tipo de conta de usuários. Lembre-se que as views ficam armazaneadas no banco de dados como uma “tabela”. Assim podemos definir permissão de acesso a este item do banco de dados.  

 

Você poderá criar um usuário gerente que terá acesso as informações de employee e departamento. Contudo, employee não terá acesso as informações relacionadas aos departamentos ou gerentes. 

Um exemplo retirado da aula para criação de usuário e definição de permissão pode ser encontrado abaixo. 

CODE 1:

Obs: O tema de permissão de usuários foi apresentada no curso Explorando Cláusulas de DDL e Esquemas de Banco de Dados no MySQL. 

  

Parte 2 – Criando gatilhos para cenário de e-commerce 

Objetivo: 

Sabemos que a criação de triggers está associadas a ações que podem ser tomadas em momento anterior ou posterior a inserção, ou atualização dos dados. Além disso, em casos de remoção podemos utilizar as triggers. Sendo assim, crie as seguintes triggers para o cenário de e-commerce. 

 

Exemplo de trigger para base.

CODE 2:

Entregável: 

Triggers de remoção: before delete 

Triggers de atualização: before update 

 

Remoção:  

Usuários podem excluir suas contas por algum motivo. Dessa forma, para não perder as informações sobre estes usuários, crie um gatilho before remove 

CODE 3:

Atualização:  

Inserção de novos colaboradores e atualização do salário base. 

CODE 4:

E agora... Finalizou seu desafio ? 

Adicione o link do github com o projeto e submeta para avaliação. 
