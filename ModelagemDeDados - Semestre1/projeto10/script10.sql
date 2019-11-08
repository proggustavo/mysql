create database dbveiculo_renavam;

use dbveiculo_renavam;

create table veiculo_renavam (
	idveiculo int not null ,
    idrenavam int not null ,
    anofab int not null,
    marca varchar(45) not null,
    modelo varchar(45) not null,
    placadoveiculo varchar(10) not null,
    dataregistro date not null,
    cidade varchar(45) not null,
    estado varchar(45) not null,
    
    primary key (idveiculo, idrenavam)
    
    
);