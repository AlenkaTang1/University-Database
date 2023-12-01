-- Names of professors who teach more than one class:
SELECT Professor.eID, Professor.Name, COUNT(*)
FROM Professor, Teaches
WHERE Professor.eID = Teaches.eID
GROUP BY Teaches.eID
HAVING COUNT(*) > 1;

-- Generate list of classes taught by a professor
SELECT Course.CRN, Course.cNum
FROM Course, Teaches, Professor
WHERE Course.CRN = Teaches.CRN
AND Teaches.eID = Professor.eID
AND Professor.Name = 'Lisa';

-- Replace a course with a new one
DELETE FROM Teaches
WHERE CRN = 1111;
DELETE FROM Attends
USING Attends, Section
WHERE Attends.secNum = Section.sNum AND Section.CRN = 1111;
DELETE FROM Section WHERE CRN = 1111;

UPDATE Course
SET Name = 'Algebra III', cNum = 'MATH 1010', Location = 'Building 1',
Time = '9:00 - 11:00', Location = 'Building 2', dName = 'Mathematics'
WHERE CRN = 1111;
INSERT INTO Section (sNum, CRN, TA) VALUES
(1, 1111, 2000001),
(2, 1111, 2000002),
(3, 1111, 2000003);

INSERT INTO Teaches (eID, CRN) VALUES
(100001, 1111);

-- Show all the sections of a course and all the students in each section
SELECT Course.cNum, Section.sNum, Student.sID
FROM Course, Section, Student, Attends
WHERE Course.CRN = Section.CRN
AND Attends.secNum = Section.sID
AND Attends.sID = Student.sID;

-- List of projects in CS department with leading prof. and students
SELECT Project.Name AS ProjectName, Professor.Name AS LeadName, Student.Name AS StudentName
FROM Project, Professor, Student, Assist
WHERE Professor.dName = "Computer Science"
AND Project.pLead = Professor.eID
AND Project.Name = Assist.pName
AND Assist.sID = Student.sID;

-- Clubs can reserve space in an amenity building with a stated room and time
INSERT INTO Reserve (clubName, aName, room, reserveTime) VALUES
('Puzzle Club', 'Amenity 2', 'bathroom', '1/1/2023');

-- Change club sponsor

UPDATE Club
SET Sponsor = 100005
WHERE Name = 'Computer Club';
-- SELECT * FROM CLUB;

-- SELECT * FROM Amenity, Staff Where Amenity.M_EID = Staff.eID;

-- Attempt to delete staff member tasked with maintenance (should fail)
DELETE FROM Staff WHERE eID = 100041;

-- List of students under a given advisor
-- SELECT * FROM Advisor;
SELECT Student.sID, Student.Name
FROM Student, Advisor
WHERE Student.advisorID = Advisor.eID AND Advisor.Name = "Henry";

-- Change project lead
UPDATE Project
SET pLead = 100002
WHERE Name = 'Math theory';
-- SELECT * FROM Project, Professor WHERE Project.pLead = Professor.eID;

-- Create a new course
-- SELECT * FROM Course;
INSERT INTO Course VALUES
(1131, 'Al Usage', 'CS 4010', '11:00 - 1:00', 'Building 2', 'Computer Science');

-- Generate list of students in the Puzzle Club
SELECT Student.sID, Student.Name
FROM Student, Part_Of
WHERE Student.sID = Part_Of.sID
AND Part_Of.cName = 'Puzzle Club';

-- Query reserve record of Amenity 2
SELECT *
FROM Reserve
WHERE aName = 'Amenity 2';

-- Register a student to a section
SELECT * FROM Section, Attends WHERE Section.sID = Attends.secNum;
INSERT INTO Attends (sID, secNum) VALUES
(2000004, 6);