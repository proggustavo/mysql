create database dbexercicio19;

use dbexercicio19;

create table pessoa (
	idpessoa int not null primary key,
    nome varchar(45) not null,
    telefone int not null 

);

create table fisica (
	idpessoa_fisica int not null primary key,
    cpf varchar(45) not null,
	foreign key (idpessoa_fisica) references pessoa (idpessoa)
    
);

create table juridica (
	idpessoa_juridica int not null primary key,
    cnpj varchar(45) not null,
    foreign key (idpessoa_juridica) references pessoa (idpessoa)

);