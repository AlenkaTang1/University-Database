-- CREATE SCHEMA db_project;
-- USE db_project;


-- Entities
CREATE TABLE Course (
	CRN int NOT NULL,
    Name varchar(255) NOT NULL,
    cNum varchar(255) NOT NULL,
    Time varchar(255) NOT NULL,
    Location varchar(255) NOT NULL,
    dName varchar(255) NOT NULL,
    PRIMARY KEY (CRN)
);

CREATE TABLE Section (
	sNum int NOT NULL,
    sID int NOT NULL AUTO_INCREMENT,
    CRN int NOT NULL,
    TA int NOT NULL,
    PRIMARY KEY (sID, CRN)
);

CREATE TABLE Professor (
	eID int NOT NULL,
    SSN int NOT NULL,
    Name varchar(255) NOT NULL,
    Email varchar(255) NOT NULL,
    HireDate DATE NOT NULL,
    dName varchar(255) NOT NULL,
    PRIMARY KEY (eID)
);

CREATE TABLE Student (
	sID int NOT NULL,
    Name varchar(255) NOT NULL,
    Bday DATE NOT NULL,
    SSN int NOT NULL,
    Address varchar(255) NOT NULL,
    Email varchar(255) NOT NULL,
    advisorID int NOT NULL,
    
    PRIMARY KEY (sID)
);

CREATE TABLE Department (
	Name varchar(255) NOT NULL,
    PRIMARY KEY (Name)
);

CREATE TABLE Advisor (
	eID int NOT NULL,
    SSN int NOT NULL,
    Email varchar(255) NOT NULL,
    Name varchar(255) NOT NULL,
    PRIMARY KEY (eID)
);

CREATE TABLE Project (
	Name varchar(255) NOT NULL,
    Description varchar(255) NOT NULL,
    pLead int NOT NULL,
    PRIMARY KEY (Name)
);

CREATE TABLE Club (
	Name varchar(255) NOT NULL,
    Description varchar(255) NOT NULL,
    Budget int NOT NULL,
    President int NOT NULL,
    Sponsor int NOT NULL,
    Funds int NOT NULL,
    dName varchar(255) NOT NULL,
    PRIMARY KEY (Name)
);

CREATE TABLE Amenity (
	Name varchar(255) NOT NULL,
    Address varchar(255) NOT NULL,
    M_EID int NOT NULL,
    PRIMARY KEY (Name)
);

CREATE TABLE Staff (
	eID int NOT NULL,
    Salary int NOT NULL,
    Name varchar(255) NOT NULL,
    Email varchar(255) NOT NULL,
    PRIMARY KEY (eID)
);

CREATE TABLE TA (
	sID int NOT NULL,
    Office_Hours varchar(255) NOT NULL,
    Location varchar(255) NOT NULL,
    PRIMARY KEY (sID)
);


-- Relations 
-- CREATE TABLE Offers (
-- 	dName varchar(255) NOT NULL,
--     CRN int NOT NULL,
--     rID int NOT NULL AUTO_INCREMENT,
--     PRIMARY KEY (rID)
-- );

-- CREATE TABLE Reports_To (
-- 	dName varchar(255) NOT NULL,
--     clubName varchar(255) NOT NULL,
-- 	rID int NOT NULL AUTO_INCREMENT,
-- 	PRIMARY KEY (rID)
-- ); 

CREATE TABLE Attends (
	sID int NOT NULL,
    secNum int NOT NULL,
    rID int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (rID)
);

-- CREATE TABLE TA (
-- 	sID int NOT NULL,
--     secNum int NOT NULL,
--     rID int NOT NULL AUTO_INCREMENT,
--     PRIMARY KEY (sID, secNum, rID),
--     FOREIGN KEY (secNum) REFERENCES Section(secNum),
--     FOREIGN KEY (sID) REFERENCES Student(sID)
-- );

CREATE TABLE Teaches (
	eID int NOT NULL,
    rID int NOT NULL AUTO_INCREMENT,
    CRN int NOT NULL,
    PRIMARY KEY (rID)
);

CREATE TABLE Works_For (
	dName varchar(255) NOT NULL,
    eID int NOT NULL,
	rID int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (rID)
); 

-- CREATE TABLE Sponsor (
-- 	clubName varchar(255) NOT NULL,
--     eID int NOT NULL,
-- 	rID int NOT NULL AUTO_INCREMENT,
-- 	PRIMARY KEY (rID)
-- ); 

CREATE TABLE Assist (
	pName varchar(255) NOT NULL,
    sID int NOT NULL,
	rID int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (rID)
); 

CREATE TABLE Manages (
	cName varchar(255) NOT NULL,
    sID int NOT NULL,
	rID int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (rID)
); 

CREATE TABLE Part_Of (
	cName varchar(255) NOT NULL,
    sID int NOT NULL,
	rID int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (rID)
); 

CREATE TABLE Student_Staff (
	eID int NOT NULL,
    sID int NOT NULL,
	rID int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (rID)
); 

CREATE TABLE Advise (
	sID int NOT NULL,
    eID int NOT NULL,
	rID int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (rID)
); 


