SET SQL_SAFE_UPDATES = 1;

DROP DATABASE DBCARTAOCREDITO;

CREATE DATABASE DBCARTAOCREDITO;

USE DBCARTAOCREDITO;

-- INSERÇÃO DE DADOS

/* ---------------------------------------------------------------- CRIAR CLIENTE ---------------------------------------------------------------- */

CALL CRIARCLIENTE('GUSTAVO RODRIGUES DOS SANTOS','65464664909','6660305', 'RUA INÊS MARIA FERREIRA', '26', 'FUNDOS', 'BIGUAÇU', 'SC', 'PRAÇA', '1997-06-02', '(48)32435744', '(48)991735776', '(48)32435744', @RESULT);
SELECT @RESULT;


DELIMITER $$
CREATE PROCEDURE CRIARCLIENTE(pNOME VARCHAR(100), pCPF CHAR(11), pRG VARCHAR(16), pLOGRADOURO VARCHAR(100), 
pNUMERO VARCHAR(100), pBAIRRO VARCHAR(100), pCIDADE VARCHAR(100), pUF CHAR(2), pCOMPLEMENTO VARCHAR(100), pDATANASCIMENTO DATE, 
pTELEFONE_RESIDENCIAL VARCHAR(15), pTELEFONE_COMERCIAL VARCHAR(15), pTELEFONE_RECADO VARCHAR(15), OUT pRESULTADO VARCHAR(100)) 
BEGIN
	
    DECLARE vNUMEROCPF INT;
    DECLARE vINDICE INT DEFAULT 1;
    DECLARE vVALIDARCPF VARCHAR(110);
    DECLARE vIDCLIENTE INT;
    DECLARE vNUMEROCARTAO VARCHAR(17);
    DECLARE vIDCARTAO INT;
    
    
    -- VERIFICANDO CPF
    
	SET vNUMEROCPF = SUBSTRING(pCPF, 1, 1); 
    SET vVALIDARCPF = 'CPF INVÁLIDO';
    SET pRESULTADO = vVALIDARCPF; 
    
			IF LENGTH(pCPF) = 11 THEN
				WHILE vINDICE <=11 DO
					 IF SUBSTRING(pCPF, vINDICE, 1) <> vNUMEROCPF THEN
						
						 SET vVALIDARCPF = 'CPF VÁLIDO';
					END IF; 
					SET vINDICE = vINDICE + 1;
				END WHILE;
			END IF;	
            
    -- incluindo cliente
    IF vVALIDARCPF = 'CPF VÁLIDO' THEN
    
				INSERT INTO CLIENTE VALUES(DEFAULT, pNOME, pCPF,  pRG, pLOGRADOURO , 
		pNUMERO , pBAIRRO , pCIDADE , pUF , pCOMPLEMENTO , pDATANASCIMENTO , 
		pTELEFONE_RESIDENCIAL , pTELEFONE_COMERCIAL , pTELEFONE_RECADO);
		
		SET vIDCLIENTE = last_insert_id();
		
		
		INSERT INTO CARTAO VALUES(DEFAULT, vIDCLIENTE, 0, 10, 1000 );
		
        SET vIDCARTAO = last_insert_id();
        
        SET vNUMEROCARTAO = LPAD(vIDCARTAO, 6 , '0');
        SET vNUMEROCARTAO = CONCAT(pCPF, vNUMEROCARTAO);
        
        UPDATE CARTAO SET NUMERO = vNUMEROCARTAO WHERE IDCARTAO = vIDCARTAO;
    
    END IF;
    
    SET pRESULTADO = vVALIDARCPF; 
		
END $$
DELIMITER ;


/* ---------------------------------------------------------------- TRANSAÇÃO / GERAR DEBITO---------------------------------------------------------------- */

SELECT * FROM DEBITO;
DESC DEBITO;
SELECT @RESULT;
CALL TRANSACAO(1, 2, 400, @RESULT);
    
DROP PROCEDURE TRANSACAO;

