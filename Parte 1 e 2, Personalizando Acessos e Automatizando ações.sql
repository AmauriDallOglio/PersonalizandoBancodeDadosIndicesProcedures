use DioBancoDados

--drop table ProjetoDepartamentoGerente
--drop table ProjetoPessoa
--drop table DepartamentoGerente
--drop table DepartamentoLocalidade
--drop table Localidade
--drop table Gerente
--drop table Projeto







CREATE TABLE Localidade
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Nome varchar(300) NOT NULL,
	Inativo bit default 0 NOT NULL
)		
GO
CREATE UNIQUE INDEX IDX_Localidade_UQ  ON Localidade(Id)


INSERT INTO [dbo].Localidade( Nome, Inativo) 
VALUES ('Localidade 1', 0 )
INSERT INTO [dbo].Localidade ( Nome, Inativo) 
VALUES ('Localidade 2', 0 )
INSERT INTO [dbo].Localidade ( Nome, Inativo) 
VALUES ('Localidade 3', 0 )



CREATE TABLE Gerente
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Nome varchar(300) NOT NULL,
	Inativo bit default 0 NOT NULL
)		
GO
CREATE UNIQUE INDEX IDX_Gerente_UQ  ON Gerente(Id)


INSERT INTO [dbo].Gerente ( Nome, Inativo) 
VALUES ('Gerente 1', 0 )
INSERT INTO [dbo].Gerente ( Nome, Inativo) 
VALUES ('Gerente 2', 0 )
INSERT INTO [dbo].Gerente ( Nome, Inativo) 
VALUES ('Gerente 3', 0 )



 
--drop table DepartamentoLocalidade
CREATE TABLE DepartamentoLocalidade
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Id_Departamento uniqueidentifier NOT NULL,
	Id_Localidade uniqueidentifier NOT NULL,
	Id_Pessoa uniqueidentifier NOT NULL, 
)		
GO
ALTER TABLE DepartamentoLocalidade ADD CONSTRAINT FK_DepartamentoLocalidade_Departamento FOREIGN KEY (Id_Departamento) REFERENCES Departamento(Id)
GO
ALTER TABLE DepartamentoLocalidade ADD CONSTRAINT FK_DepartamentoLocalidade_Localidade FOREIGN KEY (Id_Localidade) REFERENCES Localidade(Id)
GO
ALTER TABLE DepartamentoLocalidade ADD CONSTRAINT FK_DepartamentoLocalidade_Pessoa FOREIGN KEY (Id_Pessoa) REFERENCES Pessoa(Id)
GO
CREATE UNIQUE INDEX IDX_DepartamentoLocalidade_UQ  ON DepartamentoLocalidade (Id, Id_Departamento, Id_Localidade, Id_Pessoa)


declare @Departamento		varchar(250) =  (select top 1 id from Departamento)
declare @Localidade		varchar(250) =  (select top 1 id from Localidade)
declare @Pessoa1		varchar(250) =  (select top 1 id from Pessoa)
declare @Pessoa2		varchar(250) =  (select top 1 id from Pessoa where Id not in( @Pessoa1  ))
declare @Pessoa3		varchar(250) =  (select top 1 id from Pessoa where Id not in( @Pessoa1,@Pessoa2   ))
declare @Pessoa4		varchar(250) =  (select top 1 id from Pessoa where Id not in( @Pessoa1,@Pessoa2,@Pessoa3  ))
INSERT INTO [dbo].DepartamentoLocalidade (Id_Departamento, Id_Localidade, Id_Pessoa) 
VALUES ( @Departamento,@Localidade, @Pessoa1)
INSERT INTO [dbo].DepartamentoLocalidade (Id_Departamento, Id_Localidade, Id_Pessoa) 
VALUES ( @Departamento,@Localidade, @Pessoa2)
INSERT INTO [dbo].DepartamentoLocalidade (Id_Departamento, Id_Localidade, Id_Pessoa) 
VALUES ( @Departamento, @Localidade,@Pessoa3)
INSERT INTO [dbo].DepartamentoLocalidade (Id_Departamento, Id_Localidade, Id_Pessoa) 
VALUES ( @Departamento, @Localidade,@Pessoa4)




--Número de empregados por departamento e localidade 

