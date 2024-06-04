CREATE TABLE history_Patients_details (
  Patient_ID INT,
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
  
  action_type VARCHAR(50) NOT NULL,
  action_date DATETIME NOT NULL,
  action_by VARCHAR(20) NOT NULL CHECK (action_by IN ('PATIENT','DOCTOR')),
  action_name VARCHAR(20) not NULL
);

CREATE TABLE history_Doctor_details (
  Provider_id INT,
  First_name VARCHAR(100) NOT NULL, 
  Last_name VARCHAR(100) NOT NULL,
  Specialty VARCHAR(50) NOT NULL, 
  Phone_number VARCHAR(20) NOT NULL,
  Email_address VARCHAR(100),
    
  action_type VARCHAR(50) NOT NULL,
  action_date DATETIME NOT NULL,
  action_by VARCHAR(20) NOT NULL CHECK (action_by IN ('PATIENT','DOCTOR')),
  action_name VARCHAR(20) not NULL
);

CREATE TABLE history_Insurance_details (
    Insurance_provider VARCHAR(50),
    Insurance_id VARCHAR(50),
    Insurance_group VARCHAR(50),
    
    action_type VARCHAR(50) NOT NULL,
    action_date DATETIME NOT NULL,
    action_by VARCHAR(20) NOT NULL CHECK (action_by IN ('PATIENT','DOCTOR')),
    action_name VARCHAR(20) not NULL
);

CREATE TABLE history_Insurance (

    Patient_ID iNT NOT NULL,
    Insurance_id VARCHAR(50) NOT NULL,
    
    
    action_type VARCHAR(50) NOT NULL,
    action_date DATETIME NOT NULL,
    action_by VARCHAR(20) NOT NULL CHECK (action_by IN ('PATIENT','DOCTOR')),
    action_name VARCHAR(20) not NULL
);





CREATE TABLE history_Clinicalcare_details (
    
    
    Care_id INT, 
    Visit_id INT NOT NULL, 
    Diagnosis VARCHAR(700), 
    Symptoms VARCHAR(700),
    Prescription VARCHAR(700), 
    Lab_order VARCHAR(700), 
    Lab_results VARCHAR(700),
    
    action_type VARCHAR(50) NOT NULL,
    action_date DATETIME NOT NULL,
    action_by VARCHAR(20) NOT NULL CHECK (action_by IN ('PATIENT','DOCTOR')),
    action_name VARCHAR(20) not NULL
);

CREATE TABLE history_Visit_details (
   
    
  Visit_id INT PRIMARY KEY, 
  Patient_id INT NOT NULL, 
  Provider_id INT NOT NULL,
  Facility VARCHAR(100) NOT NULL, 
  Visit_date DATE NOT NULL, 
  Visit_time TIME NOT NULL,
  Exam_room VARCHAR(20), 
  Billing_code VARCHAR(20),
  
  action_type VARCHAR(50) NOT NULL,
  action_date DATETIME NOT NULL,
  action_by VARCHAR(20) NOT NULL CHECK (action_by IN ('PATIENT','DOCTOR')),
  action_name VARCHAR(20) not NULL
);


CREATE TABLE history_Billing_details (
  Billing_id INT PRIMARY KEY,
  Visit_id INT NOT NULL,
  Total_charge DECIMAL(10,2) NOT NULL,
  Payment_amount DECIMAL(10,2) NOT NULL, 
  Balance_due DECIMAL(10,2) NOT NULL,
  
  action_type VARCHAR(50) NOT NULL,
  action_date DATETIME NOT NULL,
  action_by VARCHAR(20) NOT NULL CHECK (action_by IN ('PATIENT','DOCTOR')),
  action_name VARCHAR(20) not NULL
);

CREATE TABLE history_Supplies (
  Supply_id INT, 
  Name VARCHAR(100) NOT NULL,
  Description VARCHAR(700),
  Quantity INT NOT NULL, 
  Supplier_name VARCHAR(100), 
  Supplier_phonenumber VARCHAR(20), 
  Supplier_emailadress VARCHAR(100),
  
  action_type VARCHAR(50) NOT NULL,
  action_date DATETIME NOT NULL,
  action_by VARCHAR(20) NOT NULL CHECK (action_by IN ('PATIENT','DOCTOR')),
  action_name VARCHAR(20) not NULL
  
);

