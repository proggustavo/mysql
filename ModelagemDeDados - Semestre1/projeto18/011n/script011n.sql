create database dbrevisao18;

use dbrevisao18;

create table entidade_a (
		id_a int not null primary key,
        atr_a varchar(45) not null
        
	
);

create table entidade_b (
		id_b int not null primary key,
        atr_b varchar(45) not null,
        id_a int not null,
        foreign key (id_a) references entidade_a (id_a)

);