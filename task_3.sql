--import mysql.connector
--
--try:
--    # Connect to MySQL and select the database
--    mydb = mysql.connector.connect(
--        host="localhost",
--        user="root",
--        password="password",
--        database="alx_book_store"
--    )
--
--    mycursor = mydb.cursor()
--
--    # Query to list all tables in the database
--    mycursor.execute("SHOW TABLES")
--
--    # Fetch all tables and print them
--    tables = mycursor.fetchall()
--
--    if tables:
--        print("📌 Tables in 'alx_book_store' database:")
--        for table in tables:
--            print(f" - {table[0]}")
--    else:
--        print("ℹ️ No tables found in the database.")
--
--except mysql.connector.Error as err:
--    print(f"❌ Error: {err}")
--
--finally:
--   mycursor.close()
--   mydb.close()



import mysql.connector
import argparse

# Set up argument parser
parser = argparse.ArgumentParser(description="List all tables in a MySQL database.")
parser.add_argument("database", help="The name of the MySQL database")
args = parser.parse_args()

try:
    # Connect to MySQL (without specifying a database in the connection)
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        password="password"
    )

    mycursor = mydb.cursor()

    # Use the specified database
    mycursor.execute(f"USE alx_book_store;")

    # Show tables
    mycursor.execute("SHOW TABLES;")
    tables = mycursor.fetchall()

    if tables:
        print(f"📌 Tables in '{args.database}' database:")
        for table in tables:
            print(f" - {table[0]}")
    else:
        print(f"ℹ️ No tables found in '{args.database}'.")

except mysql.connector.Error as err:
    print(f"❌ Error: {err}")

finally:
    if 'mycursor' in locals() and mycursor is not None:
        mycursor.close()
    if 'mydb' in locals() and mydb.is_connected():
        mydb.close()
    print("🔒 Connection closed.")