-- PROCEDURE TRANSACAO
DELIMITER $$
CREATE PROCEDURE TRANSACAO (pIDCARTAO INT, pQTDPARCELAS INT, pVALOR DECIMAL(8,2), OUT pRESULTADO VARCHAR(1000))
BEGIN 
	DECLARE vQTDPARCELAS INT;
    DECLARE vVALORPARCELAS DECIMAL(8,2);
    DECLARE vSALDO DECIMAL(8,2);
    DECLARE vIDCARTAO VARCHAR(20);
    
	SELECT SALDO INTO vSALDO FROM VW_SALDO WHERE IDCARTAO = pIDCARTAO;
    
   
			
		IF pVALOR <= vSALDO THEN
				IF pQTDPARCELAS = 1 THEN 
					SET vVALORPARCELAS = pVALOR;
					INSERT INTO DEBITO VALUES(DEFAULT, pIDCARTAO, 'PARCELA 1 DE 1', pQTDPARCELAS, vVALORPARCELAS, NOW());
					SET pRESULTADO = "COMPRA À VISTA REALIZADA COM SUCESSO!";
                    
				ELSEIF pQTDPARCELAS > 1 THEN 
                
					SET vQTDPARCELAS = 0;
					SET vVALORPARCELAS = pVALOR / pQTDPARCELAS; 
					
					WHILE vQTDPARCELAS < pQTDPARCELAS DO
                    
						IF (vQTDPARCELAS + 1) = pQTDPARCELAS THEN
							SET vVALORPARCELAS =  pVALOR - (vVALORPARCELAS * vQTDPARCELAS);
						END IF;
							INSERT INTO DEBITO VALUES(DEFAULT, pIDCARTAO, concat('PARCELA ', vQTDPARCELAS + 1, ' DE ', pQTDPARCELAS), pQTDPARCELAS, vVALORPARCELAS, DATE_ADD(NOW(), INTERVAL vQTDPARCELAS MONTH));
							SET vQTDPARCELAS = vQTDPARCELAS  + 1;
                            
					END WHILE;
                    
						SET pRESULTADO = "COMPRA PARCELADA REALIZADA COM SUCESSO!";
                        
				END IF;
			ELSE
				SET pRESULTADO = "SALDO INSUFICIENTE";
			END IF;
	
END $$
DELIMITER ;

/* ---------------------------------------------------------------- GERAR BOLETO -------------------------------------------------------------------------- */

SELECT * FROM CARTAO;
SELECT * FROM DEBITO;
SELECT SUM(DEBITO.VALOR) FROM DEBITO WHERE DEBITO.IDCARTAO =  1 AND DT_DEBITO < NOW();


CALL GERARBOLETO(1, @RESULT);
SELECT @RESULT;
-- PROCEDURE BOLETO
-- QUANDO NÃO TEM DÉBITO O BOLETO BUGA CORRIGIR