select 
	'Número de empregados por departamento e localidade ' as 'Número de empregados por departamento e localidade ',
	dep.Descricao, loc.Nome, sum(1) as 'Quantidade'
from
	DepartamentoLocalidade dl
	inner join Departamento dep on dep.Id = dl.Id_Departamento
	inner join Localidade loc on loc.Id = dl.Id_Localidade
group by 
	dep.Descricao, loc.Nome






--drop table DepartamentoGerente
CREATE TABLE DepartamentoGerente
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Id_Departamento uniqueidentifier NOT NULL, 
	Id_Gerente uniqueidentifier NOT NULL, 
)		
GO
ALTER TABLE DepartamentoGerente ADD CONSTRAINT FK_DepartamentoGerente_Departamento FOREIGN KEY (Id_Departamento) REFERENCES Departamento(Id)
GO
ALTER TABLE DepartamentoGerente ADD CONSTRAINT FK_DepartamentoGerente_Gerente FOREIGN KEY (Id_Gerente) REFERENCES Gerente(Id)
GO
CREATE UNIQUE INDEX IDX_DepartamentoGerente_UQ  ON DepartamentoGerente (Id_Departamento, Id_Gerente)


declare @Departamento		varchar(250) =  (select top 1 id from Departamento)
declare @Gerente1		varchar(250) =  (select top 1 id from Gerente )
declare @Gerente2		varchar(250) =  (select top 1 id from Gerente where Id not in( @Gerente1 ))
declare @Gerente3		varchar(250) =  (select top 1 id from Gerente where Id not in( @Gerente1,@Gerente2 ))
INSERT INTO [dbo].DepartamentoGerente (Id_Departamento, Id_Gerente) 
VALUES ( @Departamento, @Gerente1)
INSERT INTO [dbo].DepartamentoGerente (Id_Departamento, Id_Gerente) 
VALUES ( @Departamento, @Gerente2)
INSERT INTO [dbo].DepartamentoGerente (Id_Departamento, Id_Gerente) 
VALUES ( @Departamento, @Gerente3)




--Lista de departamentos e seus gerentes
select 
	'Lista de departamentos e seus gerentes' as 'Lista de departamentos e seus gerentes',
	dep.Descricao as 'Departamento', ger.Nome as 'Pessoas'
from
	DepartamentoGerente dg
	inner join Departamento dep on dep.Id = dg.Id_Departamento
	inner join Gerente ger on ger.Id = dg.Id_Gerente





--drop table Projeto
CREATE TABLE Projeto
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Nome varchar(300) NOT NULL,
	Inativo bit default 0 NOT NULL
)		
GO
CREATE UNIQUE INDEX IDX_Projeto_UQ  ON Projeto(Id)


INSERT INTO [dbo].Projeto( Nome, Inativo) 
VALUES ('Projeto 1', 0 )
INSERT INTO [dbo].Projeto ( Nome, Inativo) 
VALUES ('Projeto 2', 0 )
INSERT INTO [dbo].Projeto ( Nome, Inativo) 
VALUES ('Projeto 3', 0 )
INSERT INTO [dbo].Projeto ( Nome, Inativo) 
VALUES ('Projeto 4', 0 )



--drop table ProjetoPessoa
CREATE TABLE ProjetoPessoa
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Id_Projeto uniqueidentifier NOT NULL, 
	Id_Pessoa uniqueidentifier NOT NULL, 
)		
GO
ALTER TABLE ProjetoPessoa ADD CONSTRAINT FK_ProjetoPessoa_Projeto FOREIGN KEY (Id_Projeto) REFERENCES Projeto(Id)
GO
ALTER TABLE ProjetoPessoa ADD CONSTRAINT FK_ProjetoPessoa_Pessoa FOREIGN KEY (Id_Pessoa) REFERENCES Pessoa(Id)
GO
CREATE UNIQUE INDEX IDX_ProjetoPessoa_UQ  ON ProjetoPessoa (Id_Projeto, Id_Pessoa)


