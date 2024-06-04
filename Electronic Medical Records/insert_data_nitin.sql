insert into Auth (username,userpassword,user_is,user_id) values
('jack', '1234','patient',2 ),
('john', '1234','patient',1 ),
('smith', '1234','patient',3 ),
('smith', '12345','patient',4 ),
('joye', '1234','patient',5 ),
('John','1234','doctor',1),
( 'Jack', '1234','doctor',2),
( 'Smith','1234','doctor',3),
( 'Jack','1234','doctor',4),
( 'Daniel','1234','doctor',5),
( 'Alicia','1234','doctor',6);




INSERT INTO Patients_details (Patient_ID, First_name, Last_name, dob, Phone_number, Email_address, Address, City, State, ZipCode)
VALUES
  (1, 'John', 'Doe', '1990-01-01', '1234567890', 'john.doe@email.com', '321 Main St', 'Uptown', 'LA', '24531'),
  (2, 'Jack', 'troy', '1985-06-15', '0987654321', 'jack.troy@email.com', '456 Elm St', 'Downtown', 'NY', '55321'),
  (3, 'Smith', 'Johnson', '1972-03-22', '2485673289', 'smith.johnson@email.com', '789 Oak St', 'Smallville', 'IL','33242'),
  (4, 'Smith', 'Jr', '1995-03-26', '9988324578', 'smith.jr@email.com', '987 Main St', 'detroit', 'MI', '69870'),
  (5, 'joye', 'sr', '2000-03-28', '9898324578', 'joye.sr@email.com', '789 Sam St', 'Charlotte', 'NC', '67098');
  
 

INSERT INTO Insurance_details (Insurance_provider, Insurance_id, Insurance_group)
VALUES 
('AMB Insurance', '1', 'Group one'),
('XYZ Insurance', '2', 'Group two'),
('NLP Insurance', '3', 'Group A'),
('JQ Insurance', '4', 'Group B'),
('HKM Insurance', '5', 'Group D');


INSERT INTO Insurance (Patient_ID, Insurance_id)
VALUES 
(1, '1'),
(2, '2'),
(3, '3'),
(4, '4'),
(5, '5');

  
INSERT INTO Doctor_details (Provider_id, First_name, Last_name, Specialty, Phone_number, Email_address)
VALUES
    (1, 'John', 'doe', 'Cardiology', '321-465-7980', 'johnwille@email.com'),
    (2, 'Jack', 'troy', 'Pediatrics', '765-895-4455', 'jacktroy@email.com'),
    (3, 'Smith', 'Johnson', 'Dermatology', '767-745-7447', 'smithjohnson@email.com'),
    (4, 'Jack', 'Johnson', 'Pediatrics', '523-535-5654', 'sarah.johnson@pediatrics.com'),
    (5, 'Daniel', 'Smith', 'Cardiology', '267-545-5995', 'daniel.smith@cardiology.com'),
    (6, 'Alicia', 'Garcia', 'Dermatology', '456-855-5566', 'alicia.garcia@dermatology.com');
    
    
UPDATE Doctor_details
SET Last_name = 'Will'
WHERE Provider_id = '1';



    
INSERT INTO Visit_details (Visit_id, Patient_id, Provider_id, Facility, Visit_date, Visit_time, Exam_room, Billing_code)
VALUES
(1, 1, 1, 'AMB Hospital', '2023-03-01', '10:00:00', 'Room number 101', '1122'),
(2, 2, 2, 'XYZ Clinic', '2023-03-02', '11:00:00', 'Room number 102', '3254'),
(3, 3, 3, 'PQR Hospital', '2023-03-03', '14:00:00', 'Room number 103', '7869'),
(4, 4, 4, 'ABC Hospital', '2023-03-04', '15:00:00', 'Room number 104', '1414'),
(5, 5, 5, 'XZY Clinic', '2023-03-05', '16:00:00', 'Room number 105', '1551'),
(6, 1, 2, 'PQR Hospital', '2023-03-06', '17:00:00', 'Room number 106', '2345'),
(7, 2, 3, 'ABC Hospital', '2023-03-07', '18:00:00', 'Room number 107', '8763');


INSERT INTO Clinicalcare_details (Care_id, Visit_id, Diagnosis, Symptoms, Prescription, Lab_order, Lab_results)
VALUES
(1, 1, 'Pneumonia', 'Cough, fever, shortness of breath', 'Azithromycin 500mg, Prednisone 10mg', 'Chest X-ray, CBC, sputum culture', 'Positive for Streptococcus pneumoniae'),
(2, 2, 'Diabetes', 'Increased thirst, frequent urination', 'Metformin 500mg', 'Blood glucose test', 'High blood glucose levels'),
(3, 3, 'Hypertension', 'Headache, dizziness, chest pain', 'Losartan 50mg', 'Electrocardiogram', 'Normal'),
(4, 4, 'Asthma', 'Wheezing, shortness of breath', 'Albuterol inhaler', 'Lung function test', 'Mild obstruction'),
(5, 5, 'Acute otitis media', 'Ear pain, fever', 'Amoxicillin 500mg', 'Ear examination', 'Infection'),
(6, 6, 'Migraine', 'Throbbing headache, sensitivity to light and sound', 'Sumatriptan 100mg', '-', '-'),
(7, 7, 'Sinusitis', 'Facial pain, congestion, postnasal drip', 'Amoxicillin 500mg', 'Sinus X-ray', 'Mucosal thickening and sinus blockage');

UPDATE  Clinicalcare_details
SET Diagnosis = 'Diabetes'
WHERE Care_id = '4';

INSERT INTO Exam_Room (Room_id, Facility, Room_number)
VALUES (1, 'AMB Hospital', '101'),
       (2, 'EMR Hospital', '102'),
       (3, 'ABC Hospital', '103'),
       (4, 'XYZ Clinic', '221'),
       (5, 'PQR Clinic', '222');
       
INSERT INTO Supplies (Supply_id, Name, Description, Quantity, Supplier_name, Supplier_phonenumber, Supplier_emailadress) 
VALUES 
(1, 'Bandages', 'Assorted sizes of adhesive bandages', 100, 'ABC Medical Supplies', '565-1234', 'abcmedsupp@email.com'),
(2, 'Gauze', 'Sterile gauze pads for wound care', 200, 'XYZ Health Products', '455-5678', 'xyzhealth@email.com'),
(3, 'Antiseptic solution', 'Antibacterial solution for cleaning wounds', 50, 'Acme Medical Supply', '555-2468', 'acmemedsupp@email.com');
INSERT INTO Supplies (Supply_id, Name, Description, Quantity, Supplier_name, Supplier_phonenumber, Supplier_emailadress)
VALUES 

  (4, 'Band-Aids', 'Assorted sizes of adhesive bandages', 500, 'Johnson & Johnson', '354-1234', 'jandjson@email.com'),
  (5, 'Latex Gloves', 'Disposable gloves for medical use', 2000, 'Medline', '555-5678', 'medline@email.com');

  
INSERT INTO Billing_details (Billing_id, Visit_id, Total_charge, Payment_amount, Balance_due)
VALUES 
  (1, 1, 150.00, 0.00, 150.00),
  (2, 2, 1500.00, 1000.00, 500.00),
  (3, 3, 2000.00, 1500.00, 500.00),
  (4, 4, 750.00, 0.00, 750.00),
  (5, 5, 125.00, 125.00, 0.00);
  
       




