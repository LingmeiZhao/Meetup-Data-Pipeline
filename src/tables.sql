CREATE TABLE Categories (
    CategoryID INT NOT NULL PRIMARY KEY,
    CategoryName VARCHAR(200)
);

CREATE TABLE Events (
    EventID VARCHAR(200) NOT NULL PRIMARY KEY,
    EventName TEXT
);

CREATE TABLE Groups (
    GroupID INT NOT NULL PRIMARY KEY,
    GroupName VARCHAR(200),
    Latitude FLOAT(8, 4),
    Longitude FLOAT(8, 4),
    Country VARCHAR(20),
    State VARCHAR(10),
    City VARCHAR(50),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


CREATE TABLE Members (
    MemberID INT NOT NULL PRIMARY KEY,
    MemberName VARCHAR(200)
);

CREATE TABLE Comments (
    CommentID INT NOT NULL PRIMARY KEY,
    Content TEXT,
    CommentTime TIMESTAMP,
    MemberID INT,
    GroupID INT,
    CategoryID INT,
    EventID VARCHAR(200),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (GroupID) REFERENCES Groups(GroupID)
);



