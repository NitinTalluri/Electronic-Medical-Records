import mysql.connector
from database_module import create_db_connection
import usables

def checkUrInsurance(user_id):
    connection = create_db_connection()
    cursor = connection.cursor() 
    query = "SELECT * from insurance_details, insurance where insurance_details.insurance_id = insurance.insurance_id and insurance.patient_id =%s"
    values =  (user_id,)
    cursor.execute(query,values)
    records = cursor.fetchall()
    print("Your insurances")
    for record in records:
        print(record)

    cursor.close()
    connection.close()

def addInsurance(user_id):
    connection = create_db_connection()
    cursor = connection.cursor() 
    query1 = "select Insurance_provider from insurance_details" 
    cursor.execute(query1)
    sub_records = cursor.fetchall()
    print("All Providers")
    for sub_record in sub_records:
        print(sub_record)
    
    query = "INSERT into insurance_details (Insurance_provider, Insurance_group) values (%s,%s)"

    Insurance_provider = input("Enter provider: ")
    Insurance_group = input("Enter Group: ")
    values = (Insurance_provider,Insurance_group)
    

    try:
        cursor.execute(query, values)
        connection.commit()
       


    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        connection.rollback()
    ins_id = cursor.lastrowid

    query2 = "INSERT INTO insurance (patient_id, insurance_id) VALUES (%s,%s)"
    values2 = (user_id,ins_id)
    try:
        cursor.execute(query2, values2)
        connection.commit()
        print("------------Insertion successful------------")
        checkUrInsurance(user_id)
        cursor.close()
        connection.close()
        return True
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        connection.rollback()

        cursor.close()
        connection.close()
        return False  


def editInsurance(user_id):
    connection = create_db_connection()
    cursor = connection.cursor()
    

    checkUrInsurance(user_id)
    q="select Insurance_id from insurance where patient_id = %s"
    values = (user_id,)
    cursor.execute(q, values)
    res = cursor.fetchone()
    if res is not None:
        res = res[0]
    else:
        print("You have no insurance to edit")
        return
    # print("res",res)
    query = "UPDATE insurance_details set Insurance_provider = %s, Insurance_group = %s where Insurance_id = %s"
    Insurance_provider = input("Enter provider: ")
    Insurance_group = input("Enter Group: ")
    values = (Insurance_provider,Insurance_group,res)
    try:
        cursor.execute(query, values)
        connection.commit()
        print("------------Update successful------------")
        checkUrInsurance(user_id)
        cursor.close()
        connection.close()
        return True
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        connection.rollback()

        cursor.close()
        connection.close()
        return False  


def deleteInsurance(user_id):
    connection = create_db_connection()
    cursor = connection.cursor()
    q="select Insurance_id from insurance where patient_id = %s"
    values = (user_id,)
    cursor.execute(q, values)
    ins_id = cursor.fetchone()[0]
    # ins_id = input("Enter insurance id: ")
    query = "DELETE from insurance where patient_id =%s and insurance_id = %s"
    values = (user_id,ins_id)
    try:
        cursor.execute(query, values)
        connection.commit()
        print("------------Delete successful------------")
        checkUrInsurance(user_id)
        cursor.close()
        connection.close()
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        connection.rollback()
        cursor.close()
        connection.close()
    