-- CREATE TABLE Maintain (
-- 	aName varchar(255) NOT NULL,
--     eID int NOT NULL,
-- 	rID int NOT NULL AUTO_INCREMENT,
-- 	PRIMARY KEY (aName, eID, rID),
--     FOREIGN KEY (aName) REFERENCES Amenity(Name),
--     FOREIGN KEY (eID) REFERENCES Staff(eID)
-- ); 

CREATE TABLE Reserve (
	clubName varchar(255) NOT NULL,
    aName varchar(255) NOT NULL,
    room varchar(255) NOT NULL,
    reserveTime varchar(255) NOT NULL,
	rID int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (rID)
); 

-- CREATE TABLE Project_Lead (
-- 	pName varchar(255) NOT NULL,
--     eID int NOT NULL,
-- 	rID int NOT NULL AUTO_INCREMENT,
-- 	PRIMARY KEY (rID)
-- ); 

-- Add foreign Keys

ALTER TABLE Course
ADD FOREIGN KEY (dName) REFERENCES Department(Name);

ALTER TABLE Section
ADD FOREIGN KEY (CRN) REFERENCES Course(CRN);
ALTER TABLE Section
ADD	FOREIGN KEY (TA) REFERENCES Student(sID);

ALTER TABLE Club
ADD (FOREIGN KEY (President) REFERENCES Student(sID),
	FOREIGN KEY (Sponsor) REFERENCES Professor(eID),
    FOREIGN KEY (dName) REFERENCES Department(Name));
    
ALTER TABLE Project
ADD FOREIGN KEY (pLead) REFERENCES Professor(eID);

ALTER TABLE Amenity
ADD FOREIGN KEY (M_EID) REFERENCES Staff(eID);

-- ALTER TABLE Offers
-- ADD (FOREIGN KEY (dName) REFERENCES Department(Name),
--     FOREIGN KEY (CRN) REFERENCES Course(CRN));

-- ALTER TABLE Reports_To
-- ADD (FOREIGN KEY (dName) REFERENCES Department(Name),
--     FOREIGN KEY (clubName) REFERENCES Club(Name));
    
ALTER TABLE Attends
ADD (FOREIGN KEY (secNum) REFERENCES Section(sID),
    FOREIGN KEY (sID) REFERENCES Student(sID));

ALTER TABLE Teaches
ADD (FOREIGN KEY (eID) REFERENCES Professor(eID),
    FOREIGN KEY (CRN) REFERENCES Course(CRN));
    
-- ALTER TABLE Works_For
-- ADD (FOREIGN KEY (dName) REFERENCES Department(Name),
--     FOREIGN KEY (eID) REFERENCES Professor(eID));

-- ALTER TABLE Sponsor
-- ADD (FOREIGN KEY (clubName) REFERENCES Club(Name),
--     FOREIGN KEY (eID) REFERENCES Professor(eID));
    
ALTER TABLE Assist
ADD (FOREIGN KEY (pName) REFERENCES Project(Name),
    FOREIGN KEY (sID) REFERENCES Student(sID));
    
ALTER TABLE Manages
ADD (FOREIGN KEY (cName) REFERENCES Club(Name),
    FOREIGN KEY (sID) REFERENCES Student(sID));

ALTER TABLE Part_Of
ADD (FOREIGN KEY (cName) REFERENCES Club(Name),
    FOREIGN KEY (sID) REFERENCES Student(sID));

ALTER TABLE Student_Staff
ADD (FOREIGN KEY (eID) REFERENCES Staff(eID),
    FOREIGN KEY (sID) REFERENCES Student(sID));
    
-- ALTER TABLE Advise
-- ADD (FOREIGN KEY (sID) REFERENCES Student(sID),
--     FOREIGN KEY (eID) REFERENCES Advisor(eID));

ALTER TABLE Reserve
ADD (FOREIGN KEY (aName) REFERENCES Amenity(Name),
    FOREIGN KEY (clubName) REFERENCES Club(Name));

-- ALTER TABLE Project_Lead
-- ADD (FOREIGN KEY (pName) REFERENCES Project(Name),
--     FOREIGN KEY (eID) REFERENCES Professor(eID));

-- Add constraints

-- One TA per section, TA's can only be assigned to one section
ALTER TABLE Section
ADD CONSTRAINT UNIQUE (TA); -- Adding the same TA twice requires a duplicate TA id
ALTER TABLE Section
ADD CONSTRAINT UNIQUE (sNum, CRN); -- Adding a second TA will require duplicates of sNum and CRN
ALTER TABLE Attends
ADD CONSTRAINT UNIQUE (sID, secNum); -- Registering the same student to the same section is not allowed

ALTER TABLE Teaches
ADD CONSTRAINT UNIQUE (eID, CRN); -- Assigning the same teacher to the same course is not allowed

-- No duplicate relations
ALTER TABLE Assist
ADD CONSTRAINT UNIQUE (pName, sID);

ALTER TABLE Manages
ADD CONSTRAINT UNIQUE (cName, sID);

ALTER TABLE Part_Of
ADD CONSTRAINT UNIQUE (cName, sID);

ALTER TABLE Student_Staff
ADD CONSTRAINT UNIQUE (sID, eID);

-- No making the same reservation twice
ALTER TABLE Reserve
ADD CONSTRAINT UNIQUE (aName, room, reserveTime);