import mysql.connector
import json
import sys

mydb = mysql.connector.connect(
    host = "localhost",
    user = "root",
    passwd = "",
    database = "meetup"
)

mycursor = mydb.cursor()

text = sys.stdin.read()
data = json.loads(text)

sql_member = """
INSERT INTO Categories (CategoryID, CategoryName) VALUES ('{0}', '{1}') ON DUPLICATE KEY UPDATE
CategoryName='{1}';
""".format(data["category"]["id"], data["category"]["name"])

mycursor.execute(sql_member)

mydb.commit()

print(mycursor.rowcount, "was inserted: ")

