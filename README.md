# CapstoneProject-Employees Data Analysis
# Introduction: 
You have been hired as a new data engineer at Analytixlabs. Your first major task is to work on data engineering project for one of the big corporation’s employee’s data from the 1980s and 1995s. All the database of employees from that period are provided six CSV files. In this project, you will design data model with all the tables to hold data, import the CSVs into a SQL database, transfer SQL database to HDFS/Hive, and perform analysis using Hive/Impala/Spark/SparkML using the data and create data and ML pipelines.
# Project Description:
In this project, it is required to create end to end data pipeline and analyzing the data.
# Technology Stack:
Worked on below technology Stack.
- MySQL (to create database)
- Linux Commands
- Sqoop (Transfer data from MySQL Server to HDFS/Hive)
- HDFS (to store the data)
- Hive (to create database)
- SparkSQL (to perform the EDA)
- SparkML (to perform model building)

![image](https://user-images.githubusercontent.com/105636996/169285227-4f4f9355-84de-4aed-8f47-ed840fa4e09a.png)

# ERD 
![image](https://user-images.githubusercontent.com/105636996/169283457-11846720-b768-4878-a55a-579cfee8a156.png)
# Tasks 
1. Create database & tables in MySQL server as per the above ER Diagram
2. Created database and tables in MYSQL using command file as per the ER Diagram
3. Created Sqoop job to transfer the data from MySQL to HDFS (Data is stored in Avro format) 
4. Created database in Hive as per the above ER Diagram and load the data into Hive tables
5. Work on Exploratory data analysis as per the analysis requirement using Hive and Spark SQL.
6. Build ML Model(Random Forest) as the problem statement of Attrition Rate Calculation.
7. Create entire data pipeline and ML pipe line except for the Classifer as Other model can be deployed here as well.

# Results
1. stored the output of EDA in hive into the Outputfinal1.txt file
2. Created a target variale left_job and implemented my ML model 
