show databases;

use dbprofessor;

show tables;

-- Exemplo 
SELECT
	docente.iddocente,
	docente.nome,
    consulta.tipo,
    consulta.iddisciplina,
    (SELECT nome from disciplina where iddisciplina = consulta.iddisciplina) as Nome_disciplina
    
FROM 
	(SELECT iddocente, iddisciplina, 'Orientador' as Tipo FROM orientador
	  UNION
	  SELECT iddocente, iddisciplina, 'Professor' as Tipo FROM professor
      UNION
	  SELECT iddocente, iddisciplina, 'Tutor' as tipo FROM tutor) AS consulta
 INNER JOIN docente on 
	docente.iddocente = consulta.iddocente;



-- Crie uma consulta SQL que liste o nome do professor e o nome da disciplina, apenas para professores e tutores. 
-- Quando o professor for tutor e professor ao mesmo tempo ele deve aparecer duas vezes;​

SELECT 
	(select nome from docente where iddocente = consulta.iddocente) as Nome,
	consulta.tipo,
    (SELECT nome from disciplina where iddisciplina = consulta.iddisciplina) as Disciplina
     
FROM 
	(SELECT iddocente, iddisciplina, 'Professor' as tipo FROM PROFESSOR
	UNION
	SELECT iddocente, iddisciplina, 'Tutor' as Tipo FROM TUTOR) AS CONSULTA;
        

        

	
select * from tutor;
        
SELECT
	orientador.iddocente,
    orientador.iddisciplina
FROM 
	orientador
    LEFT JOIN PROFESSOR ON
    professor.iddocente = orientador.iddocente;










SELECT
	docente.nome,
    disciplina.nome,
			(SELECT 
			docente.nome
		FROM 
			docente
		INNER JOIN tutor on 
			docente.iddocente = tutor.iddocente
		INNER JOIN disciplina on
			disciplina.iddisciplina = tutor.iddisciplina) as Tutor,
			(SELECT 
			disciplina.nome
		FROM 
			docente
		INNER JOIN tutor on 
			docente.iddocente = tutor.iddocente
		INNER JOIN disciplina on
			disciplina.iddisciplina = tutor.iddisciplina
		WHERE disciplina.iddisciplina = tutor.iddisciplina) as Disciplina_tutor
			
FROM 
	docente
INNER JOIN professor on 
	docente.iddocente = professor.iddocente 
INNER JOIN disciplina on 
	professor.iddisciplina = disciplina.iddisciplina;
    
    SELECT
	Tutor.nome,
    disciplina.nome
	FROM		(SELECT 
			docente.nome
		FROM 
			docente
		INNER JOIN tutor on 
			docente.iddocente = tutor.iddocente
		INNER JOIN disciplina on
			disciplina.iddisciplina = tutor.iddisciplina) as Tutor

INNER JOIN professor on 
	docente.iddocente = professor.iddocente 
INNER JOIN disciplina on 
	professor.iddisciplina = disciplina.iddisciplina;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
SELECT 
	docente.nome,
    disciplina.nome
FROM 
	docente
INNER JOIN tutor on 
	docente.iddocente = tutor.iddocente
INNER JOIN disciplina on
	disciplina.iddisciplina = tutor.iddisciplina;
	
