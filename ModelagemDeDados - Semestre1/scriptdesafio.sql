create database dboficina;

use dboficina;

create table palestra(
	idpalestra int not null primary key
);
create table palestrante(
	idpalestrante int not null primary key
);
create table sala(
	idsala int not null primary key
);
create table data(
	iddata int not null primary key
);
create table turno(
	idturno int not null primary key,
    turno varchar(45)
);
create table aluno(
	idaluno int not null primary key
);
create table horario(
	idturno int not null,
    iddata int not null,
    primary key(idturno, iddata),
    foreign key (iddata) references data (iddata),
    foreign key (idturno) references turno (idturno)
);
create table reserva(
	idsala int not null,
    idturno int not null,
    iddata int not null,
    primary key(idsala, idturno, iddata),
    foreign key (iddata) references data (iddata),
    foreign key (idturno) references turno (idturno),
    foreign key (idsala) references sala (idsala)
);
create table oficina(
	idpalestrante int not null,
    idpalestra int not null,
    idsala int not null,
    idturno int not null,
    iddata int not null,
    primary key(idpalestrante, idpalestra, idturno, iddata),
	foreign key (iddata) references data (iddata),
    foreign key (idturno) references turno (idturno),
	foreign key (idpalestra) references palestra (idpalestra),
	foreign key (idpalestrante) references palestrante (idpalestrante),
    foreign key (idsala) references sala (idsala)
    
);

create table inscricao(
	idaluno int not null,
    iddata int not null,
    idturno int not null,
    idsala int not null,
    idpalestrante int not null,
    idpalestra int not null,
    primary key(idaluno, iddata, idturno, idsala),
    foreign key (idaluno) references aluno (idaluno),
    foreign key (iddata) references data (iddata), 
    foreign key (idturno) references turno (idturno),
    foreign key (idsala) references sala (idsala),
    foreign key (idpalestrante) references palestrante (idpalestrante),
    foreign key (idpalestra) references palestra (idpalestra)
);