CREATE TABLE history_Exam_Room (
  Room_id INT PRIMARY KEY, 
  Facility VARCHAR(100) NOT NULL,
  Room_number VARCHAR(20) NOT NULL,
  
  action_type VARCHAR(50) NOT NULL,
  action_date DATETIME NOT NULL,
  action_by VARCHAR(20) NOT NULL CHECK (action_by IN ('PATIENT','DOCTOR')),
  action_name VARCHAR(20) not NULL
  
  
);




DELIMITER //
CREATE FUNCTION get_username(userid INT, useris varchar(20))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	
  DECLARE uname VARCHAR(50);
  SELECT username INTO uname FROM auth WHERE user_id = userid and user_is = useris;
  RETURN uname;
END //
DELIMITER ;

#update------

DROP TRIGGER IF EXISTS trigger_before_updateing_patient;
DELIMITER //
CREATE TRIGGER trigger_before_updateing_patient
BEFORE UPDATE ON Patients_details
FOR EACH ROW
BEGIN
	INSERT INTO history_Patients_details (Patient_ID, First_name, Last_name, dob, Phone_number, Email_address, Address, City, State, ZipCode,action_type, action_date,action_by,action_name) 
    VALUES (old.Patient_ID, old.First_name, old.Last_name, old.dob, old.Phone_number, old.Email_address, old.Address, old.City, old.State, old.ZipCode, 'Updated', NOW(),'PATIENT',get_username(OLD.Patient_ID,'PATIENT'));
END //
DELIMITER ;




DROP TRIGGER IF EXISTS trigger_before_updateing_visit_details;
DELIMITER //
CREATE TRIGGER trigger_before_updateing_visit_details
BEFORE UPDATE ON Visit_details
FOR EACH ROW
BEGIN
	INSERT INTO  history_visit_details(Visit_id, Patient_id, Provider_id, Facility, Visit_date, Visit_time, Exam_room, Billing_code,action_type, action_date,action_by,action_name) 
    VALUES (old.Visit_id, old.Patient_id, old.Provider_id, old.Facility, old.Visit_date, old.Visit_time, old.Exam_room, old.Billing_code, 'Updated', NOW(),'DOCTOR',get_username(old.provider_id,'DOCTOR'));
END //
DELIMITER ;
	

DROP TRIGGER IF EXISTS trigger_before_updateing_insurance_details;
DELIMITER //
CREATE TRIGGER trigger_before_updateing_insurance_details
BEFORE UPDATE ON Insurance_details
FOR EACH ROW
BEGIN
	INSERT INTO history_Insurance_details (Insurance_provider, Insurance_id, Insurance_group,action_type, action_date,action_by,action_name) 
    VALUES (old.Insurance_provider, old.Insurance_id, old.Insurance_group, 'Updated', NOW(),'PATIENT', get_username((select patient_id from insurance where insurance_id=(OLD.Insurance_id,'PAIENT'))));
END //
DELIMITER ;
select distinct patient_id from insurance where insurance_id = 8;
select distinct patient_id from insurance where insurance_id = 8;
select get_username((select distinct patient_id from insurance where insurance_id));

DROP TRIGGER IF EXISTS trigger_before_updateing_Clinicalcare_details;
DELIMITER //
CREATE TRIGGER trigger_before_updateing_Clinicalcare_details
BEFORE UPDATE ON Clinicalcare_details
FOR EACH ROW
BEGIN
	INSERT INTO history_Clinicalcare_details (Care_id, Visit_id, Diagnosis, Symptoms, Prescription, Lab_order, Lab_results,action_type, action_date,action_by,action_name) 
    VALUES (old.Care_id, old.Visit_id, old.Diagnosis, old.Symptoms, old.Prescription, old.Lab_order, old.Lab_results, 'Updated', NOW(),'DOCTOR',
    get_username( (select provider_id from visit_details where visit_id = (OLD.visit_id,'DOCTOR'))));
END //

DELIMITER ;

#insert---------


DROP TRIGGER IF EXISTS trigger_after_inserting_Patients_details;
DELIMITER //
CREATE TRIGGER trigger_after_inserting_Patients_details
AFTER INSERT ON Patients_details
FOR EACH ROW
BEGIN
	INSERT INTO history_Patients_details (Patient_ID, First_name, Last_name, dob, Phone_number, Email_address, Address, City, State, ZipCode,action_type, action_date,action_by,action_name) 
    VALUES (new.Patient_ID, new.First_name, new.Last_name, new.dob, new.Phone_number, new.Email_address, new.Address, new.City, new.State, new.ZipCode, 'inserted', NOW(),'PATIENT',new.First_name);
	
END //
DELIMITER ;





