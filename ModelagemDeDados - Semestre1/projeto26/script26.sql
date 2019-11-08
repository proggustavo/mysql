DROP DATABASE IF EXISTS DBDELEGACIA;

CREATE DATABASE DBDELEGACIA;

USE DBDELEGACIA;

CREATE TABLE CRIME (
	IDCRIME INT NOT NULL,
	DESCRICAO VARCHAR(255),
	RUA VARCHAR(100),
	NUMERO INT,
	COMPLEMENTO VARCHAR(255),
	BAIRRO VARCHAR(100),
	CEP VARCHAR(8),
	CIDADE VARCHAR(100),
	ESTADO CHAR(2)
);

CREATE TABLE CRIMINOSO(
  RUA VARCHAR(100),
  NUMERO INT,
  COMPLEMENTO VARCHAR(255),
  BAIRRO VARCHAR(100),
  CEP CHAR(8),
  CIDADE VARCHAR(100),
  ESTADO CHAR(2),
  DTNASCIMENTO DATE,
  TELEFONE VARCHAR(15)
);

CREATE TABLE OCORRENCIA (
	IDOCORRENCIA INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	DT_OCORRENCIA DATE
);

CREATE TABLE ITEM_OCORRENCIA (
	IDITEM INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	IDOCORRENCIA INT NOT NULL,
	DESCRICAO VARCHAR (100),
	CONSTRAINT FK_ITEM_OCORRENCIA_OCORRENCIA FOREIGN KEY (IDOCORRENCIA) REFERENCES OCORRENCIA(IDOCORRENCIA)
);

CREATE TABLE VITIMA (
  RUA VARCHAR(100),
  NUMERO INT,
  COMPLEMENTO VARCHAR(255),
  BAIRRO VARCHAR(100),
  CEP VARCHAR(8),
  CIDADE VARCHAR(100),
  ESTADO CHAR(2),
  DTNASCIMENTO DATE
);

CREATE TABLE COMETE(
	IDCRIME INT NOT NULL,
	IDCRIMINOSO INT NOT NULL
);

CREATE TABLE ATACA (
	OBSERVACAO CHAR(1)
);

CREATE TABLE SOFRE (
	IDCRIME INT NOT NULL,
	IDVITIMA INT NOT NULL
);

CREATE TABLE ARMA (
	IDARMA INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	MARCA VARCHAR(110)
);

CREATE TABLE USADA (
	IDARMA INT NOT NULL,
	IDCRIME INT NOT NULL
);


alter table crime add idcrime int not null primary key;

alter table criminoso add idcriminoso int not null primary key;

alter table vitima add idvitima int not null primary key;

alter table comete 
add primary key (idcrime, idcriminoso),
add foreign key (idcriminoso) references criminoso (idcriminoso),
add foreign key (idcrime) references crime (idcrime);

alter table sofre
add primary key (idcrime, idvitima),
add foreign key (idcrime) references crime (idcrime),
add foreign key (idvitima) references vitima (idvitima);

alter table ataca 
add column idcriminoso int not null,
add column idvitima int not null,
add primary key (idcriminoso, idvitima),
add foreign key (idcriminoso) references criminoso (idcriminoso),
add foreign key (idvitima) references vitima (idvitima);


alter table usada
add primary key (idarma, idcrime),
add foreign key (idarma) references arma (idarma),
add foreign key (idcrime) references crime (idcrime);  

alter table comete modify idcriminoso int not null primary key;

drop table ocorrencia; drop table item_ocorrencia;

