/* Database Electronic_Medical_Record create  */

CREATE DATABASE Electronic_Medical_Record_2;

USE Electronic_Medical_Record_2;

/* Database create Electronic_Medical_Record End */

/* Patients_details start */

CREATE TABLE Patients_details (
  Patient_ID INT PRIMARY KEY auto_increment ,
  First_name VARCHAR(100) NOT NULL,
  Last_name VARCHAR(100) NOT NULL,
  -- date of birth --
  dob DATE NOT NULL,
  Phone_number VARCHAR(20) NOT NULL UNIQUE, 
  Email_address VARCHAR(100) NOT NULL UNIQUE,
  Address VARCHAR(150) NOT NULL, 
  City VARCHAR(50) NOT NULL, 
  State VARCHAR(50) NOT NULL, 
  ZipCode VARCHAR(15) NOT NULL,
  index(Patient_ID)
);
/* Patients_details End */

CREATE TABLE Insurance_details(
	Insurance_provider VARCHAR(50),
    Insurance_id int NOT NULL PRIMARY KEY  auto_increment,
    Insurance_group VARCHAR(50), index(Insurance_id) );
    
CREATE TABLE Insurance(
	Patient_ID iNT NOT NULL,
    Insurance_id int NOT NULL,
    CONSTRAINT fk_Insurancepatient FOREIGN KEY (Patient_id) REFERENCES Patients_details(Patient_id)  ON DELETE CASCADE
    ON UPDATE CASCADE,   
    CONSTRAINT fk_Insurance FOREIGN KEY (Insurance_id) REFERENCES Insurance_details(Insurance_id)  ON DELETE CASCADE
    ON UPDATE CASCADE );

    
    
	/* Doctor_details start */
CREATE TABLE Doctor_details (
  Provider_id INT PRIMARY KEY  auto_increment,
  First_name VARCHAR(100) NOT NULL, 
  Last_name VARCHAR(100) NOT NULL,
  Specialty VARCHAR(50) NOT NULL, 
  Phone_number VARCHAR(20) NOT NULL,
  Email_address VARCHAR(100), index( Provider_id)
);
 /* Doctor_details end */

   /* Visit_details start */
CREATE TABLE Visit_details (
  Visit_id INT PRIMARY KEY  auto_increment, 
  Patient_id INT NOT NULL, 
  Provider_id INT NOT NULL,
  Facility VARCHAR(100) NOT NULL, 
  Visit_date DATE NOT NULL, 
  Visit_time TIME NOT NULL,
  Exam_room VARCHAR(20), 
  Billing_code VARCHAR(20),
  CONSTRAINT fk_PatientVisit FOREIGN KEY (Patient_id) REFERENCES Patients_details(Patient_id)  ON DELETE CASCADE
    ON UPDATE CASCADE,	
  CONSTRAINT fk_ProviderVisit FOREIGN KEY (Provider_id) REFERENCES Doctor_details(Provider_id)  ON DELETE CASCADE
    ON UPDATE CASCADE, index(Visit_id)
);
 /* Visit_details end */

 /* Clinicalcare_details start */
CREATE TABLE Clinicalcare_details (
  Care_id INT PRIMARY KEY  auto_increment, 
  Visit_id INT NOT NULL, 
  Diagnosis VARCHAR(700), 
  Symptoms VARCHAR(700),
  Prescription VARCHAR(700), 
  Lab_order VARCHAR(700), 
  Lab_results VARCHAR(700),
  CONSTRAINT fk_VisitCare FOREIGN KEY (Visit_id) REFERENCES Visit_details(Visit_id)  ON DELETE CASCADE
  ON UPDATE CASCADE, index(Care_id));
  

 /* Clinicalcare_details end */
 
 /* Exam_Room start */
CREATE TABLE Exam_Room (
  Room_id INT PRIMARY KEY  auto_increment, 
  Facility VARCHAR(100) NOT NULL, 
  Room_number VARCHAR(20) NOT NULL, index(Room_id)
);
 /* Exam_Room end */


 /* Supplies start */
CREATE TABLE Supplies (
  Supply_id INT PRIMARY KEY  auto_increment, 
  Name VARCHAR(100) NOT NULL,
  Description VARCHAR(700),
  Quantity INT NOT NULL, 
  Supplier_name VARCHAR(100), 
  Supplier_phonenumber VARCHAR(20), 
  Supplier_emailadress VARCHAR(100), index(Supply_id)
);
/* Supplies end */

/* Billing_details start */
CREATE TABLE Billing_details (
  Billing_id INT PRIMARY KEY  auto_increment,
  Visit_id INT NOT NULL,
  Total_charge DECIMAL(10,2) NOT NULL,
  Payment_amount DECIMAL(10,2) NOT NULL, 
  Balance_due DECIMAL(10,2) NOT NULL,
  CONSTRAINT f_VisitBilling FOREIGN KEY (Visit_id) REFERENCES Visit_details(Visit_id)  ON DELETE CASCADE
    ON UPDATE CASCADE, index(Billing_id)
);
/* Billing_details end */

