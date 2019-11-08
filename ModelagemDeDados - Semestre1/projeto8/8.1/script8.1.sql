create database dbcadveiculo;


create table cadveiculo(
	idcad int not null auto_increment primary key,
    placa varchar(10) not null,
    chassi varchar(45) not null,
    marca varchar(45) not null,
    modelo varchar(45) not null,
    anomod int not null,
    anofab int not null
    



);