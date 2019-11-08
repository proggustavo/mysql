DROP DATABASE IF EXISTS DBELEICAO;

CREATE DATABASE DBELEICAO;

USE DBELEICAO;

CREATE TABLE PARTIDO(
	IDPARTIDO INT PRIMARY KEY,
	NOME VARCHAR(255),
	SIGLA VARCHAR(10)
);

CREATE TABLE CANDIDATO(
	IDCANDIDADTO INT NOT NULL,
	IDPARTIDO INT, 
	NOME VARCHAR(255),
	RUA VARCHAR(100),
	CEP VARCHAR(8),
	CIDADE VARCHAR(100),
	ESTADO CHAR(2),
	FOREIGN KEY (IDPARTIDO) REFERENCES PARTIDO(IDPARTIDO)
);

CREATE TABLE FUNCIONARIO (
	FUNCIONARIO INT PRIMARY KEY,
	IDPARTIDO INT NOT NULL,
	DESCRICAO VARCHAR (100)
);

CREATE TABLE USUARIO (
  LOGIN VARCHAR(100),
  SENHA VARCHAR(255),
  EMAIL VARCHAR(100)
);

CREATE TABLE SETOR(
	IDSETOR INT NOT NULL,
	NOME VARCHAR(100)
);

CREATE TABLE FUNCAO(
	DESCRICAO VARCHAR(100)
);

CREATE TABLE PARTICIPA(
	IDFUNCAO INT,
	IDUSUARIO INT
);

CREATE TABLE VOTAR(
	IDELEICAO INT PRIMARY KEY,
	IDUSUARIO INT,
	IDCANDIDATO INT,
	DT_VOTO DATETIME
);

CREATE TABLE ELEICAO (
	IDELEICAO INT NOT NULL,
	TITULO VARCHAR(100),
	DT_INICIO DATETIME,
	DT_FIM DATETIME,
	PRIMARY KEY (IDELEICAO)
);

drop table candidato;
drop table setor;
drop table funcao;
drop table usuario;
drop table partido;


create table departamento (
		iddepartamento int not null primary key,
        nome varchar(100)
);

create table chapa (
		idchapa int not null primary key,
        nome varchar(100)
);
create table cargo (
	idcargo int not null primary key,
    descricao varchar(100)

);
desc funcionario;

alter table funcionario 
add column nome varchar(100), 
add column cpf char(11),
add column senha varchar(45);
alter table funcionario 
add column iddepartamento int not null;
alter table funcionario
add foreign key (iddepartamento) references departamento (iddepartamento);



alter table votar
add column idfuncionario int not null, add column idchapa int not null;
alter table votar 
drop column idcandidato, drop column idusuario;
alter table votar
add primary key (ideleicao, idfuncionario),
add foreign key (ideleicao) references eleicao (ideleicao),
add foreign key (idfuncionario) references funcionario (idfuncionario),
add foreign key (idchapa) references chapa (idchapa);

alter table chapa
add column ideleicao int not null,
add foreign key (ideleicao) references eleicao (ideleicao);

desc votar;

alter table participa
add column idfuncionario int not null first,
add column idchapa int not null after idfuncionario,
add column idcargo int not null after idchapa,
drop column idusuario,
drop column idfuncao,
add primary key (idfuncionario, idchapa),
add foreign key (idfuncionario) references funcionario (idfuncionario),
add foreign key (idchapa) references chapa (idchapa),
add foreign key (idcargo) references cargo (idcargo);













alter table funcionario 
drop column idpartido,  
drop column funcionario,
drop column descricao;