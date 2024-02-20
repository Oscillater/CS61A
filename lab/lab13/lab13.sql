.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE color = "blue" AND pet = "dog";

CREATE TABLE bluedog_songs AS
  SELECT students.color, students.pet, students.song FROM students, numbers WHERE students.time = numbers.time AND students.color = "blue" AND students.pet = "dog" ;


CREATE TABLE matchmaker AS
  SELECT stu1.pet, stu1.song, stu1.color, stu2.color FROM students AS stu1, students AS stu2 WHERE stu1.time < stu2.time AND stu1.pet = stu2.pet AND stu1.song = stu2.song;


CREATE TABLE sevens AS
  SELECT students.seven FROM students, numbers WHERE students.time = numbers.time AND students.number = 7 AND numbers.'7' = "True";


CREATE TABLE favpets AS
  SELECT pet, COUNT(*) AS count FROM students GROUP BY pet ORDER BY count DESC LIMIT 10;


CREATE TABLE dog AS
  SELECT pet, COUNT(*) AS count FROM students WHERE students.pet = "dog";


CREATE TABLE bluedog_agg AS
  SELECT song, COUNT(*) AS count FROM bluedog_songs GROUP BY song ORDER BY count DESC;


CREATE TABLE instructor_obedience AS
  SELECT seven, instructor, COUNT(*) AS count FROM students WHERE students.seven = '7' GROUP BY instructor ORDER BY count DESC;

