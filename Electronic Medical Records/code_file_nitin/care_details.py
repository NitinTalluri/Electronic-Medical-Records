import mysql.connector
from database_module import create_db_connection
import usables

def getAllPrescriptions():
    connection = create_db_connection()
    cursor = connection.cursor() 
    query = "SELECT * from Clinicalcare_details"
    cursor.execute(query)
    records = cursor.fetchall()
    print("All Prescriptions")
    for record in records:
        print(record)

    cursor.close()
    connection.close()

def editPrescription():
    connection = create_db_connection()
    cursor = connection.cursor() 
    care_id = input("Enter care ID:")

    Visit_id = input("Enter Visit ID:")
    Diagnosis = input("Enter Diagnosis:")
    Symptoms = input ("Explain Symptoms:")
    Prescription = input("Provide Prescription:")
    Lab_order = input("Enter Order:")
    Lab_results = input("Enter Result:")
    
    query = " UPDATE Clinicalcare_details set Visit_id =%s, Diagnosis=%s, Symptoms=%s, Prescription=%s, Lab_order=%s, Lab_results=%s where care_id = %s"
    values = ( Visit_id, Diagnosis, Symptoms, Prescription, Lab_order, Lab_results,care_id)

    try:
        cursor.execute(query, values)
        connection.commit()
        print("----Update successful---")
        
        cursor.close()
        connection.close()


        return True
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        connection.rollback()

        cursor.close()
        connection.close()
        editPrescription()
        return False      

def deletePrescription():
    connection = create_db_connection()
    cursor = connection.cursor() 
    pres_id = input("Enter care id which you want to delete: ")
    query = "Delete from Clinicalcare_details  where care_id = %s"
    values = (pres_id,)

    try:
        cursor.execute(query, values)
        connection.commit()
        print("---Delected successfully---")
        
        cursor.close()
        connection.close()

        getAllPrescriptions()

        return True
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        connection.rollback()

        cursor.close()
        connection.close()
        return False

def addPrescription():
    connection = create_db_connection()
    cursor = connection.cursor() 
    Visit_id = input("Enter Visit ID:")
    Diagnosis = input("Enter Diagnosis:")
    Symptoms = input ("Explain Symptoms:")
    Prescription = input("Provide Prescription:")
    Lab_order = input("Enter Order:")
    Lab_results = input("Enter Result:")
    
    query = "INSERT into Clinicalcare_details (Visit_id, Diagnosis, Symptoms, Prescription, Lab_order, Lab_results) VALUES (%s,%s,%s,%s,%s,%s)"
    values = ( Visit_id, Diagnosis, Symptoms, Prescription, Lab_order, Lab_results)

    try:
        cursor.execute(query, values)
        connection.commit()
        print("---Insertion of the data is successful---")
        
        cursor.close()
        connection.close()

        # getAllPrescriptions()

        return True
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        connection.rollback()

        cursor.close()
        connection.close()
        return False    