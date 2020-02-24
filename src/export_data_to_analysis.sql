DROP TABLE IF EXISTS topTenGroup;
DROP TABLE IF EXISTS joinedGroup;
DROP TABLE IF EXISTS topTenCategory;
DROP TABLE IF EXISTS joinedCategory;
DROP TABLE IF EXISTS groupByCity;
DROP TABLE IF EXISTS groupByCountry;
DROP TABLE IF EXISTS cityMap;

create table topTenGroup as select GroupID, count(*) as count from Comments group by GroupID order by count desc limit 10;
create table joinedGroup as select tg.GroupID, tg.count, g.GroupName from topTenGroup tg left outer join Groups g on tg.GroupID = g.GroupID;

create table topTenCategory as select CategoryID, count(*) as count from Comments group by CategoryID order by count desc limit 10;
create table joinedCategory as select tc.CategoryID, tc.count, c.CategoryName from topTenCategory tc left outer join Categories c on tc.CategoryID = c.CategoryID;

create table groupByCity as select city, count(*) as count from Groups group by city order by count desc limit 20;
create table groupByCountry as select Country, count(*) as count from Groups group by Country order by count desc limit 10; 

create table cityMap as select Country, State, City, longitude, latitude from Groups; 
