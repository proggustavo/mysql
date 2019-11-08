create database dbrelacionamento;

use dbrelacionamento;

create table produto(
	idproduto int not null auto_increment primary key,
    nome varchar(45) not null,
    preco varchar(10) not null



);

create table pedido(
	idpedido int not null primary key auto_increment,
    datapedido date not null,
    hora time not null,
    cliente varchar(45)
    


);

create table relacao (
	idpedido int not null ,
    idproduto int not null ,
    primary key (idproduto , idpedido),
    foreign key (idproduto) references produto (idproduto),
    foreign key (idpedido) references pedido (idpedido)


);

