create database dbpessoa_rg;

use dbpessoa_rg;

create table pessoa_rg (
	idpessoa int not null ,
    idrg int not null ,
    datanasc date not null,
    nome varchar(45) not null,
    nomepai varchar(45) not null,
    nomemae varchar(10) not null,
    rg int not null,
    datasolicitacao date not null,
    dataemissao date not null,
     localemissao varchar(45) not null,
    
    primary key (idpessoa, idrg)
    
    
);