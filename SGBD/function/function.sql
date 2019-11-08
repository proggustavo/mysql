create database dbfuncao;
 
use dbfuncao;


-- 1 crie uma função para somar dois números


DELIMITER $$
CREATE function somar(n1 int, n2 int) returns int
BEGIN
	declare resultado int;
    set resultado = n1 + n2;
	return resultado;
END $$
DELIMITER ;


select somar(1, 3);



-- 2 crie uma função para subtrair dois números

DELIMITER $$
CREATE function subtrair(n1 int, n2 int) returns int
BEGIN 
	declare resultado int;
    set resultado = n1 - n2;
	return resultado;
END $$
DELIMITER ;

select subtrair(1, 3);


-- 3 crie uma funçao para multiplicar dois números 

DELIMITER $$
CREATE function multiplicar(n1 double, n2 double) returns double
BEGIN
	declare resultado int;
    set resultado = n1 * n2;
    return resultado;
END $$ 
DELIMITER ;

SELECT multiplicar(2.5,4);


-- 4 crie uma função para dividir

DELIMITER $$
CREATE function dividir(n1 double, n2 double) returns double
BEGIN 
	declare resultado double;
    set resultado = n1 / n2;
    return resultado;

END $$
DELIMITER ;

drop function dividir;

SELECT dividir(3,4);

-- 5 crie uma calculadora

DELIMITER $$
CREATE FUNCTION calculadora(n1 double,n2 double, funcao varchar(15)) returns double
BEGIN 
	declare resultado double;
	IF funcao = "dividir" then
		set resultado = dividir(n1,n2);
		return resultado;
	ELSEIF funcao = "multiplicar" then 
		set resultado = multiplicar(n1,n2);
		return resultado;
	ELSEIF funcao = "somar"  then 
		set resultado = somar(n1,n2);
		return resultado;
	ELSEIF funcao = "subtrair" then
		set resultado = subtrair(n1,n2);
        return resultado;
	END IF;

END $$
DELIMITER ;

drop function calculadora;

select calculadora(3,3,"dividir");

-- 6 crie uma funcao para identificar se o número é primo 

DELIMITER $$
CREATE function primo(n1 int) returns varchar(45)
BEGIN 
	declare resultado varchar(30);
    declare cont int;
    set cont = n1 - 1;
    set resultado = "O número é primo";
		
		WHILE cont > 1 and n1 % cont != 0  do
			set cont = cont -1;
		END WHILE;
        
        if cont = 1 then 		
			return resultado;
		ELSEIF cont != 1 then
			set resultado = "Não é primo";
            return resultado;
		END IF;
END $$
DELIMITER ;

drop function primo;

select primo(101);


-- 7 crie uma função para informar a idade a partir de uma data informada 

DELIMITER $$
CREATE function fn_idade(datain date) returns int
BEGIN
	declare resultado int;
	set resultado = year(now()) - year(datain);
    return resultado;
    
END $$
DELIMITER ;

drop function fn_idade;

select fn_idade('1997-06-02');

-- 8 crie uma função para calcular o anivesário a partir de uma data informada

DELIMITER $$
create function fn_aniversario(datain date) returns date
BEGIN
	if month(now()) >= month(datain) then
		
        
	END IF;

END $$
DELIMITER ;


-- 9 - 
DELIMITER $$
CREATE FUNCTION romanos(n1 int) returns varchar(3000)
BEGIN
 declare resultado varchar(300) default ''; 
	WHILE n1 > 0 do
			CASE
		WHEN n1 < 4 THEN set resultado = concat(resultado, 'I'); set n1 = n1 - 1;  
		WHEN n1 = 4 THEN SET resultado = concat(resultado, 'IV'); set n1 = n1 - 4;
		WHEN n1 < 9 THEN SET resultado = concat(resultado, 'V'); set n1 = n1 - 5;
        WHEN n1 = 9 THEN SET resultado = concat(resultado, 'IX'); set n1 = n1 - 9;
        WHEN n1 < 40 THEN SET resultado = concat(resultado, 'X'); set n1 = n1 - 10;
        WHEN n1 < 50 THEN SET resultado = concat(resultado, 'XL'); set n1 = n1 - 40;
        WHEN n1 < 90 THEN SET resultado = concat(resultado, 'L'); set n1 = n1 - 50;
        WHEN n1 < 100 THEN SET resultado = concat(resultado, 'XC'); set n1 = n1 - 90;
        WHEN n1 < 400 THEN SET resultado = concat(resultado, 'C'); set n1 = n1 - 100;
         WHEN n1 < 500 THEN SET resultado = concat(resultado, 'CD'); set n1 = n1 - 400;
         WHEN n1 < 800 THEN SET resultado = concat(resultado, 'D'); set n1 = n1 - 500;
		END CASE;
	END WHILE;
    return resultado;
END $$
DELIMITER ;

drop function romanos;
select ROMANOS(299); 

-- 10 crie uma funcao para escrever um número por extenso 

