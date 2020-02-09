import mysql.connector
import json
import sys
from datetime import datetime

mydb = mysql.connector.connect(
    host = "localhost",
    user = "root",
    passwd = "",
    database = "meetup"
)

mycursor = mydb.cursor()

text = sys.stdin.read()
print(text)
data = json.loads(text)

sql_category = """
INSERT INTO Categories (CategoryID, CategoryName) VALUES ('{0}', '{1}') ON DUPLICATE KEY UPDATE
CategoryName='{1}';
""".format(data["group"]["category"]["id"], data["group"]["category"]["name"].replace("'", "''"))

mycursor.execute(sql_category)

sql_event = """
INSERT INTO Events (EventID, EventName) VALUES ('{0}', '{1}') ON DUPLICATE KEY UPDATE
EventName = '{1}';
""".format(data["event"]["event_id"], data["event"]["event_name"].replace("'", "''"))

mycursor.execute(sql_event)

def get_state(data):
    if "state" in data["group"]:
        return "'" + data["group"]["state"] + "'"
    else:
        return "NULL"


sql_group = """
INSERT INTO Groups (GroupID, GroupName, Latitude, Longitude, Country, State, City, CategoryID) VALUES ('{0}', '{1}', '{2}', '{3}', '{4}', {5}, '{6}', '{7}') 
ON DUPLICATE KEY UPDATE GroupName = '{1}', Latitude = '{2}', Longitude = '{3}', Country = '{4}', State = {5}, City = '{6}', CategoryID = '{7}';
""".format(data["group"]["id"], data["group"]["name"], data["group"]["group_lat"], data["group"]["group_lon"],
data["group"]["country"], get_state(data), data["group"]["city"], data["group"]["category"]["id"])

mycursor.execute(sql_group)

sql_member = """
INSERT INTO Members (MemberID, MemberName) VALUES ('{0}', '{1}') ON DUPLICATE KEY UPDATE
MemberName = '{1}';
""".format(data["member"]["member_id"], data["member"]["member_name"])

mycursor.execute(sql_member)

ts = datetime.utcfromtimestamp(int(data["mtime"]) // 1000).strftime('%Y-%m-%d %H:%M:%S')

sql_comment = """
INSERT INTO Comments (CommentID, Content, CommentTime, MemberID, GroupID, CategoryID, EventID) VALUES ('{0}', '{1}', '{2}', '{3}', '{4}', '{5}', '{6}');
""".format(data["id"], data["comment"].replace("'", "''"), ts, data["member"]["member_id"], data["group"]["id"], data["group"]["category"]["id"], data["event"]["event_id"])

mycursor.execute(sql_comment)

mydb.commit()

print(mycursor.rowcount, "was inserted: ")

