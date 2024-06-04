import mysql.connector
import patient_details as pd
import doctor_details as dd
import database_module as dm


user = -1  # doctor = 0, patient = 1, other/guest = 2 
user_id = -1 #id of doctors / patients






def isOther():
    print("New user registration page")
    print("Press 1 to register new Doctor")
    print("Press 2 to register new Patient")
    print("Press any other to go back to main menu")
    command = input()

    if((command) == "1") :
        print("Before insertion")
        dd.getAllDoctors()
        if(dd.addDoctorDetails()):
            print("Signup Completed, Login now")
            
            print("after insertion")
            dd.getAllDoctors()
            main()


    elif((command) == "2") :
        print("Before insertion")
        pd.getAllPatients()
        if(pd.addPatientDetails()):
            # userSignup()
            print("Signup Completed, Login now")
            
            print("after insertion")
            pd.getAllPatients()
            
            main()
    else:
        main()
    
        



def main():
    print("Welcome to Electronic Medical Record")
    print("Press 1 if you are a Doctor")
    print("Press 2 if you are a Patient")
    print("Press 3 if you are not Both")

    print("Press q to quit")
    

    command = input()
    if (command == 'q'):
        return
    elif(command == "1") :
        user,user_id = dd.isDoctor()
        #usables.setUserId(user_id)

        print("user = ",user," user_id = ",user_id)
        if(user == 0):  #doctor = 0
            dd.doctorAccessibilty(user_id)
    elif(command == "2") :
        user,user_id = pd.isPatient()
        # usables.setUserId(user_id)
        print("user = ",user," user_id = ",user_id)
        if(user == 1):  #patient = 1
            pd.patientAccessibilty(user_id)
    elif(command == "3") :    
        isOther()
    else:
        main()

if dm.create_db_connection().is_connected():
        print("Connected to database")
main()


#IMPORTANT
# Add tables and other features to enable audit trail so that every query or change of
# every record in the database is monitored and the entire history of the data in the
# database is captured. Basically, every time a record is accessed (queried, inserted,
# or changed), the user and time of access is recorded. Every time any field of a record
# is updated or deleted, the previous value of the record is saved
