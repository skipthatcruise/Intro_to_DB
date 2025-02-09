import mysql.connector
import argparse

# Set up argument parser
parser = argparse.ArgumentParser(description="List full description of the 'books' table.")
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
    mycursor.execute(f"USE {args.database};")

    # Query to fetch full description of the 'books' table from INFORMATION_SCHEMA
    mycursor.execute("""
    SELECT
        COLUMN_NAME,
        DATA_TYPE,
        IS_NULLABLE,
        COLUMN_DEFAULT,
        CHARACTER_MAXIMUM_LENGTH,
        NUMERIC_PRECISION,
        NUMERIC_SCALE
    FROM
        INFORMATION_SCHEMA.COLUMNS
    WHERE
        TABLE_SCHEMA = DATABASE() AND
        TABLE_NAME = 'books';
    """)

    # Fetch the results
    columns = mycursor.fetchall()

    if columns:
        print(f"📌 Full description of 'books' table in '{args.database}':")
        for column in columns:
            print(f"""
            Column Name: {column[0]}
            Data Type: {column[1]}
            Is Nullable: {column[2]}
            Default Value: {column[3]}
            Max Length: {column[4]}
            Numeric Precision: {column[5]}
            Numeric Scale: {column[6]}
            """)
    else:
        print(f"ℹ️ No 'books' table found in the '{args.database}' database.")

except mysql.connector.Error as err:
    print(f"❌ Error: {err}")

finally:
    if 'mycursor' in locals() and mycursor is not None:
        mycursor.close()
    if 'mydb' in locals() and mydb.is_connected():
        mydb.close()
    print("🔒 Connection closed.")
