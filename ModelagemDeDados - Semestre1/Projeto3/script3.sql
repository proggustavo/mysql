create database quest;

use quest;

create table quest01 (
	
    idquest int not null auto_increment,
    nome varchar (100) not null,
    email varchar (100) not null,
    telefone varchar (100) not null,
    cidade varchar (100) not null,
    mensagem varchar (100),
    notificacao enum('s','n') not null,
	primary key (idquest)

);
