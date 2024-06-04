import mysql.connector

def create_db_connection():
    #connect mysql
    return mysql.connector.connect(user='root', password='123456789',
                              host="localhost",
                              database='electronic_medical_record_2')
    
    # if connection.is_connected():
    # print("Connected to the database")  