 --create database DioBancoDados
 use DioBancoDados

--Qual o departamento com maior número de pessoas? 
--Quais são os departamentos por cidade? 
--Relação de empregrados por departamento 

--drop table DepartamentoPessoa
--drop table DepartamentoCidade
--drop table Ciadade
--drop table Departamento
--drop table Pessoa

--drop table Departamento
CREATE TABLE Departamento
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Descricao varchar(300) NOT NULL,
	Inativo bit default 0 NOT NULL
)		
GO
CREATE UNIQUE INDEX IDX_Departamento_UQ  ON Departamento(Id)


INSERT INTO [dbo].Departamento ( Descricao, Inativo) 
VALUES ('Departamento 1', 0 )
INSERT INTO [dbo].Departamento ( Descricao, Inativo) 
VALUES ('Departamento 2', 0 )
INSERT INTO [dbo].Departamento ( Descricao, Inativo) 
VALUES ('Departamento 3', 0 )




--drop table Pessoa
CREATE TABLE Pessoa
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Nome varchar(300) NOT NULL,
	Inativo bit default 0 NOT NULL
)		
GO
CREATE UNIQUE INDEX IDX_Pessoa_UQ  ON Pessoa(Id)


INSERT INTO [dbo].Pessoa( Nome, Inativo) 
VALUES ('Pessoa 1', 0 )
INSERT INTO [dbo].Pessoa ( Nome, Inativo) 
VALUES ('Pessoa 2', 0 )
INSERT INTO [dbo].Pessoa ( Nome, Inativo) 
VALUES ('Pessoa 3', 0 )





--drop table DepartamentoPessoa
CREATE TABLE DepartamentoPessoa
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Id_Departamento uniqueidentifier NOT NULL, 
	Id_Pessoa uniqueidentifier NOT NULL, 
)		
GO
ALTER TABLE DepartamentoPessoa ADD CONSTRAINT FK_DepartamentoPessoa_Departamento FOREIGN KEY (Id_Departamento) REFERENCES Departamento(Id)
GO
ALTER TABLE DepartamentoPessoa ADD CONSTRAINT FK_DepartamentoPessoa_Pessoa FOREIGN KEY (Id_Pessoa) REFERENCES Pessoa(Id)
GO
CREATE UNIQUE INDEX IDX_DepartamentoPessoa_UQ  ON DepartamentoPessoa (Id, Id_Departamento, Id_Pessoa)


declare @Departamento		varchar(250) =  (select top 1 id from Departamento)
declare @Pessoa		varchar(250) =  (select top 1 id from Pessoa)
INSERT INTO [dbo].DepartamentoPessoa (Id_Departamento, Id_Pessoa) 
VALUES ( @Departamento, @Pessoa)
INSERT INTO [dbo].DepartamentoPessoa (Id_Departamento, Id_Pessoa) 
VALUES ( @Departamento, @Pessoa)
INSERT INTO [dbo].DepartamentoPessoa (Id_Departamento, Id_Pessoa) 
VALUES ( @Departamento, @Pessoa)
INSERT INTO [dbo].DepartamentoPessoa (Id_Departamento, Id_Pessoa) 
VALUES ( @Departamento, @Pessoa)


select 
	top 1
	'departamento que tem mais pessoas:' as 'Para encontrar o departamento que tem mais pessoas:',
	dep.Descricao as 'Departamento', sum(1) as 'Pessoas'
from
	DepartamentoPessoa dp
	inner join Departamento dep on dep.Id = dp.Id_Departamento
	inner join Pessoa pes on pes.Id = dp.Id_Pessoa
group by 
	dep.Descricao
order by 
	sum(1) desc



	
--drop table Cidade
CREATE TABLE Cidade
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Nome varchar(300) NOT NULL,
	Inativo bit default 0 NOT NULL
)		
GO
CREATE UNIQUE INDEX IDX_Cidade_UQ  ON Cidade(Id)


INSERT INTO [dbo].Cidade( Nome, Inativo) 
VALUES ('Cidade 1', 0 )
INSERT INTO [dbo].Cidade ( Nome, Inativo) 
VALUES ('Cidade 2', 0 )
INSERT INTO [dbo].Cidade ( Nome, Inativo) 
VALUES ('Cidade 3', 0 )




