create database dbexercicio23;

use dbexercicio23;

create table cliente (
	idcliente int not null primary key
);
create table produto (
	idproduto int not null primary key
);
create table evento(
	idevento int not null primary key,
    idcliente int not null,
    foreign key (idcliente) references cliente (idcliente)
);

create table eventoproduto (
	idevento int not null,
    idproduto int not null,
    primary key (idevento, idproduto),
    foreign key (idevento) references evento (idevento),
    foreign key (idproduto) references produto (idproduto)
);

