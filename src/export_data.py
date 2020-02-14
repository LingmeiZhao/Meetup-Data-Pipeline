import mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
    host = "localhost",
    user = "root",
    passwd = "",
    database = "meetup"
)

categories_query = "SELECT * FROM Categories;"
categories_df = pd.read_sql(categories_query, mydb)
categories_csv = categories_df.to_csv(
    "/home/zhaolingmei/Documents/Hadoop/data/categories.csv",
    index = None, header = None)


members_query = "SELECT * FROM Members;"
members_df = pd.read_sql(members_query, mydb)
members_csv = members_df.to_csv(
    "/home/zhaolingmei/Documents/Hadoop/data/members.csv",
    index = None, header = None)

events_query = "SELECT * FROM Events;"
events_df = pd.read_sql(events_query, mydb)
events_csv = events_df.to_csv(
    "/home/zhaolingmei/Documents/Hadoop/data/events.csv",
    index = None, header = None)

groups_query = "SELECT * FROM Groups;"
groups_df = pd.read_sql(groups_query, mydb)
groups_csv = groups_df.to_csv(
    "/home/zhaolingmei/Documents/Hadoop/data/groups.csv",
    index = None, header = None)

comments_query= "SELECT CommentID, CommentTime, MemberID, GroupID, CategoryID, EventID FROM Comments;"
comments_df = pd.read_sql(comments_query, mydb)
comments_csv = comments_df.to_csv(
    "/home/zhaolingmei/Documents/Hadoop/data/comments.csv",
    index = None, header = None)

