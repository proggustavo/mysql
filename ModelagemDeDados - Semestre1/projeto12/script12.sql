create database dbpessoa_rg;

use dbpessoa_rg;

create table computador (
	idpc int not null primary key,
    marca varchar(45) not null,
    modelo varchar(45) not null
    


);

create table chamado (
	idchamado int not null ,
    idpc int not null ,
    datachamado date not null,
    solicitante varchar(45) not null,
    horachamado time not null,
    descricao varchar(10) not null,
        
    primary key (idchamado),
    foreign key (idpc) references computador (idpc)
    
    
);