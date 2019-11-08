create database dbexercicio17;

use dbexercicio17;

create table medico (
	idmedico int not null primary key,
    nome varchar(100) not null,
    telefone varchar(15) not null,
    especialidade varchar(100) not null,
    crm varchar(15) not null

);


create table paciente(
	idpaciente int not null primary key,
    nome varchar(100) not null,
    telefone varchar(15) not null,
    sexo varchar(15) not null,
    datanasc date not null

);

create table consulta(
	idconsulta int not null primary key,
    dataa date not null,
    hora time not null,
    idmedico int not null, 
    idpaciente int not null,
    foreign key (idmedico) references medico (idmedico),
    foreign key (idpaciente) references paciente (idpaciente)

);

