SQL Code
SQL_1
Comment - To check for duplicates
a)SELECT DISTINCT * INTO customer_NoDup FROM customer;
b)SELECT DISTINCT * INTO health_policies_NoDup FROM health_policies;
c)SELECT DISTINCT * INTO motor_policies_NoDup FROM motor_policies;
d)SELECT DISTINCT * INTO travel_policies_NoDup FROM travel_policies;
______________________________________________________________
SQL_2
Comment - Get the average age of customers in ABT
SELECT AVG(ANALYTICAL_BASE_TABLE.[AGE])
FROM ANALYTICAL_BASE_TABLE;
Output is ~ 42 years

SQL_3
Comment - DQ Issues addressed in SQL - Gender
a)UPDATE ANALYTICAL_BASE_TABLE
SET ANALYTICAL_BASE_TABLE.[GENDER] = 'female'
WHERE ANALYTICAL_BASE_TABLE.[GENDER] = 'f';
b)UPDATE ANALYTICAL_BASE_TABLE
SET ANALYTICAL_BASE_TABLE.[GENDER] = 'male'
WHERE ANALYTICAL_BASE_TABLE.[GENDER] = 'm';
______________________________________________________________
SQL_4
Comment - DQ Issues addressed in SQL - Age
Age over 100 YEARS
UPDATE ANALYTICAL_BASE_TABLE
SET ANALYTICAL_BASE_TABLE.[AGE]=42
WHERE ANALYTICAL_BASE_TABLE.[AGE]>100;
Negative Age
UPDATE ANALYTICAL_BASE_TABLE
SET AGE = ABS(AGE)
WHERE AGE<0;
______________________________________________________________
SQL_5
Comment - DQ Issues addressed in SQL - Communication Channel
SMS
UPDATE ANALYTICAL_BASE_TABLE
SET ANALYTICAL_BASE_TABLE.[ComChannel] = "SMS"
WHERE ANALYTICAL_BASE_TABLE.[ComChannel] = "S";

PHONE
UPDATE ANALYTICAL_BASE_TABLE
SET ANALYTICAL_BASE_TABLE.[ComChannel] = "Phone"
WHERE ANALYTICAL_BASE_TABLE.[ComChannel] = "P";
EMAIL
UPDATE ANALYTICAL_BASE_TABLE
SET ANALYTICAL_BASE_TABLE.[ComChannel] = "Email"
WHERE ANALYTICAL_BASE_TABLE.[ComChannel] = "E";
______________________________________________________________
SQL_6
Comment - Analytical Base Table formation
SELECT * INTO ANALYTICAL_BASE_TABLE
FROM ((customer
LEFT JOIN health_policies ON customer.HealthID = health_policies.HealthID)
LEFT JOIN motor_policies ON customer.MotorID = motor_policies.MotorID)
LEFT JOIN travel_policies ON customer.TravelID = travel_policies.TravelID;
______________________________________________________________
SQL_7
Comment - Insights - Communication Mode Preferred
SELECT
ComChannel AS ModeCommunication , COUNT(*) AS Count
FROM
ANALYTICAL_BASE_TABLE
GROUP BY ComChannel
ORDER BY COUNT(*) DESC;
____________________________
SQL_8
Comment - Insights - Top Communication Channel Preference by Location
SELECT
Location, First(ComChannel) AS ModeCommunication
FROM (
SELECT Location, ComChannel, COUNT(*) AS ChannelCount
FROM ANALYTICAL_BASE_TABLE
GROUP BY Location, ComChannel
ORDER BY Location, COUNT(*) DESC
) AS SubQuery
GROUP BY Location;
______________________________________________________________
SQL_9
Comment - Insights Customer count Location wise
SELECT
LOCATION,COUNT(CUSTOMERID) AS COUSTMER_COUNT
FROM
ANALYTICAL_BASE_TABLE GROUP BY LOCATION;
______________________________________________________________
SQL_10
Comment - Insights Relationship between number of insurance buyers with
respect to gender and locationSELECT
Gender, Location, COUNT(*) AS Count
FROM ANALYTICAL_BASE_TABLE
GROUP BY Gender, Location;
______________________________________________________________
SQL_11
Comment - Insights Age vs count of insurance holders
SELECT gender,
IIf(Age BETWEEN 18 AND 25, '18-25',
IIf(Age BETWEEN 26 AND 35, '26-35',
IIf(Age BETWEEN 36 AND 45, '36-45',
IIf(Age BETWEEN 46 AND 55, '46-55', 'Above 55')
)
)
) AS AgeRange,
COUNT(*) AS CountInAgeRange
FROM
ANALYTICAL_BASE_TABLE
GROUP BY
gender,
IIf(Age BETWEEN 18 AND 25, '18-25',
IIf(Age BETWEEN 26 AND 35, '26-35'
IIf(Age BETWEEN 36 AND 45, '36-45',
IIf(Age BETWEEN 46 AND 55, '46-55', 'Above 55'),
)
)
);
______________________________________________________________
SQL_12 - Insights Customers who took all three insurance
SELECT CustomerID
FROM Analytical_Base_Table
WHERE HealthID IS NOT NULL AND MotorID IS NOT NULL AND TravelID IS
NOT NULL;
______________________________________________________________
SQL_13
SELECT COUNT(*) as ‘Number_of_Customers’
FROM Customers;
____________________________
