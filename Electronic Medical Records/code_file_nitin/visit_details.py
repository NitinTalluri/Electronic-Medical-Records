import mysql.connector
from database_module import create_db_connection
import usables 

def checkDoctorsAppointments(user_id):
    connection = create_db_connection()
    cursor = connection.cursor() 

    query = "SELECT * FROM Visit_details WHERE Provider_id = %s"
    values = (user_id,)
    # Execute the query
    cursor.execute(query,values)
    
    records = cursor.fetchall()

    print("Your appointments")
    for record in records:
        print(record)
    
    cursor.close()
    connection.close()

def checkUrAppointment(user_id):
    connection = create_db_connection()
    cursor = connection.cursor() 
    query = "SELECT * FROM Visit_details WHERE Patient_id = %s"
    values = (user_id, )

    cursor.execute(query, values)
    records = cursor.fetchall()

    if len(records) == 0:
        print("You have no details ")
    else:
        print("Your details:")
        for record in records:
            print(record)
    
    cursor.close()
    connection.close()


def addAppointment(user_id):
    connection = create_db_connection()
    cursor = connection.cursor()
    query = "INSERT INTO Visit_details (Patient_id, Provider_id, Facility, Visit_date, Visit_time, Exam_room, Billing_code) VALUES (%s,%s,%s,%s,%s,%s,%s)"
    Provider_id = input("Enter provider ID: ")
    Facility = input("Enter facility: ")
    Visit_date = input("Enter visit date (YYYY-MM-DD): ")
    Visit_time = input("Enter visit time (HH:MM:SS): ")
    Exam_room = input("Enter Exam Room Number:")
    Billing_code = input("Enter Billing Code: ")

    values = (user_id, Provider_id, Facility, Visit_date, Visit_time, Exam_room, Billing_code)

    try:
        cursor.execute(query,values)
        connection.commit()
        print("Appointment added successfully")
        cursor.close()
        connection.close()
    except mysql.connector.Error as error:
        print("Failed to add the details: {}".format(error))



def getAllAppointments():
    connection = create_db_connection()
    cursor = connection.cursor() 

    query = "SELECT * FROM Visit_details"
    # Execute the query
    cursor.execute(query)
    
    records = cursor.fetchall()

    print("All appointments")
    for record in records:
        print(record)
    
    cursor.close()
    connection.close()




def editAppointment(user_id):
    connection = create_db_connection()
    cursor = connection.cursor()
    checkDoctorsAppointments(user_id)
    user_record = False
    visit_id = input("Enter visit id of the record that you want to edit: ")
    query = "UPDATE Visit_details SET Facility = %s, Visit_date = %s, Visit_time = %s, Exam_room = %s, Billing_code = %s WHERE Visit_id = %s AND Provider_id = %s"
    Facility = input("Enter facility: ")

    Visit_date = input("Enter Visit date: ")
    Visit_time = input("Enter Visit time: ")
    Exam_room= input("Enter Exam_room: ")
    Billing_code = input("Enter Billing code: ")


    values = (Facility, Visit_date, Visit_time, Exam_room, Billing_code,visit_id,user_id)
    # Execute the query
    try:
        cursor.execute(query, values)

        connection.commit()
        print("---Updated successfully the new data is ready---")
        cursor.close()
        connection.close()
        checkDoctorsAppointments(user_id)
        return
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        editAppointment(user_id)
        connection.rollback()
        cursor.close()
        connection.close()

def ifItsUserRecord(cursor,id1,id2):
    sub_query = "SELECT Patient_id from Visit_details WHERE Visit_id = %s"
    sub_values = (id1,)
    cursor.execute(sub_query,sub_values)
    sub_result = cursor.fetchone()
    
    if(sub_result is not None and sub_result[0] == id2 ):
        return True
    else:
        print("Please check your visit id. You cannot modify other users' record")
        return False

def cancelAppointment(user_id):
    connection = create_db_connection()
    cursor = connection.cursor() 
    # pat_id = input("Enter your patient id: ")
    checkUrAppointment(user_id)
    user_record = False
    app_id = input("Enter visit id of record that whould like to cancel the details: ")

    
    query = "DELETE from visit_details where visit_id = %s and patient_id = %s"
    
    values = (app_id,user_id)

    # Execute the query
    try:
        cursor.execute(query,values)

        connection.commit()
        print("------------Your appointment is cancelled------------")
        cursor.close()
        connection.close()
        return      
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        editAppointment(user_id)
        connection.rollback() 
        cursor.close()
        connection.close() 
        
    


    