DROP TRIGGER IF EXISTS trigger_after_inserting_visit_details;
DELIMITER //
CREATE TRIGGER trigger_after_inserting_visit_details
AFTER INSERT ON Visit_details
FOR EACH ROW
BEGIN
	INSERT INTO  history_Visit_details(Visit_id, Patient_id, Provider_id, Facility, Visit_date, Visit_time, Exam_room, Billing_code,action_type, action_date,action_by,action_name) 
    VALUES (new.Visit_id, new.Patient_id, new.Provider_id, new.Facility, new.Visit_date, new.Visit_time, new.Exam_room, new.Billing_code, 'Updated', NOW(),'PATIENT',get_username(NEW.patient_id,'PATIENT'));
END //
DELIMITER ;



#new
DROP TRIGGER IF EXISTS trigger_after_inserting_insurance_details;
DELIMITER //
CREATE TRIGGER trigger_after_inserting_insurance_details
AFTER INSERT ON Insurance_details
FOR EACH ROW
BEGIN
	INSERT INTO history_Insurance_details (Insurance_provider, Insurance_id, Insurance_group,action_type, action_date,action_by,action_name) 
    VALUES (new.Insurance_provider, new.Insurance_id, new.Insurance_group, 'inserted', NOW(),'PATIENT',
    get_username((select patient_id from insurance where insurance_id = (new.insurance_id,'PATIENT'))));
END //
DELIMITER ;



#new
DROP TRIGGER IF EXISTS trigger_after_inserting_Clinicalcare_details;
DELIMITER //
CREATE TRIGGER trigger_after_inserting_Clinicalcare_details
AFTER INSERT ON Clinicalcare_details
FOR EACH ROW
BEGIN
	INSERT INTO history_Clinicalcare_details (Care_id, Visit_id, Diagnosis, Symptoms, Prescription, Lab_order, Lab_results,action_type, action_date,action_by,action_name) 
    VALUES (new.Care_id, new.Visit_id, new.Diagnosis, new.Symptoms, new.Prescription, new.Lab_order, new.Lab_results, 'inserted', NOW(),'DOCTOR',
    get_username( (select distinct provider_id from visit_details where visit_id = new.visit_id),'DOCTOR' ));
END //
DELIMITER ;

#---------------

#deleting---


DROP TRIGGER IF EXISTS trigger_before_deleteing_visit_details;
DELIMITER //
CREATE TRIGGER trigger_before_deleteing_visit_details
BEFORE DELETE ON Visit_details
FOR EACH ROW
BEGIN
	INSERT INTO  history_visit_details(Visit_id, Patient_id, Provider_id, Facility, Visit_date, Visit_time, Exam_room, Billing_code,action_type, action_date,action_by,action_name) 
    VALUES (old.Visit_id, old.Patient_id, old.Provider_id, old.Facility, old.Visit_date, old.Visit_time, old.Exam_room, old.Billing_code, 'deleted', NOW(),'PATIENT',get_username(old.patient_id,'PATIENT'));
END //
DELIMITER ;




#new
DROP TRIGGER IF EXISTS trigger_before_deleteing_insurance_details;
DELIMITER //
CREATE TRIGGER trigger_before_deleteing_insurance_details
BEFORE DELETE ON Insurance_details
FOR EACH ROW
BEGIN
	INSERT INTO history_Insurance_details (Insurance_provider, Insurance_id, Insurance_group,action_type, action_date,action_by,action_name) 
    VALUES (old.Insurance_provider, old.Insurance_id, old.Insurance_group, 'deleted', NOW(),'PATIENT',
    get_username((select patient_id from insurance where insurance_id = (old.insurance_id,'PATIENT'))));
END //
DELIMITER ;



#new
DROP TRIGGER IF EXISTS trigger_before_deleteing_Clinicalcare_details;
DELIMITER //
CREATE TRIGGER trigger_before_deleteing_Clinicalcare_details
BEFORE DELETE ON Clinicalcare_details
FOR EACH ROW
BEGIN
	INSERT INTO history_Clinicalcare_details (Care_id, Visit_id, Diagnosis, Symptoms, Prescription, Lab_order, Lab_results,action_type, action_date,action_by,action_name) 
    VALUES (old.Care_id, old.Visit_id, old.Diagnosis, old.Symptoms, old.Prescription, old.Lab_order, old.Lab_results, 'delete', NOW(),'DOCTOR',
    get_username( (select distinct provider_id from visit_details where visit_id(old.visit_id,'DOCTOR')) ));
END //
DELIMITER ;