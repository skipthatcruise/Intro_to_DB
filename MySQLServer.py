import mysql.connector

try:
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        password="password"
    )

    mycursor = mydb.cursor()

    mycursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
    print("Database 'alx_book_store' created successfully!")

    mydb.database = "alx_book_store"

except mysql.connector.Error as err:
    print(f"❌ Error: {err}")


finally:
        mycursor.close()
        mydb.close()
        print("🔒 Connection closed.")