DROP PROCEDURE GERARBOLETO;
-- PROCEDURE BOLETO
	DELIMITER $
	CREATE PROCEDURE GERARBOLETO(pIDCARTAO INT, OUT pRESULT VARCHAR(200))
	BEGIN
			DECLARE vDIA INT;
			DECLARE vVALOR_TOTAL DECIMAL(8,2);
			DECLARE vIDBOLETO INT;
			DECLARE vDIA_VENCIMENTO INT;
			DECLARE vDATA_VENCIMENTO DATE;
			
		IF DAY(NOW()) = 16 THEN
			SELECT SUM(DEBITO.VALOR) INTO vVALOR_TOTAL FROM DEBITO WHERE DEBITO.IDCARTAO = pIDCARTAO AND DT_DEBITO < NOW();
			
						SELECT DIA_VENCIMENTO INTO vDIA_VENCIMENTO FROM CARTAO WHERE CARTAO.IDCARTAO = pIDCARTAO;
						SET vDATA_VENCIMENTO = CONCAT(YEAR(NOW()),"-",MONTH(DATE_ADD(NOW(), INTERVAL 1 MONTH)),"-",vDIA_VENCIMENTO);
				
			INSERT INTO BOLETO VALUES(DEFAULT, pIDCARTAO, NOW(), vDATA_VENCIMENTO, vVALOR_TOTAL, NULL, NULL);
			SET vIDBOLETO = LAST_INSERT_ID();
            
            INSERT INTO ITEM_BOLETO (IDBOLETO, IDDEBITO)
            SELECT vIDBOLETO, DEBITO.IDDEBITO	
			FROM DEBITO 
			WHERE DEBITO.IDCARTAO = pIDCARTAO AND DT_DEBITO > date_add(NOW(), INTERVAL - 1 MONTH) AND DT_DEBITO <= NOW()
			GROUP BY DEBITO.IDDEBITO;
            
            
			SET pRESULT = "Boleto gerado";
            SELECT @RESULT;
		ELSE
			SET pRESULT =  "Boleto não gerado, ainda não fechou o mês!";
            SELECT @RESULT;
		END IF;
	END $$
	DELIMITER ;
    
    
/* ---------------------------------------------------------------- PAGAR BOLETO ---------------------------------------------------------------- */


		
	SELECT @RESULT;
	CALL PAGARBOLETO(1, 350, @RESULT);   
	SELECT * FROM BOLETO;
    
    DROP PROCEDURE PAGARBOLETO;
    DELIMITER $$
    CREATE PROCEDURE PAGARBOLETO(pIDBOLETO INT, pVALOR DECIMAL(8,2), OUT pRESULT VARCHAR(100))
    BEGIN
		DECLARE vVALORBOLETO DECIMAL(8,2);
        DECLARE vVALORRESTANTE DECIMAL(8,2);
        DECLARE vIDCARTAO INT;
        DECLARE vDT_PAGAMENTO DATE;
        DECLARE vDT_VENCIMENTO DATE;
        DECLARE vVALORJUROS DECIMAL(8,2);
        DECLARE vTAXAREFINANCIAMENTO DECIMAL(8,2);
        DECLARE vIDBOLETO INT;
        
        SELECT DT_VENCIMENTO INTO vDT_VENCIMENTO FROM BOLETO WHERE BOLETO.IDBOLETO = pIDBOLETO;
        SELECT DT_PAGAMENTO INTO vDT_PAGAMENTO FROM BOLETO WHERE BOLETO.IDBOLETO = pIDBOLETO;
        SELECT IDCARTAO INTO vIDCARTAO FROM BOLETO WHERE IDBOLETO = pIDBOLETO;
	
		SELECT IDBOLETO INTO vIDBOLETO FROM BOLETO WHERE IDBOLETO = pIDBOLETO;
    
		
						IF ISNULL(vDT_PAGAMENTO) THEN 
									 SELECT VALOR_TOTAL INTO vVALORBOLETO FROM BOLETO WHERE BOLETO.IDBOLETO = pIDBOLETO;
									IF(vVALORBOLETO = pVALOR) THEN 
									
										UPDATE BOLETO SET DT_PAGAMENTO = NOW(), VALOR_PAGO = pVALOR WHERE pIDBOLETO = BOLETO.IDBOLETO;
										SET pRESULT = "BOLETO PAGO COM SUCESSO!";
										SELECT @RESULT;
										
									ELSEIF vVALORBOLETO < pVALOR THEN 
									
										SET pRESULT = "VALOR ACIMA DO VALOR DO BOLETO";
										SELECT @RESULT;
										
									ELSEIF vVALORBOLETO > pVALOR THEN 
									
										SET vVALORRESTANTE = vVALORBOLETO - pVALOR;
										SET vTAXAREFINANCIAMENTO = vVALORBOLETO * 0.15;
															
										INSERT INTO DEBITO VALUES(DEFAULT, vIDCARTAO, 'PARCELA 1 DE 1 VALOR RESTANTE MÊS ANTERIOR', 1 , vVALORRESTANTE, DATE_ADD(NOW(), INTERVAL 1 MONTH));
										INSERT INTO DEBITO (IDCARTAO, DESCRICAO, PARCELA, VALOR, DT_DEBITO) VALUES(vIDCARTAO, 'TAXA DE REFINANCIAMENTO REFERENTE AO MÊS ANTERIOR', 1 ,vTAXAREFINANCIAMENTO , DATE_ADD(NOW(), INTERVAL 1 MONTH));
										
										UPDATE BOLETO SET DT_PAGAMENTO = NOW(), VALOR_PAGO = pVALOR WHERE pIDBOLETO = BOLETO.IDBOLETO;
										
										SET pRESULT = CONCAT(pRESULT, "DEBITO GERADO COM VALOR RESTANTE");
										SELECT @RESULT;
									END IF;
									
									 /* VERIFICANDO DATA DO PAGAMENTO E GERANDO JUROS */
									 
										IF vDT_VENCIMENTO < NOW() THEN
										
											SET vVALORJUROS = vVALORBOLETO * 0.02; /* Taxa fixa de juros */
											SET vVALORJUROS = vVALORJUROS + ((vVALORBOLETO * 0.002) * DATEDIFF(NOW(), vDT_VENCIMENTO)); /* Juros por dia */
											INSERT INTO DEBITO VALUES(DEFAULT, vIDCARTAO, 'PARCELA 1 DE 1 - JUROS REFERENTE A MÊS ANTERIOR', 1 , vVALORJUROS, DATE_ADD(NOW(), INTERVAL 1 MONTH));
										
										END IF;
						ELSE
							SET pRESULT = "O BOLETO JÁ FOI PAGO";
							SELECT @RESULT;
						END IF;
                        
			
    END $$
    DELIMITER ;
 

 
