USE universidad;

-- Query #1: list with the first last name, middle last name, and first name of all students. 
-- Alphabetically from lowest to highest by first last name, middle last name, and first name.
SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- Query #2: first and last names of students who have not registered their phone number in the database.
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL;

-- Query #3: list of students who were born in 1999.
SELECT *
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- Query #4: list of teachers who have not registered their phone number in the database and whose NIF ends in K.
SELECT *
FROM persona
WHERE tipo = 'profesor' AND telefono IS NULL AND NIF LIKE '%K';

-- Query #5: list of subjects taught in the first semester, in the third year of the degree that has the identifier 7.
SELECT nombre
FROM asignatura
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- Query #6: list of professors along with the name of the department to which they are associated. 
-- returning four columns: first last name, middle last name, first name, and department name alphabetically from lowest to highest by last name and first name.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento
FROM persona p
INNER JOIN profesor pr ON p.id = pr.id_profesor
INNER JOIN departamento d ON pr.id_departamento = d.id
ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;

-- Query #7: list with the name of the subjects, starting year and end year of the school year of the student with NIF 26902806M.
SELECT a.nombre AS nombre_asignatura, ce.anyo_inicio, ce.anyo_fin
FROM persona per
INNER JOIN alumno_se_matricula_asignatura ama ON per.id = ama.id_alumno
INNER JOIN asignatura a ON ama.id_asignatura = a.id
INNER JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id
WHERE per.NIF = '26902806M';

-- Query #8: list with the names of all departments that have professors who teach a subject in the Degree in Computer Engineering (2015 Plan).
SELECT DISTINCT d.nombre AS nombre_departamento
FROM departamento d
INNER JOIN profesor pr ON d.id = pr.id_departamento
INNER JOIN asignatura a ON pr.id_profesor = a.id_profesor
INNER JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- Query #9: list of all students enrolled in a subject during the 2018/2019 school year.
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2
FROM persona p
INNER JOIN alumno_se_matricula_asignatura ama ON p.id = ama.id_alumno
INNER JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id
WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;

-- ---------------------------------------------------
-- Queries with LEFT JOIN and RIGHT JOIN (Universidad).
-- --------------------------------------------------- 

-- Query #10: list with the names of all professors and the departments they are linked to. 
-- The list show those professors who do not have any associated departments. 
-- The list return four columns: department name, first last name, middle last name, and professor's first name. 
-- The result are sorted alphabetically from lowest to highest by department name, last name, and first name.
SELECT d.nombre AS nombre_departamento, p.apellido1, p.apellido2, p.nombre
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN departamento d ON pr.id_departamento = d.id
WHERE p.tipo = 'profesor'
ORDER BY nombre_departamento ASC, p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;

-- Query #11: list of teachers who are not associated with a department.
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
INNER JOIN profesor pr ON p.id = pr.id_profesor
WHERE pr.id_departamento IS NULL;

-- Query #12: list of departments that do not have associated professors.
SELECT d.nombre AS nombre_departamento
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
WHERE pr.id_profesor IS NULL;

-- Query #13: list of teachers who do not teach any subjects.
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
INNER JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id IS NULL AND p.tipo = 'profesor';

-- Query #14: list of subjects that do not have a teacher assigned.
SELECT a.nombre AS nombre_asignatura
FROM asignatura a
WHERE a.id_profesor IS NULL;

-- Query #15: list of all departments that have not taught subjects in any academic year.
SELECT d.nombre AS nombre_departamento
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id IS NULL;

-- -----------------------------
-- Summary queries (Universidad). 
-- -----------------------------

-- Query #16: total number of existing students.
SELECT COUNT(*) AS total_alumnos
FROM persona
WHERE tipo = 'alumno';

-- Query #17: students were born in 1999.
SELECT COUNT(*) AS alumnos_nacidos_1999
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- Query #18: number of professors in each department. 
-- showing two columns: one with the department name and the other with the number of professors in that department
-- including only departments with associate professors and sorted from highest to lowest by number of professors.
SELECT d.nombre AS nombre_departamento, COUNT(pr.id_profesor) AS numero_profesores
FROM departamento d
INNER JOIN profesor pr ON d.id = pr.id_departamento
GROUP BY d.nombre
ORDER BY numero_profesores DESC;

-- Query #19: list of all departments and the number of professors in each departments. 
SELECT d.nombre AS nombre_departamento, COUNT(pr.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
GROUP BY d.nombre
ORDER BY numero_profesores DESC;

-- Query #20: list with the names of all existing degrees in the database and the number of subjects each offers
-- sorted from highest to lowest by number of subjects.
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
ORDER BY numero_asignaturas DESC;

-- Query #21: list with the name of all existing degrees in the database and the number of subjects each has
-- for degrees that have more than 40 associated subjects.
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
HAVING numero_asignaturas > 40
ORDER BY numero_asignaturas DESC;

-- Query #22: list showing the name of the degree programs and the sum of the total number of credits available for each type of course. 
SELECT g.nombre AS nombre_grado, a.tipo AS tipo_asignatura, SUM(a.creditos) AS total_creditos
FROM grado g
INNER JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre, a.tipo
ORDER BY g.nombre, a.tipo;

-- Query #23: list showing how many students have enrolled in a subject in each academic year. 
SELECT ce.anyo_inicio, COUNT(DISTINCT ama.id_alumno) AS numero_alumnos_matriculados
FROM curso_escolar ce
INNER JOIN alumno_se_matricula_asignatura ama ON ce.id = ama.id_curso_escolar
GROUP BY ce.anyo_inicio
ORDER BY ce.anyo_inicio;

-- Query #24: list with the number of subjects taught by each teacher. 
-- including teachers who do not teach any subjects
-- Tsorted from highest to lowest by number of subjects.
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS numero_asignaturas
FROM persona p
INNER JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE p.tipo = 'profesor'
GROUP BY p.id, p.nombre, p.apellido1, p.apellido2
ORDER BY numero_asignaturas DESC;

-- Query #25: all data for the youngest student.
SELECT *
FROM persona
WHERE tipo = 'alumno'
ORDER BY fecha_nacimiento DESC
LIMIT 1;

-- Query #26: list of professors who have an associated department and who do not teach any subjects.
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
INNER JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE p.tipo = 'profesor' AND pr.id_departamento IS NOT NULL AND a.id IS NULL;








