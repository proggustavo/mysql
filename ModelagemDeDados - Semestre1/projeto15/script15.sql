create database dbexercicio15;

use dbexercicio15;

create table equipe (
	
	idequipe int not null primary key auto_increment,
    nomeequipe varchar(45) not null,
    descricao varchar(100) not null
);

create table funcionario(
	idfuncionario int not null auto_increment,
    idequipe int not null,
    idsupervisor int not null,
    nome varchar(100) not null,
    telefone varchar(15) not null,
    conhecimento varchar(100)  not null,
    primary key (idfuncionario, idequipe),
    foreign key (idequipe) references equipe (idequipe),
    foreign key (idsupervisor) references funcionario (idfuncionario)


);