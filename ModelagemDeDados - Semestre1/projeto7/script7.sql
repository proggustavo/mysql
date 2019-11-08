create database dbhospede;

create table hospede (

	idhospede int not null primary key auto_increment,
    rede varchar(100) not null,
    razaosocial varchar(100) not null,
    nomefantasia varchar(100) not null,
    hotelcep varchar(10) not null,
    hotelcomplemento varchar(45) not null,
    hotelbairro varchar(45) not null,
    hotelcidade varchar(45) not null,
    hotelestado varchar(45) not null,
    hotelrua varchar(45) not null,
    hotelnumero int not null,
    cadastromtur varchar(45) not null,
    cnpj varchar(30) not null,
    tipo varchar(45) not null,
    cat varchar(45) not null,
    telefone varchar(20) not null,
    hospnome varchar(100) not null,
    hosptelefone varchar(20) not null,
    hospprofissao varchar(45) not null,
    hospnacionalidade varchar(45) not null,
    hospnasc varchar(45) not null,
    hospsexo enum ('M','F') not null,
    hospdocnumero varchar(45) not null,
    hospdoctipo varchar(45) not null,
    hospdocorgao varchar(45) not null,
    hospcpf varchar(15) not null,
    hosprua varchar(100) not null,
    hospnumero varchar(45) not null,
    hospcomplemento varchar(45) not null,
    hospbairro varchar(45) not null,
    hospcidade varchar(45) not null,
    hospestado varchar(45) not null,
    hospcep varchar(45) not null,
    hosppais varchar(45) not null,
    procecidade varchar(45) not null,
    proceestado varchar(45) not null,
    procpais varchar(45) not null,
    cidadedest varchar(45) not null,
    estadodest varchar(45) not null,
    paisdest varchar(45) not null,
    motivo enum('lazer','negocio', 'feira', 'amigos', 'estudos', 'religião', 'saude', 'compras', 'outro'),
   transporte enum('avião','automóvel', 'ônibus', 'motocicleta', 'navio', 'trem', 'outro'),
   assinahospede varchar(45) not null,
   numacompanhante varchar(45)  not null,
   uhnumero varchar(45) not null,
   checking datetime not null,
   checkout datetime not null
    
    
    
    
    
    
    
    



);