/* ---------------------------------------------------------------- VIEW SALDO ---------------------------------------------------------------- */
		       
		SELECT * FROM VW_SALDO;
        DROP VIEW VW_SALDO;
        
        CREATE VIEW VW_SALDO AS
        SELECT 
			CARTAO.IDCARTAO,
            CARTAO.LIMITE + (IFNULL(SUM(VALOR), 0 )) AS SALDO
		FROM CARTAO
		LEFT JOIN VW_EXTRATO ON
			CARTAO.IDCARTAO = VW_EXTRATO.IDCARTAO
        GROUP BY CARTAO.IDCARTAO, CARTAO.LIMITE;
        
/*  -----------------------------------------------------------  5 VIEW DE EXTRATO -----------------------------------------------------------  */ 
		
			        
        DROP VIEW VW_EXTRATO;
        SELECT * FROM VW_EXTRATO;
		CREATE VIEW VW_EXTRATO AS
        SELECT 
			BOLETO.IDCARTAO, 
			BOLETO.IDBOLETO,  
			BOLETO.VALOR_TOTAL AS VALOR, DT_PAGAMENTO, 
			'PAGAMENTO BOLETO' 
        FROM BOLETO 
			WHERE DT_PAGAMENTO IS NOT NULL
		UNION
		SELECT 
			DEBITO.IDCARTAO, 
            DEBITO.IDDEBITO, 
            (DEBITO.VALOR * -1) AS VALOR, 
            DEBITO.DT_DEBITO, 
            DEBITO.DESCRICAO 
		FROM DEBITO 
        WHERE DT_DEBITO > DATE_ADD(NOW(), INTERVAL - 1 MONTH);
        
          

