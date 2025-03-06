create database  universidade;
USE universidade;

CREATE TABLE IF NOT EXISTS materia (
    Codigo_Materia INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Carga_Horaria INT CHECK (Carga_Horaria >= 40) NOT NULL
);

CREATE TABLE IF NOT EXISTS professor (
    Num_Matricula INT PRIMARY KEY CHECK(Num_Matricula BETWEEN 1000 AND 9999),
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS disciplina (
    Codigo_Disciplina INT PRIMARY KEY AUTO_INCREMENT,
    Qtd_Vagas INT CHECK (Qtd_Vagas <= 60) NOT NULL,
    Semestre VARCHAR(20) NOT NULL, 
    Codigo_Materia INT NOT NULL,
    Num_Matricula INT NOT NULL,
    CONSTRAINT fk_disciplina_materia FOREIGN KEY (Codigo_Materia) REFERENCES materia(Codigo_Materia),
    CONSTRAINT fk_disciplina_professor FOREIGN KEY (Num_Matricula) REFERENCES professor(Num_Matricula)
);

CREATE TABLE IF NOT EXISTS curso (
    Codigo_Curso INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Carga_Horaria INT DEFAULT 3600,
    Num_Matricula INT UNIQUE  NOT NULL, 
    CONSTRAINT fk_curso_professor FOREIGN KEY (Num_Matricula) REFERENCES professor(Num_Matricula)
);

CREATE TABLE IF NOT EXISTS aluno (
    Codigo_Aluno INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Codigo_Curso INT , 
    CONSTRAINT fk_curso_aluno FOREIGN KEY (Codigo_Curso) REFERENCES curso(Codigo_Curso)
);
show tables;

CREATE TABLE IF NOT EXISTS email_aluno(
    Codigo_Email INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(100) NOT NULL,
    Codigo_Aluno INT NOT NULL,
    CONSTRAINT fk_email_aluno FOREIGN KEY (Codigo_Aluno) REFERENCES aluno(Codigo_Aluno)
);

CREATE TABLE IF NOT EXISTS curso_disciplina (
    Codigo_Curso INT,
    Codigo_Materia INT,
    PRIMARY KEY (Codigo_Curso, Codigo_Materia),
    CONSTRAINT fk_curso_materia FOREIGN KEY (Codigo_Curso) REFERENCES curso(Codigo_Curso),
    CONSTRAINT fk_materia_curso FOREIGN KEY (Codigo_Materia) REFERENCES materia(Codigo_Materia)
);

CREATE TABLE IF NOT EXISTS aluno_materia (
    Codigo_Aluno INT,
    Codigo_Disciplina INT,
    PRIMARY KEY (Codigo_Aluno, Codigo_Disciplina),
    CONSTRAINT fk_aluno_disciplina FOREIGN KEY (Codigo_Aluno) REFERENCES aluno(Codigo_Aluno),
    CONSTRAINT fk_disciplina_aluno FOREIGN KEY (Codigo_Disciplina) REFERENCES disciplina(Codigo_Disciplina)
);


CREATE TABLE IF NOT EXISTS materia_pre_requisito (
    Codigo_Materia INT,
    Codigo_Pre_Requisito INT,
    PRIMARY KEY (Codigo_Materia, Codigo_Pre_Requisito),
    CONSTRAINT fk_materia_requisito FOREIGN KEY (Codigo_Materia) REFERENCES materia(Codigo_Materia),
    CONSTRAINT fk_materia_requisito_pai FOREIGN KEY (Codigo_Pre_Requisito) REFERENCES materia(Codigo_Materia)
);
