import mysql.connector
import visit_details as vd

import care_details as cd
import insurance_details as ind
import usables
import hashlib

from database_module import create_db_connection

def checkUrInfo(user_id):
    connection = create_db_connection()
    cursor = connection.cursor() 
    query = "SELECT * FROM patients_details where patient_id = %s"
    values = (user_id,)
    
    # Execute the query
    cursor.execute(query,values)

    # Fetch all the records
    record = cursor.fetchone()

    print("Your Info:")
    print(record)

    cursor.close()
    connection.close()

    return

def editPatientDetails(user_id):
    connection = create_db_connection()
    cursor = connection.cursor()
    First_name = input("Enter First Name: ")
    Last_name = input("Enter Last Name: ")
    dob = input("Enter dob: ")
    Phone_number = input("Enter Phone number:")
    Email_address = input("Enter Email Address: ")
    Address = input("Enter Address:")
    City = input("Enter City Name:")
    state= input("Enter State:")
    zipcode = input("Enter ZipeCode:")
    
    query = "UPDATE  Patients_details set First_name =%s, Last_name=%s, dob=%s, phone_number=%s, Email_address=%s, Address=%s, City=%s, state=%s, zipcode=%s where patient_id = %s"
    values = (First_name,  Last_name, dob,  Phone_number, Email_address,  Address, City, state, zipcode,user_id)
    
    try:
        cursor.execute(query, values)
        connection.commit()
        cursor.close()
        connection.close()
        print("---Update is done successfully---")
        return True
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        connection.rollback()
        
        cursor.close()
        connection.close()
        return False


def getAllPatients():
    connection = create_db_connection()
    cursor = connection.cursor() 
    query = "SELECT * FROM patients_details"
    
    # Execute the query
    cursor.execute(query)

    # Fetch all the records
    records = cursor.fetchall()

    print("All patient records")
    for record in records:
        print(record)

    cursor.close()
    connection.close()

    return



def isPatient():
    print("patient check page")
    connection = create_db_connection()
    cursor = connection.cursor()
    user = -1
    user_id = -1

    uname = input("Enter username: ")
    # lname = input("Enter Last Name: ")
    password = input("Enter password: ")
    query = "SELECT user_id FROM auth WHERE  username= %s AND userpassword = %s and user_is = %s"
    values = (uname, password,"patient")
    cursor.execute(query, values)

    # Fetch the first row of the result set
    patient_id = cursor.fetchone()
    cursor.close()
    connection.close()

    # If the doctor_id is not None, the email and password are valid
    if patient_id is not None:
        print("---Login successful. Patient ID:", patient_id[0],"------")
        user = 1
        user_id = patient_id[0]
        
    else:
        print("Invalid credentials, please try againwith correct deails")
        user,user_id = isPatient()
    
    cursor.close()
    connection.close()

    return (user,user_id)
    
 
def addPatientDetails():
    connection = create_db_connection()
    cursor = connection.cursor() 
    First_name = input("Enter First Name: ")
    Last_name = input("Enter Last Name: ")
    dob = input("Enter dob: ")
    Phone_number = input("Enter Phone number:")
    Email_address = input("Enter Email Address: ")
    Address = input("Enter Address:")
    City = input("Enter City Name:")
    state= input("Enter State:")
    zipcode = input("Enter ZipeCode:")
    query = "INSERT INTO patients_details(First_name,  Last_name, dob,  Phone_number, Email_address,  Address, City, state, zipcode) values(%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    values = (First_name,  Last_name, dob,  Phone_number, Email_address,  Address, City, state, zipcode)
    
    try:
        cursor.execute(query, values)
        connection.commit()
        cursor.close()
        connection.close()
        print("---Insertion is done successfully---")
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        connection.rollback()
        
        cursor.close()
        connection.close()
    
    uid = cursor.lastrowid

    usables.userSignup(uid,'PATIENT')






def patientAccessibilty(user_id):
    #check appointments
    #check patient medical history
    #add/update prescription
    connection = create_db_connection()
    cursor = connection.cursor() 
    print("Press 1 to check your Visit details")
    print("Press 2 to make new visit")
    # print("Press  to edit your appointment")
    print("Press 3 to cancel your visit")

    print("Press 4 to check your insurance")
    print("Press 5 to add insurance")
    print("Press 6 to edit your insurance")
    print("Press 7 to delete your insurance")

    print("Press 8 to check your info")
    print("Press 9 to edit your info")

    print("Press q to go back to main menu")

    command = input()

    if(command=="1"):
        vd.checkUrAppointment(user_id)
    elif(command=="2"):
        vd.addAppointment(user_id)
    elif(command=="3"):
        vd.cancelAppointment(user_id) 
   
       
    elif(command=="4"):
        ind.checkUrInsurance(user_id)   
    elif(command=="5"):
        ind.addInsurance(user_id)
    elif(command=="6"):
        ind.editInsurance(user_id)  
    
    elif(command=="7"):
        ind.deleteInsurance(user_id)
    elif(command=="8"):
        checkUrInfo(user_id) 
    elif(command=="9"):
        editPatientDetails(user_id)              
    elif(command  == "q"):
        return
    




    cursor.close()
    connection.close()

    # if(command == "1")
 