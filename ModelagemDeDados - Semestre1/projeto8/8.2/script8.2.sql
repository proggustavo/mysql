create database dbperdadoc;

create table perdadoc(

	idperdadoc int not null auto_increment primary key,
    datafato date not null,
    horaaprox time not null,
    complemento varchar(45) not null,
    bairro varchar(45) not null,
    numero varchar(10) not null,
    cidade varchar(10) not null,
    uf varchar(2) not null,
    cep varchar(11) not null
    



);