/* updating the database queries of patients_details */

CREATE TABLE Auth(
	username varchar(20),
	userpassword varchar(100),
	user_is varchar(20) NOT NULL,
    user_id INT,
    INDEX(user_id)
);




UPDATE Patients_details
SET Address = '345 Main St', City = 'Downtown', State = 'LA', ZipCode = '45456'
WHERE Patient_ID = 4;

UPDATE Patients_details
SET Patient_ID = 100
WHERE Patient_ID = 4;

SELECT * FROM Patients_details;

/* updating the database queries of */
UPDATE Insurance_details
SET Insurance_provider = 'NBK Insurance'
WHERE Insurance_id = 'XYZ001';

SELECT * FROM Insurance_details;

/* deleting */
DELETE FROM patients WHERE id = 1;


/* searching of patient records based on name */
SELECT * FROM Patients_details WHERE First_name = 'Jack' AND Last_name = 'troy';

/* searching of patient records based on id */
SELECT * FROM Patients_details WHERE Patient_id = 1;

/* searching of patient records based on visit date */
SELECT * FROM Patients_details pd
JOIN Visit_details vd ON pd.Patient_id = vd.Patient_id
WHERE vd.Visit_date = '2023-03-04';

/* searching of patient records based on diagnosis  */
SELECT * FROM Patients_details pd
JOIN Visit_details vd ON pd.Patient_id = vd.Patient_id
JOIN Clinicalcare_details cd ON vd.Visit_id = cd.Visit_id
WHERE cd.Diagnosis LIKE '%diabetes%';

/* searching patients who have been seen by a certain doctor */
SELECT pd.Patient_ID, pd.First_name as Patient_First_name, pd.Last_name as Patient_Last_Name, dd.Last_name as Doctor_name 
FROM Patients_details pd
JOIN Visit_details vd ON pd.Patient_ID = vd.Patient_id
JOIN Doctor_details dd ON vd.Provider_id = dd.Provider_id
WHERE dd.Last_name = 'Johnson';


/* function using who have been given certain diagnosis */

DELIMITER //
CREATE FUNCTION Patients_with_certain_Diagnosis(Diagnosis VARCHAR(700))
RETURNS VARCHAR(1000)
READS SQL DATA
BEGIN
    DECLARE patient_list VARCHAR(1000);
    SELECT GROUP_CONCAT(CONCAT(Patients_details.Patient_ID, ': ',Patients_details.First_name, ' ', Patients_details.Last_name)) INTO patient_list
    FROM Patients_details
    INNER JOIN Visit_details ON Patients_details.Patient_ID = Visit_details.Patient_ID
    INNER JOIN Clinicalcare_details ON Visit_details.Visit_id = Clinicalcare_details.Visit_id
    WHERE Clinicalcare_details.Diagnosis LIKE CONCAT('%', Diagnosis, '%');
    RETURN patient_list;
END //
DELIMITER ;


SELECT Patients_with_certain_Diagnosis('Diabetes');


/* function using who have been given certain certain doctor using doctor id */

DELIMITER //
CREATE FUNCTION patients_seen_by_doctor(doctor_id INT)
RETURNS VARCHAR(1000)
READS SQL DATA
BEGIN
    DECLARE patient_list VARCHAR(1000);
    SELECT GROUP_CONCAT(CONCAT(Patients_details.Patient_ID, ': ',Patients_details.First_name, ' ', Patients_details.Last_name)) INTO patient_list
    FROM Patients_details
    INNER JOIN Visit_details ON Patients_details.Patient_ID = Visit_details.Patient_ID
    INNER JOIN Doctor_details ON Visit_details.Provider_id = Doctor_details.Provider_id
    WHERE Doctor_details.Provider_id = doctor_id;
    RETURN patient_list;
END //
DELIMITER ;



SELECT patients_seen_by_doctor('1');


/* function using who have been visited between certain days */
DELIMITER //
CREATE FUNCTION Patients_visited_on_certain_days(date_from DATE, date_to DATE)
RETURNS VARCHAR(1000)
READS SQL DATA
BEGIN
    DECLARE patient_list VARCHAR(1000);
    SELECT GROUP_CONCAT(CONCAT(Patients_details.Patient_ID, ': ',Patients_details.First_name, ' ', Patients_details.Last_name)) INTO patient_list
    FROM Patients_details
    INNER JOIN Visit_details ON Patients_details.Patient_ID = Visit_details.Patient_ID
    WHERE Visit_details.Visit_date BETWEEN date_from AND date_to;
    RETURN patient_list;
END //
DELIMITER ;

SELECT Patients_visited_on_certain_days('2023-03-01', '2023-03-03');