--drop table DepartamentoCidade
CREATE TABLE DepartamentoCidade
(
	Id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
	Id_Departamento uniqueidentifier NOT NULL, 
	Id_Cidade uniqueidentifier NOT NULL, 
)		
GO
ALTER TABLE DepartamentoCidade ADD CONSTRAINT FK_DepartamentoCidade_Departamento FOREIGN KEY (Id_Departamento) REFERENCES Departamento(Id)
GO
ALTER TABLE DepartamentoCidade ADD CONSTRAINT FK_DepartamentoCidade_Cidade FOREIGN KEY (Id_Cidade) REFERENCES Cidade(Id)
GO
CREATE UNIQUE INDEX IDX_DepartamentoCidade_UQ  ON DepartamentoCidade (Id, Id_Departamento, Id_Cidade)


declare @Departamento		varchar(250) =  (select top 1 id from Departamento)
declare @Cidade		varchar(250) =  (select top 1 id from Cidade)
INSERT INTO [dbo].DepartamentoCidade (Id_Departamento, Id_Cidade) 
VALUES ( @Departamento, @Cidade)
INSERT INTO [dbo].DepartamentoCidade (Id_Departamento, Id_Cidade) 
VALUES ( @Departamento, @Cidade)
INSERT INTO [dbo].DepartamentoCidade (Id_Departamento, Id_Cidade) 
VALUES ( @Departamento, @Cidade)
INSERT INTO [dbo].DepartamentoCidade (Id_Departamento, Id_Cidade) 
VALUES ( @Departamento, @Cidade)


select 
	'Quais são os departamentos por cidade?' as 'Quais são os departamentos por cidade?',
	dep.Descricao, cid.Nome, sum(1) as 'Quantidade'
from
	DepartamentoCidade dp
	inner join Departamento dep on dep.Id = dp.Id_Departamento
	inner join Cidade cid on cid.Id = dp.Id_Cidade
group by 
	dep.Descricao, cid.Nome


select 
	'Relação de empregrados por departamento?' as 'Relação de empregrados por departamento?',
	pes.Nome, dep.Descricao, sum(1) as 'Quantidade'
from
	DepartamentoPessoa dp
	inner join Pessoa pes on pes.Id = dp.Id_Pessoa
	inner join Departamento dep on dep.Id = dp.Id_Departamento
group by 
	dep.Descricao, pes.Nome





 --use DioBancoDados


ALTER PROCEDURE sp_GerenciarDados
    @Acao VARCHAR(50),
    @ID uniqueidentifier,
    @NovoNome NVARCHAR(50)
	AS
	BEGIN
	 --   DECLARE @Resultado NVARCHAR(50)
		--SET @Resultado = 
		--   CASE 
		--		WHEN @Acao = 1 THEN SELECT Nome FROM Cidade WHERE Id = @ID
		--		WHEN @Acao = 2 THEN UPDATE Cidade SET Nome = @NovoNome WHERE Id = @ID
		--		WHEN @Acao = 3 THEN DELETE FROM Cidade WHERE Id = @ID 
		--	END
		--SELECT @Resultado AS Resultado
		IF @Acao = 'SELECT'
			BEGIN
				SELECT Nome FROM Cidade WHERE Id = @ID
			END
		ELSE IF @Acao = 'UPDATE'
			BEGIN
				UPDATE Cidade SET Nome = @NovoNome WHERE Id = @ID
			END
		ELSE IF @Acao = 'DELETE'
			BEGIN
				DELETE FROM Cidade WHERE Id = @ID 
			END
		ELSE IF @Acao = 'INSERT'
			BEGIN
				INSERT INTO [dbo].Cidade( Nome, Inativo) VALUES (@NovoNome, 0 )
			END
		ELSE
			BEGIN
				select @Acao
			END
	END





EXEC sp_GerenciarDados @Acao = 'INSERT', @ID = null, @NovoNome = 'meu insert';
select * from Cidade


declare @idCidade uniqueidentifier = (select top 1 Id from Cidade);
select @idCidade;
EXEC sp_GerenciarDados @Acao = 'SELECT', @ID = @idCidade, @NovoNome = null;


declare @idCidade uniqueidentifier = (select top 1 Id from Cidade);
select @idCidade;
EXEC sp_GerenciarDados @Acao = 'UPDATE', @ID = @idCidade, @NovoNome = 'Teste';
 


declare @idCidade uniqueidentifier = (select top 1 Id from Cidade);
select @idCidade;
EXEC sp_GerenciarDados @Acao = 'DELETE', @ID = @idCidade, @NovoNome = null;
 


