#!bin/bash/
#date
#author
sqoop import-all-tables --connect jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal:3306/anabig114215 --username anabig114215 --password Bigdata123 --compression-codec=snappy --as-avrodatafile --warehouse-dir=/user/anabig114215/hive/warehouse/finalrun777 --m 1 --driver com.mysql.jdbc.Driver 
hdfs dfs -ls /user/anabig114215/hive/warehousefinalrunhadoop fs -put /home/anabig114215/Employees.avsc /user/anabig114215/hive/warehouse/capstone999/Employees.avsc
hadoop fs -put /home/anabig114215/Departments.avsc /user/anabig114215/hive/warehouse/capstone999/Departments.avsc
hadoop fs -put /home/anabig114215/Department_Employees.avsc /user/anabig114215/hive/warehouse/capstone999/Department_Employees.avsc
hadoop fs -put /home/anabig114215/Depaartment_managers.avsc /user/anabig114215/hive/warehouse/capstone999/Depaartment_managers.avsc
hadoop fs -put /home/anabig114215/Salaries.avsc /user/anabig114215/hive/warehouse/capstone999/Salaries.avsc
hadoop fs -put /home/anabig114215/Titles.avsc /user/anabig114215/hive/warehouse/capstone999/Titles.avsc
#end
