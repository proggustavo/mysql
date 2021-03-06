SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBALUNO;
CREATE DATABASE DBALUNO;
USE DBALUNO;

CREATE TABLE ALUNO (
	IDALUNO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(20) NOT NULL,
	SEXO ENUM ('M', 'F'),
	IDADE int,
	CIDADE VARCHAR(20)
);


-- 1.	Crie os comandos SQL para inserir os dados informados na tabela 1.

INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('ANDERSON', 17, 'M','PALHOCA');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('CESAR', 21, 'M', 'SAO JOSE');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('DANIEL', 19, 'M', 'PALHOCA');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('DIEGO', 19, 'M', 'BLUMENAU');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('EDUARDO', 20, 'M', NULL);
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('GABRIEL', 19, 'M', 'TUBARAO');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('JOAO', 18, 'M', 'SAO JOSE');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('LEONARDO', 19, 'M', NULL);
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('LUCAS', 20, 'M', 'BLUMENAU');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('PRISCILA', 19, 'F', 'PALHOÇA');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('RENATA', 21, 'F', 'TUBARAO');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('MARIA', 22, 'F', 'BLUMENAU');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('TANIA', 19, 'F', 'SAO JOSE');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('CARLOS', 22, 'M', 'TUBARAO');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('JOSE', 19, 'M', 'PALHOCA');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('MARISA', 19, 'F', NULL);
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('AMANDA', 20, 'F', NULL);
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('JOANA', 19, 'F', NULL);
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('ALICE', 21, 'F', 'SAO JOSE');
INSERT INTO ALUNO (NOME, IDADE, SEXO, CIDADE)VALUES('TADEU', 18, 'M', 'TUBARAO');

-- 13

select idaluno, nome from aluno where cidade = 'Blumenau';


-- 14

SELECT nome, cidade from aluno where (sexo = 'F' and idade <= 20) or (sexo = 'M' and iidade <='17');
;

-- 15

SELECT NOME, CIDADE FROM ALUNO WHERE (IDADE BETWEEN 15 AND 18) AND CIDADE <> 'PALHOÇA';

-- 16

SELECT NOME FROM ALUNO WHERE (IDADE = 18 AND CIDADE = 'PALHOÇA') OR (IDADE = 17 AND CIDADE = 'SAO JOSE');

-- 17

SELECT NOME FROM ALUNO WHERE SEXO = 'M' AND CIDADE = 'TUBARAO' AND (IDADE BETWEEN 18 AND 25);

-- 18


-- 19

SELECT NOME, IDADE FROM ALUNO ORDER BY IDADE;

-- 20

SELECT IDALUNO, NOME FROM ALUNO ORDER BY NOME DESC;

-- 21

SELECT * FROM ALUNO ORDER BY IDADE DESC, NOME;

-- 22

SELECT * FROM ALUNO ORDER BY SEXO, NOME;

-- 23

UPDATE ALUNO SET IDADE = 20 WHERE NOME = 'JOSE';

-- 24

UPDATE ALUNO SET IDADE = 21 WHERE NOME IN ('TADEU', 'CESAR', 'MARISA');
UPDATE ALUNO SET IDADE = 21 WHERE NOME = 'TADEU' OR NOME = 'CESAR' OR NOME = 'MARISA';

-- 25

UPDATE ALUNO SET NOME = 'LUIZ', IDADE = 22 , SEXO = 'M', CIDADE = 'TIJUCAS';

-- 26

UPDATE ALUNO SET CIDADE = NULL WHERE IDADE > 24;

-- 27 

DELETE FROM ALUNO WHERE CIDADE IS NULL; -- NO WHERE É IS NULL, QUANDO ATRIBUIR VALOR É =

-- 28

DELETE FROM ALUNO WHERE CIDADE = 'TUBARAO' AND IDADE > 15 AND SEXO = 'M';

-- 29

DELETE FROM ALUNO WHERE NOME IN ('TADEU', 'ALICE', 'MARIA') AND IDADE = 19;

-- 30

DELETE FROM ALUNO WHERE (IDADE < 18 AND SEXO = 'M') OR (IDADE < 21 AND SEXO = 'F');



