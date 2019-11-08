SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBCONTACORRENTE;
CREATE DATABASE DBCONTACORRENTE;
USE DBCONTACORRENTE;

CREATE TABLE CLIENTE(
	IDCLIENTE INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, NOME VARCHAR(100)
	, CPF CHAR(11)
);

INSERT INTO CLIENTE VALUES(default, 'Gustavo', 09630985942);


CREATE TABLE CONTA (
	IDCONTA INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, IDCLIENTE INT NOT NULL
	, DT_ABERTURA DATE
	, LIMITE_CREDITO NUMERIC(8,2)
	, TIPO ENUM('CONTA-CORRENTE', 'POUPANÇA')
	, FOREIGN KEY (IDCLIENTE) REFERENCES CLIENTE (IDCLIENTE)
);

INSERT INTO CONTA VALUES(default, 1, '2019-10-03', '1000', 'conta-corrente');
INSERT INTO CONTA VALUES(default, 1, '2019-10-03', '0', 'poupança');


CREATE TABLE MOVIMENTACAO(
	IDMOVIMENTACAO INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, IDCONTA INT NOT NULL
	, DT_MOVIMENTACAO DATETIME
	, VALOR NUMERIC(8,2)
	, TIPO ENUM('DEBITO', 'CRÉDITO')
	, OBSERVAÇÃO TEXT
	, FOREIGN KEY (IDCONTA) REFERENCES CONTA (IDCONTA)
);




-- INCLUINDO MOVIMENTACOES
SELECT * FROM MOVIMENTACAO;
SELECT * FROM cliente;
SELECT * FROM conta;
-- DEPOSITO 
INSERT INTO MOVIMENTACAO (IDCONTA, DT_MOVIMENTACAO, VALOR, TIPO) values(1, now(), 200, 'CRÉDITO');
INSERT INTO MOVIMENTACAO (IDCONTA, DT_MOVIMENTACAO, VALOR, TIPO) values(2, now(), 100, 'CRÉDITO');
-- SAQUE 
INSERT INTO MOVIMENTACAO (IDCONTA, DT_MOVIMENTACAO, VALOR, TIPO) VALUES (1, NOW(), -800, 'DÉBITO');
INSERT INTO MOVIMENTACAO (IDCONTA, DT_MOVIMENTACAO, VALOR, TIPO) VALUES (2, NOW(), -50, 'DÉBITO');

SELECT * FROM MOVIMENTACAO;

-- QUESTÃO 1 crie uma consulta sql que mostre o código identificador do cliente, código da conta, tipo da conta, a soma dos valores da movimentação, 
-- o valor do limite da conta e a soma dos limites da movimentação menos o valor limite da conta. 



-- CRIANDO A VIEW
SELECT * FROM VW_SALDO;

CREATE VIEW VW_SALDO AS
SELECT 
	CLIENTE.IDCLIENTE,
    CONTA.IDCONTA, 
    CONTA.TIPO,
    sum(MOVIMENTACAO.VALOR) as Saldo,
	CONTA.LIMITE_CREDITO as Credito,
    (CONTA.LIMITE_CREDITO + sum(VALOR)) as Saldo_final
FROM 
CONTA
LEFT JOIN CLIENTE ON 
 CLIENTE.IDCLIENTE = CONTA.IDCLIENTE
LEFT JOIN MOVIMENTACAO ON 
	CONTA.IDCONTA = MOVIMENTACAO.IDCONTA
GROUP BY CLIENTE.IDCLIENTE,
    CONTA.IDCONTA, 
    CONTA.TIPO,
    CONTA.LIMITE_CREDITO;
    
    
-- 2 Crie uma procedure para realizar as movimentações. A procedure deve receber como parâmetro o numero da conta, 
-- valor e o tipo de movimentação (deposito ou saque). Para realizar o saque em uma poupança o saldo não deve estar negativo, 
-- mas na conta corrente pode ser realizado desde que não ultrapasse o limite de credito da conta.

