-- 1.  Selezionare tutti gli studenti nati nel 1990 (160)

SELECT `name`, `surname`, `date_of_birth`
FROM `students`
WHERE YEAR(`date_of_birth`) = 1990;


 -- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)


SELECT `name`, `cfu`
FROM `courses`
WHERE `cfu` > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni

SELECT `name`, `surname`, `date_of_birth` 
FROM `students` 
WHERE `date_of_birth` < '1990-08-28'; 

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)

SELECT `name`, `period`, `year` 
FROM `courses` 
WHERE `period` = 'I Semestre' AND `year` = '1';

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)

SELECT *
FROM `exams`
WHERE HOUR(`hour`) >= '14' AND `date` = '2020-06-20';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)

SELECT *
FROM `degrees`
WHERE `level` = 'Magistrale';

-- 7. Da quanti dipartimenti è composta l'università? (12)

SELECT COUNT(*) 
FROM `departments`; 

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)

SELECT COUNT(*) AS `teachers_no_phone` 
FROM `teachers`
WHERE `phone` IS NULL;




-- QUERIES CON GROUP BY 

-- 1. Contare quanti iscritti ci sono stati ogni anno

SELECT COUNT(*) AS `number_of_enrolled`, YEAR(`enrolment_date`) AS `year` 
FROM `students` 
GROUP BY `year` ; 

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT COUNT(*) AS `num_of_teachers`, `office_address` 
FROM `teachers` 
GROUP BY `office_address` 
ORDER BY `num_of_teachers` DESC;

-- 3. Calcolare la media dei voti di ogni appello d'esame

SELECT `exam_id`, ROUND(AVG(`vote`), 2) 
FROM `exam_student` 
GROUP BY `exam_id` ;

--4. . Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT `department_id`, COUNT(*) AS `courses` 
FROM `degrees` 
GROUP BY `department_id` 



 -- JOIN QUERIES

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT `students`.`name`, `students`.`surname`, `degrees`.`name` 
FROM `students` 
JOIN `degrees` 
ON `degrees`.`id` = `students`.`degree_id` 
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze

SELECT `degrees`.`name`, `departments`.`name` 
FROM `degrees` 
JOIN `departments` 
ON `departments`.`id` = `degrees`.`department_id` 
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT `courses`.`name` AS `nome_corso` , `teachers`.`name`, `teachers`.`surname`
FROM `course_teacher`
JOIN `teachers`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
WHERE `teachers`.`name` = 'Fulvio'
AND `teachers`.`surname` = 'Amato';