DELIMITER $$
CREATE FUNCTION fn_extenso(n1 int) returns varchar(4500)
BEGIN
	declare resultado varchar(4500) default '';
    declare cont int;
	set cont = 0;
    WHILE n1 > 0 do
		if cont != 1 THEN set resultado = concat(resultado, ' e');
        ELSE
				CASE 
					WHEN n1 = 1 THEN  set resultado = concat(resultado, ' UM'); set n1 = n1 - 1; 
					WHEN n1 = 2 THEN  set resultado = concat(resultado, ' DOIS'); set n1 = n1 - 2 ;
					WHEN n1 = 3 THEN  set resultado = concat(resultado,' TRES');  set n1 = n1 - 3;
					WHEN n1 = 4 THEN  set resultado = concat(resultado,' QUATRO');  set n1 = n1 - 4;
					WHEN n1 = 5 THEN  set resultado = concat(resultado,' CINCO');  set n1 = n1 - 5;
					WHEN n1 = 6 THEN  set resultado = concat(resultado,' SEIS');  set n1 = n1 - 6;
					WHEN n1 = 7 THEN  set resultado = concat(resultado,' SETE');  set n1 = n1 - 7;
					WHEN n1 = 8 THEN  set resultado = concat(resultado,' OITO');  set n1 = n1 - 8;
					WHEN n1 = 9 THEN  set resultado = concat(resultado,' NOVE');  set n1 = n1 - 9;
                    WHEN n1 = 10 THEN  set resultado = concat(resultado,' DEZ');  set n1 = n1 - 10;
					WHEN n1 = 11 THEN  set resultado = concat(resultado,' ONZE');  set n1 = n1 - 11;
					WHEN n1 = 12 THEN  set resultado = concat(resultado,' DOZE');  set n1 =  n1 - 12;
					WHEN n1 = 13 THEN  set resultado = concat(resultado,' TREZE');  set n1 =  n1 - 13;
					WHEN n1 = 14 THEN  set resultado = concat(resultado,' QUATORZE');  set n1 =  n1 - 14;
					WHEN n1 = 15 THEN  set resultado = concat(resultado,' QUINZE');  set n1 = n1 - 15;
					WHEN n1 = 16 THEN  set resultado = concat(resultado,' DEZESSEIS');  set n1 =  n1 - 16;
					WHEN n1 = 17 THEN  set resultado = concat(resultado,' DEZESSETE');  set n1 =  n1 - 17;
					WHEN n1 = 18 THEN  set resultado = concat(resultado,' DEZOITO');  set n1 =  n1 - 18;
                    WHEN n1 = 19 THEN  set resultado = concat(resultado,' DEZENOVE');  set n1 =  n1 - 19;
                    -- DEZENAS
					WHEN n1 >= 20 and n1 <= 29 THEN set resultado = concat(resultado,' VINTE');  set n1 =  n1 - 20;
					WHEN n1 >= 30 and n1 <= 39 THEN set resultado = concat(resultado,' TRINTA');  set n1 =  n1 - 30;
                    WHEN n1 >= 40 and n1 <= 49 THEN set resultado = concat(resultado,' QUARENTA');  set n1 =  n1 - 40;
					WHEN n1 >= 50 and n1 <= 59 THEN set resultado = concat(resultado,' CINQUENTA');  set n1 =  n1 - 50;
					WHEN n1 >= 60 and n1 <= 69 THEN set resultado = concat(resultado,' SESSENTA');  set n1 =  n1 - 60;
					WHEN n1 >= 70 and n1 <= 79 THEN set resultado = concat(resultado,' SETENTA');  set n1 =  n1 - 70;
					WHEN n1 >= 80 and n1 <= 89 THEN set resultado = concat(resultado,' OITENTA');  set n1 =  n1 - 80;
					WHEN n1 >= 90 and n1 <= 99 THEN set resultado = concat(resultado,' NOVENTA');  set n1 =  n1 - 90;
                    WHEN n1 < 200 THEN set resultado = concat(resultado, ' CENTO'); set n1 = n1 - 100;
                    WHEN n1 < 300 THEN set resultado = concat(resultado, ' DUZENTOS'); set n1 = n1 - 200;
                    WHEN n1 < 400 THEN set resultado = concat(resultado, ' TREZENTOS'); set n1 = n1 - 300;
                    WHEN n1 < 500 THEN set resultado = concat(resultado, ' QUATROCENTOS'); set n1 = n1 - 400;
                    WHEN n1 < 600 THEN set resultado = concat(resultado, ' QUINHENTOS'); set n1 = n1 - 500;
                    WHEN n1 < 700 THEN set resultado = concat(resultado, ' SEISCENTOS'); set n1 = n1 - 600;
                    WHEN n1 < 800 THEN set resultado = concat(resultado, ' SETECENTOS'); set n1 = n1 - 700;
                    WHEN n1 < 900 THEN set resultado = concat(resultado, ' OITOENTOS'); set n1 = n1 - 800;
                    WHEN n1 < 1000 THEN set resultado = concat(resultado, ' NOVECENTOS'); set n1 = n1 - 900;
                    WHEN n1 < 2000 THEN set resultado = concat(resultado, ' MIL'); set n1 = n1 - 1000;
				END CASE;
			END IF;
               set cont = cont + 1;
    END WHILE;
    RETURN RESULTADO;
END $$
DELIMITER ; 

DROP function fn_extenso;

select fn_extenso(1678);




