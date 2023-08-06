
--PARTE 1 � TRANSA��ES 

--Objetivo:  

--Neste desafio voc� ir� lidar com transa��es para executar modifica��es na base de dados. Sendo assim, vamos relembrar como executar uma transa��o. Primeiramente, � preciso desabilitar o autocommit do MySQL. Caso contr�rio, cada instru��o SQL executada ser� confirmada. 

--CODE 1

--Essa primeira transa��o pode ser executada sem utilizar outros recursos como procedures. Dessa forma, voc� ir� executar statements de consultas e modifica��es de dados persistidos no banco de dados via transa��es.  

 

BEGIN TRANSACTION;

declare @idProjeto UNIQUEIDENTIFIER = (select top 1 id from Projeto order by id desc)
SELECT * FROM Projeto WHERE Id = @idProjeto

UPDATE Projeto SET Nome = 'Projeto modificado' WHERE Id = @idProjeto;

INSERT INTO [dbo].Projeto( Nome, Inativo) VALUES ('Projeto Novo', 0 )

COMMIT TRANSACTION;


--PARTE 2 - TRANSA��O COM PROCEDURE 

--Voc� dever� criar outra transa��o, contudo, esta ser� definida dentro de uma procedure. Neste caso, assim como no exemplo em aula, dever� haver uma verifica��o de erro. Essa verifica��o ir� acarretar um ROLLBACK, total ou parcial (SAVEPOINT). 

-- drop PROCEDURE ProcedureInsertProjeto
CREATE PROCEDURE ProcedureInsertProjeto
    @Nome NVARCHAR(50),
    @Ativo INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
		INSERT INTO [dbo].Projeto( Nome, Inativo) VALUES (@Nome, @Ativo )
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Erro na procedure';
    END CATCH;
END;


exec ProcedureInsertProjeto  @Nome = 'Projeto do Cliente', @Ativo = 0




--Neste etapa do desafio, voc� ir� executar o backup do banco de dados e-commerce. Realize o backup e recovery do banco de dados; 

--Utilize o mysqdump para realizar o backup e recovery do banco de dados e-commerce; 

--Realize o backup de diferentes bancos de dados e inseria os recursos como: procedures, eventos e outros. 

--Adicione o arquivo de backup ao github juntamente com o script; 

 ---  DROP PROCEDURE CriarBackupDatabase
CREATE PROCEDURE CriarBackupDatabase
    @NomeDoBancoDeDados NVARCHAR(128),
    @CaminhoDoBackup NVARCHAR(260)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = 'BACKUP DATABASE ' + QUOTENAME(@NomeDoBancoDeDados) + 
               ' TO DISK = ' + QUOTENAME(@CaminhoDoBackup) 
END;




EXEC CriarBackupDatabase @NomeDoBancoDeDados = 'DioBancoDados', @CaminhoDoBackup = 'C:\ArquivoDeBackup.bak';






