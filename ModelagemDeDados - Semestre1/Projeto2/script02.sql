create database exercicio02;
use exercicio02;

create table aluno (
	
    idaluno int not null auto_increment,
    nome varchar(100) not null,
    sexo enum('M', 'F'),
    
    primary key (idaluno)

);

 


