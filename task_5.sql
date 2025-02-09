import mysql.connector
import argparse

# Set up argument parser to accept database name
parser = argparse.ArgumentParser(description="Insert data into 'customer' table.")
parser.add_argument("database", help="The name of the MySQL database")
args = parser.parse_args()

try:
    # Connect to MySQL
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        password="password"  # Replace with your password
    )

    mycursor = mydb.cursor()

    # Select the database
    mycursor.execute(f"USE {args.database};")

    # SQL query to insert data into the customer table
    insert_query = """
    INSERT INTO customer (customer_id, customer_name, email, address)
    VALUES (%s, %s, %s, %s);
    """
    # Data to be inserted
    customer_data = (1, 'Cole Baidoo', 'cbaidoo@sandtech.com', '123 Happiness Ave.')

    # Execute the query with the data
    mycursor.execute(insert_query, customer_data)

    # Commit the changes
    mydb.commit()

    print("✅ Data inserted successfully!")

except mysql.connector.Error as err:
    print(f"❌ Error: {err}")

finally:
    if 'mycursor' in locals() and mycursor is not None:
        mycursor.close()
    if 'mydb' in locals() and mydb.is_connected():
        mydb.close()
    print("🔒 Connection closed.")