/* ---------------------------------------------------------------- VIEW CLIENTE QUESTÃO 6- --------------------------------------------------------------- */
		
        

        
		SELECT * FROM VW_CLIENTE;
        DROP VIEW VW_CLIENTE;
        CREATE VIEW VW_CLIENTE AS
			SELECT 
				CLIENTE.NOME,
                CLIENTE.LOGRADOURO,
                CLIENTE.NUMERO,
                CLIENTE.BAIRRO,
                CLIENTE.UF,
                CLIENTE.COMPLEMENTO,
                CONCAT((SUBSTRING(CARTAO.NUMERO, 1, 2)), '-------------', (SUBSTRING(CARTAO.NUMERO, 16, 2))) AS 'NUMERO DO CARTAO',
                BOLETO.DT_GERACAO,
                BOLETO.VALOR_TOTAL,
                FN_EXTENSO(BOLETO.VALOR_TOTAL) AS 'VALOR TOTAL POR EXTENSO',
                BOLETO.DT_VENCIMENTO
                FROM
                CLIENTE
                LEFT JOIN CARTAO ON 
					CLIENTE.IDCLIENTE = CARTAO.IDCLIENTE
				LEFT JOIN BOLETO ON 
					CARTAO.IDCARTAO = BOLETO.IDCARTAO;
                
           