DELIMITER $$
CREATE PROCEDURE sp_movimentacao (pIDCONTA INT, pVALOR NUMERIC(8, 2), pTIPO ENUM('DEPOSITO', 'SAQUE'), pOBSERVACAO VARCHAR(500),  OUT pRESULTADO INT)
	BEGIN
		declare vsaldo numeric(8,2);
		
		IF pVALOR > 0 THEN
		
			if pTIPO = 'DEPOSITO' THEN
			
				INSERT INTO MOVIMENTACAO (IDCONTA, DT_MOVIMENTACAO, VALOR, TIPO, OBSERVAÇÃO) 
				values(pIDCONTA, now(), pVALOR, 'CRÉDITO', pOBSERVACAO);
                
				 SET pRESULTADO = 0;
				
			END IF;
				IF pTIPO = 'SAQUE' THEN
				
					-- colocando o saldo da view dentro da variável
					SELECT Saldo_final INTO vsaldo FROM VW_SALDO WHERE idconta = pidconta;
				   
						IF vsaldo >= pvalor THEN
							
							set pVALOR = pVALOR * -1;
                            
							INSERT INTO MOVIMENTACAO (IDCONTA, DT_MOVIMENTACAO, VALOR, TIPO, OBSERVAÇÃO) 
							VALUES (pIDCONTA, NOW(), pVALOR, 'DÉBITO', pOBSERVACAO);
                            
							 SET pRESULTADO = 0;
						ELSE 
							SET pRESULTADO = -2;
							
						END IF;
				END IF;
		ELSE
			set pRESULTADO = -1;
		END IF;
		
		
	END $$
DELIMITER ;

drop procedure sp_movimentacao;
SELECT * FROM MOVIMENTACAO;

-- DEPOSITO 
CALL SP_MOVIMENTACAO(1, 200, 'DEPOSITO','DEPOSITO', @RESULT1);
CALL SP_MOVIMENTACAO(2, 100, 'DEPOSITO','DEPOSITO', @RESULT2);

-- SAQUE 
CALL SP_MOVIMENTACAO(1, 250, 'SAQUE','SAQUE', @RESULT3);
CALL SP_MOVIMENTACAO(2, 50, 'SAQUE','SAQUE', @RESULT4);

-- 0 = sucesso
-- -1 = valor inválido
-- -2 = saldo insuficiente

SELECT @RESULT1, @RESULT2, @RESULT3, @RESULT4;

INSERT INTO MOVIMENTACAO (IDCONTA, DT_MOVIMENTACAO, VALOR, TIPO) VALUES (1, NOW(), 800, 'DÉBITO');
INSERT INTO MOVIMENTACAO (IDCONTA, DT_MOVIMENTACAO, VALOR, TIPO) VALUES (2, NOW(), 50, 'DÉBITO');


-- 3 Crie uma procedure para realizar transferência entre contas. A procedure deve receber como parâmetro o numero da conta de origem, o numero da conta de destino e o valor. 
-- Para realizar o saque em uma poupança o saldo não deve estar negativo, mas na conta corrente pode ser realizado desde que não ultrapasse o limite de credito da conta.

DELIMITER $$
CREATE PROCEDURE sp_transferencia (pCONTAORIGEM INT, pCONTADESTINO INT, pVALOR NUMERIC(8,2), OUT pRESULTADO INT)
BEGIN
DECLARE vRETORNO INT;

	   CALL SP_MOVIMENTACAO(pCONTAORIGEM, pVALOR, 'SAQUE', CONCAT('TRANSFERENCIA PARA CONTA ', pCONTADESTINO), pRESULTADO);
        
	IF pRESULTADO = 0 THEN
		CALL SP_MOVIMENTACAO(pCONTADESTINO, pVALOR, 'DEPOSITO', CONCAT('TRANSFERENCIA DE CONTA ', pCONTAORIGEM), pRESULTADO);
        SET pRESULTADO = 0;
	ELSE
       SET pRESULTADO = -1; 
	END IF;
END $$
DELIMITER ;

drop procedure sp_transferencia;

call sp_transferencia(1, 2, 5000, @result);

select @result;

-- 4 Crie uma view com o nome “VW_EXTRATO” com consulta SQL que liste todas as movimentações realizada, o tipo da movimentação e caso seja uma transferência 
-- você deve indicar de qual conta foi a origem do valor ou qual conta e o destino do valor;

SELECT * FROM VW_EXTRATO;
SELECT VIEW VW_EXTRATO;

SELECT * FROM MOVIMENTACAO;
DROP VIEW VW_EXTRATO;
CREATE VIEW VW_EXTRATO AS 
SELECT 
	CLIENTE.IDCLIENTE, 
    CONTA.IDCONTA,
    CONTA.TIPO AS TIPOCONTA,
    CONTA.LIMITE_CREDITO,
	MOVIMENTACAO.IDMOVIMENTACAO,
    MOVIMENTACAO.TIPO,
    MOVIMENTACAO.OBSERVAÇÃO,
    MOVIMENTACAO.VALOR
    
FROM 
	CLIENTE
    LEFT JOIN CONTA ON
    CLIENTE.IDCLIENTE = CONTA.IDCLIENTE
    LEFT JOIN MOVIMENTACAO ON 
    MOVIMENTACAO.IDCONTA = CONTA.IDCONTA
    ORDER BY
    CLIENTE.IDCLIENTE,
    CONTA.IDCONTA,
    MOVIMENTACAO.DT_MOVIMENTACAO;






