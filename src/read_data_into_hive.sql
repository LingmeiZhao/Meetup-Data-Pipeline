
CREATE TABLE Categories(CategoryID int, CategoryName string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION "/opt/data/categories.csv";

LOAD DATA LOCAL INPATH "/opt/data/categories.csv" OVERWRITE INTO TABLE Categories;

CREATE TABLE Events(EventID string, EventName string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION "/opt/data/events.csv";

LOAD DATA LOCAL INPATH "/opt/data/events.csv" OVERWRITE INTO TABLE Events;


CREATE TABLE Members(MemberID int, MemberName string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION "/opt/data/members.csv";

LOAD DATA LOCAL INPATH "/opt/data/members.csv" OVERWRITE INTO TABLE Members;


CREATE TABLE Groups(GroupID int, GroupName string, Latitude DECIMAL(8, 4), Longitude DECIMAL(8, 4), Country string, State string, City string, CategoryID int) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION "/opt/data/groups.csv";

LOAD DATA LOCAL INPATH "/opt/data/groups.csv" OVERWRITE INTO TABLE Groups;


CREATE TABLE Comments(CommentID int, CommentTime timestamp, MemberID int, GroupID int, CategoryID int, EventID string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION "/opt/data/comments.csv";

LOAD DATA LOCAL INPATH "/opt/data/comments.csv" OVERWRITE INTO TABLE comments;