/* ----------------------------------------- FUNÇÃO PARA O NÚMERO POR EXTENSO -----------------------------------------  */

        
DROP FUNCTION FN_EXTENSO;
DELIMITER $$
CREATE FUNCTION FN_EXTENSO(N1 int) returns varchar(4500)
BEGIN
	DECLARE RESULTADO varchar(4500) default '';
    DECLARE CONT int;
	SET CONT = 0;
    WHILE N1 > 0 do
		IF CONT > 0 THEN SET RESULTADO = CONCAT(RESULTADO, ' E');
		END IF;
				CASE 
					WHEN N1 = 1 THEN  set RESULTADO = concat(RESULTADO, ' UM'); set N1 = N1 - 1; 
					WHEN N1 = 2 THEN  set RESULTADO = concat(RESULTADO, ' DOIS'); set N1 = N1 - 2 ;
					WHEN N1 = 3 THEN  set RESULTADO = concat(RESULTADO,' TRES');  set N1 = N1 - 3;
					WHEN N1 = 4 THEN  set RESULTADO = concat(RESULTADO,' QUATRO');  set N1 = N1 - 4;
					WHEN N1 = 5 THEN  set RESULTADO = concat(RESULTADO,' CINCO');  set N1 = N1 - 5;
					WHEN N1 = 6 THEN  set RESULTADO = concat(RESULTADO,' SEIS');  set N1 = N1 - 6;
					WHEN N1 = 7 THEN  set RESULTADO = concat(RESULTADO,' SETE');  set N1 = N1 - 7;
					WHEN N1 = 8 THEN  set RESULTADO = concat(RESULTADO,' OITO');  set N1 = N1 - 8;
					WHEN N1 = 9 THEN  set RESULTADO = concat(RESULTADO,' NOVE');  set N1 = N1 - 9;
                    WHEN N1 = 10 THEN  set RESULTADO = concat(RESULTADO,' DEZ');  set N1 = N1 - 10;
					WHEN N1 = 11 THEN  set RESULTADO = concat(RESULTADO,' ONZE');  set N1 = N1 - 11;
					WHEN N1 = 12 THEN  set RESULTADO = concat(RESULTADO,' DOZE');  set N1 =  N1 - 12;
					WHEN N1 = 13 THEN  set RESULTADO = concat(RESULTADO,' TREZE');  set N1 =  N1 - 13;
					WHEN N1 = 14 THEN  set RESULTADO = concat(RESULTADO,' QUATORZE');  set N1 =  N1 - 14;
					WHEN N1 = 15 THEN  set RESULTADO = concat(RESULTADO,' QUINZE');  set N1 = N1 - 15;
					WHEN N1 = 16 THEN  set RESULTADO = concat(RESULTADO,' DEZESSEIS');  set N1 =  N1 - 16;
					WHEN N1 = 17 THEN  set RESULTADO = concat(RESULTADO,' DEZESSETE');  set N1 =  N1 - 17;
					WHEN N1 = 18 THEN  set RESULTADO = concat(RESULTADO,' DEZOITO');  set N1 =  N1 - 18;
                    WHEN N1 = 19 THEN  set RESULTADO = concat(RESULTADO,' DEZENOVE');  set N1 =  N1 - 19;
                    -- DEZENAS
					WHEN N1 >= 20 and N1 <= 29 THEN set RESULTADO = concat(RESULTADO,' VINTE');  set N1 =  N1 - 20;
					WHEN N1 >= 30 and N1 <= 39 THEN set RESULTADO = concat(RESULTADO,' TRINTA');  set N1 =  N1 - 30;
                    WHEN N1 >= 40 and N1 <= 49 THEN set RESULTADO = concat(RESULTADO,' QUARENTA');  set N1 =  N1 - 40;
					WHEN N1 >= 50 and N1 <= 59 THEN set RESULTADO = concat(RESULTADO,' CINQUENTA');  set N1 =  N1 - 50;
					WHEN N1 >= 60 and N1 <= 69 THEN set RESULTADO = concat(RESULTADO,' SESSENTA');  set N1 =  N1 - 60;
					WHEN N1 >= 70 and N1 <= 79 THEN set RESULTADO = concat(RESULTADO,' SETENTA');  set N1 =  N1 - 70;
					WHEN N1 >= 80 and N1 <= 89 THEN set RESULTADO = concat(RESULTADO,' OITENTA');  set N1 =  N1 - 80;
					WHEN N1 >= 90 and N1 <= 99 THEN set RESULTADO = concat(RESULTADO,' NOVENTA');  set N1 =  N1 - 90;
                    WHEN N1 < 200 THEN set RESULTADO = concat(RESULTADO, ' CENTO'); set N1 = N1 - 100;
                    WHEN N1 < 300 THEN set RESULTADO = concat(RESULTADO, ' DUZENTOS'); set N1 = N1 - 200;
                    WHEN N1 < 400 THEN set RESULTADO = concat(RESULTADO, ' TREZENTOS'); set N1 = N1 - 300;
                    WHEN N1 < 500 THEN set RESULTADO = concat(RESULTADO, ' QUATROCENTOS'); set N1 = N1 - 400;
                    WHEN N1 < 600 THEN set RESULTADO = concat(RESULTADO, ' QUINHENTOS'); set N1 = N1 - 500;
                    WHEN N1 < 700 THEN set RESULTADO = concat(RESULTADO, ' SEISCENTOS'); set N1 = N1 - 600;
                    WHEN N1 < 800 THEN set RESULTADO = concat(RESULTADO, ' SETECENTOS'); set N1 = N1 - 700;
                    WHEN N1 < 900 THEN set RESULTADO = concat(RESULTADO, ' OITOENTOS'); set N1 = N1 - 800;
                    WHEN N1 < 1000 THEN set RESULTADO = concat(RESULTADO, ' NOVECENTOS'); set N1 = N1 - 900;
                    WHEN N1 < 2000 THEN set RESULTADO = concat(RESULTADO, ' MIL'); set N1 = N1 - 1000;
                    
                    
					
				END CASE;
			
          SET CONT = CONT + 1;
    END WHILE;
    RETURN RESULTADO;
END $$
DELIMITER ; 


/* ----------------------------------------- VIEW BOLETO 7 -----------------------------------------  */
	

		DROP VIEW VW_BOLETO;
		SELECT * FROM VW_BOLETO;
			CREATE VIEW VW_BOLETO AS
			SELECT 
				BOLETO.IDBOLETO AS BOLETO,
				ITEM_BOLETO.IDITEM_BOLETO AS ITEM,
				DEBITO.DESCRICAO,
				DEBITO.VALOR, 
				DEBITO.DT_DEBITO
			FROM BOLETO
				LEFT JOIN ITEM_BOLETO ON 
			BOLETO.IDBOLETO = ITEM_BOLETO.IDBOLETO
				LEFT JOIN DEBITO ON 
				DEBITO.IDDEBITO = ITEM_BOLETO.IDDEBITO
			;









