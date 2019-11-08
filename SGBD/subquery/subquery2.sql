use dbprofessor;

-- 1
create table aluno (
	idaluno int not null primary key auto_increment,
    nome varchar(45),
    dt_nascimento date
);

create table matricula (
	idmatricula int not null primary key auto_increment,
	dt_matricula date, 
    idaluno int not null,
    iddisciplina int not null,
    foreign key (idaluno) references aluno (idaluno),
    foreign key (iddisciplina) references disciplina (iddisciplina)
);

-- 2
alter table disciplina add column Carga_horaria int;

-- 3 
update disciplina set Carga_horaria = 80 where iddisciplina =6;

-- 4
insert into aluno values(default, 'Gustavo', '1997-06-02');
insert into aluno values(default, 'Guilherme', '1997-06-02');
insert into aluno values(default, 'Maria', '1997-12-26');
insert into aluno values(default, 'Julia', '2001-05-17');
insert into aluno values(default, 'João', '1995-09-05');

insert into matricula values(default, '2019-09-16', 1,1);
insert into matricula values(default, '2018-09-20', 1,2);
insert into matricula values(default, '2019-12-02', 1,3);
insert into matricula values(default, '2019-04-30', 1,4);
insert into matricula values(default, '2019-05-10', 1,5);
insert into matricula values(default, '2019-08-06', 1,6);
insert into matricula values(default, '2019-01-26', 1,1);
insert into matricula values(default, '2019-11-16', 1,2);
insert into matricula values(default, '2019-10-23', 1,3);
insert into matricula values(default, '2019-08-12', 1,4);

-- 5 Crie uma consulta SQL para listar o código identificador do docente, nome do docente, 
-- o código identificador da disciplina, o nomeda disciplina, o tipo de docente (professor, tutor, orientador), 
-- a quantidade de alunos matriculados e a média de idade dos alunos matriculados.

SELECT 
	docente.iddocente,
    docente.nome,
    disciplina.iddisciplina,
    disciplina.nome,
    consulta.tipo,
	count(aluno.idaluno) as Matriculas,
	avg(YEAR(now()) - year(dt_nascimento)) as Idade_media
FROM
	(select iddocente, iddisciplina, 'Orientador' as Tipo from orientador
	UNION 
	select iddocente, iddisciplina, 'Tutor' as Tipo from tutor
	union 
	select iddocente, iddisciplina, 'Professor' as Tipo from professor ) AS consulta
    INNER JOIN docente on 
		docente.iddocente = consulta.iddocente
	INNER JOIN disciplina on 
		disciplina.iddisciplina = consulta.iddisciplina
	LEFT JOIN matricula on
		matricula.iddisciplina = disciplina.iddisciplina
	LEFT JOIN aluno on 
		aluno.idaluno = matricula.idaluno
	GROUP BY
	docente.iddocente,
    docente.nome,
    disciplina.iddisciplina,
    disciplina.nome,
    consulta.tipo;

-- 6 Crie uma consulta SQL para listar o código identificador do docente, nome do docente, 
-- o tipo de docente (professor, tutor, orientador) 
-- e a soma da carga horária ministrada para cada tipo de docente

SELECT 
	docente.iddocente,
    docente.nome,
    consulta.tipo,
    sum(disciplina.carga_horaria)
From
(select iddocente, iddisciplina, 'Tutor' as tipo from Tutor
UNION
select iddocente, iddisciplina,  'Professor' as tipo from Professor
UNION
select iddocente, iddisciplina, 'Orientador' as tipo from Orientador) as consulta
INNER JOIN docente on 
	docente.iddocente = consulta.iddocente
INNER JOIN disciplina on 
	disciplina.iddisciplina = consulta.iddisciplina
GROUP BY 
	docente.iddocente,
    docente.nome,
    consulta.tipo;

-- 7 Crie uma consulta SQL para listar o código identificador do docente e nome do docente. 
-- Liste apenas os docentes que são tutores e Professores. 

select
	docente.iddocente,
    docente.nome
FROM
docente
INNER JOIN tutor on 
	docente.iddocente = tutor.iddocente
INNER JOIN professor on 
	docente.iddocente = professor.iddocente;


-- 8 Crie uma consulta SQL para listar o código identificador do docente e nome do docente. 
-- Liste apenas os docentes que são apenas orientadores

select 
	docente.iddocente,
    docente.nome
FROM 
docente 
where iddocente in (select iddocente from orientador);

-- 9 Crie uma consulta SQL para listar as disciplinas que tem mais de um docente, 
-- liste o código identificador da disciplina, nome da disciplina, 
-- quantidade de docentes, quantidade de alunos matriculados

select 
	consulta.iddisciplina,
    disciplina.nome,
    count(consulta.iddocente) AS Docentes,
    count(matricula.idmatricula) as Matriculas
FROM
(select iddocente, iddisciplina, 'Tutor' as tipo from Tutor
UNION
select iddocente, iddisciplina,  'Professor' as tipo from Professor
UNION
select iddocente, iddisciplina, 'Orientador' as tipo from Orientador) as consulta
INNER JOIN disciplina on 
		disciplina.iddisciplina = consulta.iddisciplina
INNER JOIN matricula on 
	matricula.iddisciplina = disciplina.iddisciplina
group by
consulta.iddisciplina,
    disciplina.nome;
    
    select * from matricula;

-- 10