declare @Id_Projeto		varchar(250) =  (select top 1 id from Projeto)
declare @Pessoa1		varchar(250) =  (select top 1 id from Pessoa )
declare @Pessoa2		varchar(250) =  (select top 1 id from Pessoa where Id not in( @Pessoa1 ))
declare @Pessoa3		varchar(250) =  (select top 1 id from Pessoa where Id not in( @Pessoa1,@Pessoa2 ))
INSERT INTO [dbo].ProjetoPessoa (Id_Projeto, Id_Pessoa) 
VALUES ( @Id_Projeto, @Pessoa1)
INSERT INTO [dbo].ProjetoPessoa (Id_Projeto, Id_Pessoa) 
VALUES ( @Id_Projeto, @Pessoa2)
INSERT INTO [dbo].ProjetoPessoa (Id_Projeto, Id_Pessoa) 
VALUES ( @Id_Projeto, @Pessoa3)




--Projetos com maior número de empregados (ex: por ordenação desc) 
select 
	'Projetos com maior número de empregados (ex: por ordenação desc)' as 'Projetos com maior número de empregados (ex: por ordenação desc)',
	pro.Nome as 'Departamento', sum(1) 'QuantidadePessoa'
from
	ProjetoPessoa dg
	inner join Projeto pro on pro.Id = dg.Id_Projeto
	inner join Pessoa pes on pes.Id = dg.Id_Pessoa
group by 
	pro.Nome







--Lista de projetos, departamentos e gerentes 
--drop table ProjetoDepartamentoGerente
CREATE TABLE ProjetoDepartamentoGerente
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Id_Departamento uniqueidentifier NOT NULL, 
	Id_Projeto uniqueidentifier NOT NULL, 
	Id_Gerente uniqueidentifier NOT NULL, 
)		
GO
ALTER TABLE ProjetoDepartamentoGerente ADD CONSTRAINT FK_ProjetoDepartamentoGerente_Departamento FOREIGN KEY (Id_Departamento) REFERENCES Departamento(Id)
GO
ALTER TABLE ProjetoDepartamentoGerente ADD CONSTRAINT FK_ProjetoDepartamentoGerente_Projeto FOREIGN KEY (Id_Projeto) REFERENCES Projeto(Id)
GO
ALTER TABLE ProjetoDepartamentoGerente ADD CONSTRAINT FK_ProjetoDepartamentoGerente_Gerente FOREIGN KEY (Id_Gerente) REFERENCES Gerente(Id)
GO
CREATE UNIQUE INDEX IDX_ProjetoDepartamentoGerente_UQ  ON ProjetoDepartamentoGerente (Id_Departamento, Id_Projeto, Id_Gerente)


declare @Departamento	varchar(250) =  (select top 1 id from Departamento)
declare @Projeto1		varchar(250) =  (select top 1 id from Projeto)
declare @Projeto2		varchar(250) =  (select top 1 id from Projeto where Id not in( @Projeto1 ))
declare @Projeto3		varchar(250) =  (select top 1 id from Projeto where Id not in( @Projeto1, @Projeto2 ))
declare @Gerente		varchar(250) =  (select top 1 id from Gerente)
INSERT INTO [dbo].ProjetoDepartamentoGerente (Id_Departamento, Id_Gerente, Id_Projeto) 
VALUES ( @Departamento, @Gerente, @Projeto1)
INSERT INTO [dbo].ProjetoDepartamentoGerente (Id_Departamento, Id_Gerente, Id_Projeto) 
VALUES ( @Departamento, @Gerente, @Projeto2)
INSERT INTO [dbo].ProjetoDepartamentoGerente (Id_Departamento, Id_Gerente, Id_Projeto) 
VALUES ( @Departamento, @Gerente , @Projeto3)





--drop table Historico
CREATE TABLE Historico
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Modo varchar(15) not null,
	NomeTabela varchar(300) NOT NULL,
	IdRegistro UNIQUEIDENTIFIER null,
	DataCadastro datetime default GETDATE() NOT NULL
)		
GO
CREATE UNIQUE INDEX IDX_Historico_UQ  ON Historico(Id)



--  drop trigger TR_HistoricoProjetoInsert
CREATE TRIGGER TR_HistoricoProjetoInsert
ON Projeto
for INSERT
AS
BEGIN
	INSERT INTO Historico(Modo, NomeTabela, IdRegistro, DataCadastro)
    SELECT 'Insert', 'Projeto', i.Id, GETDATE()
    FROM inserted i;
END;





