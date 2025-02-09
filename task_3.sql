import mysql.connector

try:
    # Connect to MySQL and select the database
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        password="password",
        database="alx_book_store"
    )

    mycursor = mydb.cursor()

    # Query to list all tables in the database
    mycursor.execute("SHOW TABLES")

    # Fetch all tables and print them
    tables = mycursor.fetchall()

    if tables:
        print("📌 Tables in 'alx_book_store' database:")
        for table in tables:
            print(f" - {table[0]}")
    else:
        print("ℹ️ No tables found in the database.")

except mysql.connector.Error as err:
    print(f"❌ Error: {err}")

finally:
   mycursor.close()
   mydb.close()
