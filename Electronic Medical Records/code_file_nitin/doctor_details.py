import visit_details as vd
from database_module import create_db_connection
import care_details as cd
import usables
import hashlib


def addDoctorDetails():
    connection = create_db_connection()
    cursor = connection.cursor()

    First_name = input("Enter First Name: ")
    Last_name = input("Enter Last Name: ")
    Specialty = input("Enter Specialty: ")
    Phone_number = input("Enter Phone Number: ")
    Email_address = input("Enter Email address: ")
    query = "INSERT INTO Doctor_details(First_name, Last_name, Specialty, Phone_number, Email_address) values(%s,%s,%s,%s,%s)"
    values = (First_name, Last_name, Specialty, Phone_number, Email_address)
    
    try:
        cursor.execute(query, values)
        connection.commit()
        print("---Insertion is successfully finished---")
        
        cursor.close()
        connection.close()
    except mysql.connector.Error as error:
        print("Error: {}".format(error))
        connection.rollback()

        cursor.close()
        connection.close()
    uid = cursor.lastrowid
    usables.userSignup(uid,'DOCTOR')



def doctorAccessibilty(user_id):
    #check appointments
    #check patient medical history
    #add/update prescription
    connection = create_db_connection()
    cursor = connection.cursor()


    print("Press 1 to check your details")
    print("Press 2 to edit your details")
    print("Press 3 to add new clinicalcare")
    print("Press 4 to edit clinicalcare")
    print("Press 5 to delete clinicalcare")
    print("Press q to go back to main menu")

    command = input()

    if(command == "1"):
        vd.checkDoctorsAppointments(user_id)
    elif(command == "2"):
        vd.editAppointment(user_id)
    elif(command == "3"):
        cd.addPrescription()
    elif(command == "4"):
        cd.editPrescription()
    elif(command == "5"):
        cd.deletePrescription()
    
    elif(command =="q"):
        return()
    
    cursor.close()
    connection.close()

def isDoctor():
    print("Doctor check page")
    connection = create_db_connection()
    cursor = connection.cursor()
    user = -1
    user_id = -1

    uname = input("Enter username: ")
    password = input("Enter password: ")
    query = "SELECT user_id FROM auth WHERE  username= %s AND userpassword = %s and user_is = %s"
    values = (uname, password,'doctor')
    cursor.execute(query, values)

    # Fetch the first row of the result set to show
    doctor_id = cursor.fetchone()
    print(doctor_id)
    # cursor.close()
    # connection.close()

    # If the doctor_id is not None, the email and password are valid , prints sucessful login
    if doctor_id is not None:
        print("---Login successfully finished. Doctor ID:", doctor_id[0],"------------")
        user = 0
        user_id = doctor_id[0]
        
    else:
        print("Invalid credentials, please try again with correct one")
        user,user_id = isDoctor()
    
    # cursor.close()
    # connection.close()
    return (user,user_id)
    
    


def getAllDoctors():
    connection = create_db_connection()
    cursor = connection.cursor()

    query = "SELECT * FROM doctor_details"
    # Execute the query to print 
    cursor.execute(query)
    # Fetch all the records that are given
    records = cursor.fetchall()

    print("All Doctor records")
    for record in records:
        print(record)
    
    cursor.close()
    connection.close()

    return