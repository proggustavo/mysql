create database dbexercicio24;

use dbexercicio24;

create table candidato(
    idcompvaga int not null,
    conhecimento varchar(45) not null,
    atitudes varchar(45) not null,
    habilidades varchar(45) not null,
    idcandidato int not null,
    nome varchar(45) not null,
    sexo varchar(1) not null,
    dtnasc varchar(20) not null,
    estadocivil varchar(45) not null,
    cargopretend varchar(45) not null,
    escolaridade varchar(45) not null,
    salpretend float not null,
    idexperiencia int not null,
    empresa varchar(45) not null,
    cargoexp varchar(45)not null,
    dtdemissao varchar(45) not null,
    dtadmissao varchar(45),
    atividades varchar(45),
    primary key(idcandidato)

);

create table vaga (
	idvaga int not null primary key,
    cargo varchar(45),
     atividades varchar(45),
     escolaridademin varchar(45),
     salario float

);

create table candidatar (
	idcandidato int not null,
    idvaga int not null,
    primary key (idcandidato, idvaga),
    foreign key (idcandidato) references candidato (idcandidato),
    foreign key (idvaga) references vaga (idvaga)
    );