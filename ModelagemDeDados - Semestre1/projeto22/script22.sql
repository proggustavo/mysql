create database dbexercicio22;

use dbexercicio22;

create table cliente (
	idcliente int not null primary key,
    nome varchar(100), 
    email varchar(100),
    cpf varchar(15),
    telefone int,
    ddd int,
    telefoneresidencial int,
    telefoneref int,
    dddref int,
    rua varchar(100),
    numeroendereco int,
    complemento varchar(100),
    bairro varchar(100),
    cidade varchar(100),
    estado varchar(45),
    cep varchar(45),
    numerocnh varchar(45)
);
create table veiculo(
	idveiculo int not null,
    marca varchar(45),
    modelo varchar(45),
    anomod int,
    anofab int,
    tipocombustivel varchar(45)
);



create table locacao (
	idlocacao int not null primary key,
    horaentrega varchar(45),
    dataretirada date,
    horaretirada varchar(45),
    dataentrega date,
    kmretirada varchar(45),
    kmentrega varchar(45),
    idveiculo int not null,
    idcliente int not null,
    foreign key (idveiculo) references veiculo (idveiculo),
    foreign key (idcliente) references cliente (idcliente)
);


create table opcional(
	idopcional int not null primary key,
    arcondicionado varchar(45),
    direcao varchar(45),
    trava varchar(45)
);

create table veiculo_opcional(
	idveiculo int not null,
    idopcional int not null,
    primary key (idveiculo, idopcional),
    foreign key (idveiculo) references veiculo (idveiculo),
    foreign key (idopcional) references opcional (idopcional)

); 


