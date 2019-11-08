create database dbexercicio20;

use dbexercicio20;

create table criminoso (
	idcriminoso int not null primary key,
    nome varchar(45) not null,
    dtnasc date not null
);

create table crime (
	idcrime int not null primary key,
    dtcrime date not null,
    hrcrime time not null
);

create table vitima (
	idvitima int not null primary key,
    nome varchar(45) not null,
    dtnasc date not null,
    idcrime int not null,
    foreign key (idcrime) references crime (idcrime)
);

create table arma (
	idarma int not null primary key,
    tipo varchar(45) not null,
    descricao varchar(45) not null
);
create table comete (
	idcrime int not null,
    idcriminoso int not null,
    primary key (idcrime, idcriminoso),
    foreign key (idcrime) references crime (idcrime),
    foreign key (idcriminoso) references criminoso (idcriminoso)
);

create table ataca (
	idvitima int not null,
    idcriminoso int not null,
    primary key (idvitima, idcriminoso),
    foreign key (idvitima) references vitima (idvitima),
    foreign key (idcriminoso) references criminoso (idcriminoso)
);

create table usa (
	idarma int not null,
    idcrime int not null,
    primary key (idarma, idcrime),
    foreign key (idarma) references arma (idarma),
    foreign key (idcrime) references crime (idcrime)
);