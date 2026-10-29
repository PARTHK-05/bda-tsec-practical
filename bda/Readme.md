# TSEC BDA Practical Command Cheat Sheet

Use Linux-terminal commands in Zsh. Commands labelled "inside shell" run
inside HBase, Pig, Hive, MongoDB, or R. Replace `/home/vin` if your home
path differs.

**Caveats for this setup:** Sqoop 1.4.7 remains unresolved with Hadoop
3.3.6. Hive currently has a Derby metastore-client error. Do not delete
`metastore_db` blindly. HBase commands require HBase to be running.

**Expected outputs:** Output examples below describe the usual successful result. Version numbers, generated MongoDB `_id` values, timestamps, filesystem sizes, and service messages vary by machine. Commands that change or delete data should be run carefully.

## 1. Setup checks (Linux terminal)

``` bash
echo "$HOME"
java -version
javac -version
hadoop version
hdfs dfsadmin -report
jps
pig -version
hive --version
R --version
mongod --version
mongosh --version
start-dfs.sh
stop-dfs.sh
start-hbase.sh
stop-hbase.sh
hbase version
```

## 2. HDFS

``` bash
hadoop version
hadoop fs -ls /
hadoop fs -df hdfs:/
hadoop fs -count hdfs:/
hdfs fsck /
hadoop balancer
hadoop fs -mkdir -p /user/vin/hadoop
hadoop fs -ls /user/vin/hadoop
mkdir -p ~/data
echo "Hello Hadoop" > ~/data/sample.txt
hadoop fs -put ~/data/sample.txt /user/vin/hadoop/
hadoop fs -put -f ~/data/sample.txt /user/vin/hadoop/
hadoop fs -put ~/data/retail /user/vin/hadoop/
hadoop fs -ls
hadoop fs -du -s -h /user/vin/hadoop
hadoop fs -cat /user/vin/hadoop/sample.txt
hadoop fs -tail /user/vin/hadoop/sample.txt
hadoop fs -copyFromLocal ~/purchases.txt /user/vin/hadoop/
hadoop fs -copyToLocal /user/vin/hadoop/purchases.txt ~/data/
hadoop fs -get /user/vin/hadoop/sample.txt ~/data/
hadoop fs -mkdir -p /user/vin/hadoop/backup
hadoop fs -cp /user/vin/hadoop/*.txt /user/vin/hadoop/backup/
hadoop fs -mv /user/vin/hadoop/sample.txt /user/vin/hadoop/sample2.txt
hadoop fs -rm /user/vin/hadoop/retail/customers
hadoop fs -rm /user/vin/hadoop/retail/*
hadoop fs -rm -r /user/vin/hadoop/retail
hadoop fs -expunge
hadoop fs -chmod 600 /user/vin/hadoop/purchases.txt
hadoop fs -chown user:group /user/vin/hadoop/purchases.txt
hadoop fs -chgrp group /user/vin/hadoop/purchases.txt
hadoop fs -setrep -w 1 /user/vin/hadoop/purchases.txt
hdfs dfsadmin -safemode leave
hadoop fs -help
hadoop fs -help -ls
hadoop distcp hdfs://namenodeA/source hdfs://namenodeB/destination
hadoop distcp -update hdfs://namenodeA/source hdfs://namenodeB/destination
hadoop distcp -overwrite hdfs://namenodeA/source hdfs://namenodeB/destination
```

### Expected output (HDFS)

Outputs depend on the files and cluster state. Typical examples:

- `hadoop version`: prints Hadoop version/build details.
- `hadoop fs -ls /`: lists HDFS root entries in columns such as permissions, owner, size, date, and path; an empty root may show no entries.
- `hadoop fs -mkdir -p /user/vin/hadoop`: normally prints nothing on success.
- `hadoop fs -put ...`: normally prints nothing on success; an existing destination can produce an error unless `-f` is used.
- `hadoop fs -cat /user/vin/hadoop/sample.txt`: prints `Hello Hadoop` if you created the sample file as shown.
- `hadoop fs -du -s -h ...`: prints a size and path, for example `13  /user/vin/hadoop` (size varies).
- `hadoop fs -rm ...`: prints `Deleted ...` on success; `-rm -r` removes a directory tree.
- `hdfs dfsadmin -report`: prints live/dead DataNode and storage statistics.
- `jps`: lists Java process names and PIDs; exact processes depend on what is running.
- `hadoop fs -help` / `-help -ls`: prints usage/help text.

Notes: `-rm -r` recursively deletes; there is no standard HDFS
`-rm -rf`. `-expunge` processes expired trash checkpoints. On your
one-DataNode setup, replication factor 1 is appropriate. `fsck` checks
health; it does not repair files.

## 3. HBase

Start from terminal:

``` bash
start-hbase.sh
hbase shell
```

Run inside `hbase shell`:

``` ruby
status
version
list
create 'students', 'info'
describe 'students'
exists 'students'
put 'students', '101', 'info:name', 'Amit'
put 'students', '101', 'info:marks', '85'
put 'students', '102', 'info:name', 'Riya'
put 'students', '102', 'info:marks', '92'
scan 'students'
get 'students', '101'
get 'students', '101', {COLUMN => 'info:name'}
count 'students'
put 'students', '101', 'info:marks', '90'
delete 'students', '101', 'info:marks'
deleteall 'students', '102'
disable 'students'
enable 'students'
truncate 'students'
disable 'students'
drop 'students'
exit
```

### Expected output (HBase)

- `status`: cluster summary, often including number of live servers.
- `version`: HBase version string.
- `list`: table names; after creation it should include `students`.
- `create 'students', 'info'`: confirmation that the table was created.
- `put ...`: normally no tabular output; it writes/updates the cell.
- `scan 'students'`: rows with row keys, column names and values, e.g. row `101` contains `info:name = Amit` and `info:marks = 85` before the update.
- `get 'students', '101'`: returns the stored cells for row `101`.
- `count 'students'`: number of row keys; with the sample data, typically `2` before deletion/truncation.
- `delete` / `deleteall`: confirmation or brief status; subsequent `get`/`scan` shows the removed data is gone.
- `truncate` clears all rows; `drop` removes the disabled table. Exact status wording varies by HBase version.

Syntax: `put 'table', 'row_key', 'family:qualifier', 'value'`. Disable
before dropping. `truncate` and `drop` are destructive.

## 4. Pig with HDFS

Terminal setup:

``` bash
mkdir -p ~/bigdata/pig-practice
cat > ~/bigdata/pig-practice/students.txt <<'EOF'
Amit,85
Riya,92
Rahul,74
Neha,88
EOF
hdfs dfs -mkdir -p /bda/pig
hdfs dfs -put -f ~/bigdata/pig-practice/students.txt /bda/pig/
pig
```

Run inside `grunt>`:

``` pig
students = LOAD '/bda/pig/students.txt' USING PigStorage(',') AS (name:chararray, marks:int);
DUMP students;
passed = FILTER students BY marks >= 80;
DUMP passed;
names = FOREACH students GENERATE name;
DUMP names;
sorted = ORDER students BY marks DESC;
DUMP sorted;
limited = LIMIT students 2;
DUMP limited;
unique_names = DISTINCT names;
grouped = GROUP students BY marks;
STORE passed INTO '/bda/pig/passed_students' USING PigStorage(',');
```

### Expected output (Pig)

For the sample `students.txt` data:

- `DUMP students;` prints `(Amit,85)`, `(Riya,92)`, `(Rahul,74)`, `(Neha,88)` (tuple formatting can vary).
- `DUMP passed;` prints Amit, Riya and Neha, because their marks are at least 80.
- `DUMP names;` prints the four names only.
- `DUMP sorted;` prints rows in descending marks order: Riya 92, Neha 88, Amit 85, Rahul 74.
- `DUMP limited;` prints the first two input rows: Amit and Riya.
- `DISTINCT names` and `GROUP students BY marks` assign relations but do not display them until `DUMP` is used.
- `STORE passed ...` writes output to the HDFS path and usually prints job/progress messages, not the result rows directly.

`STORE` fails if the output directory already exists; choose a new path
or intentionally remove the old one.

## 5. HiveQL

Start from terminal:

``` bash
cd "$HIVE_HOME"
hive
```

Run inside `hive>`:

``` sql
SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS bda;
USE bda;
CREATE TABLE students (
  name STRING,
  marks INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;
SHOW TABLES;
DESCRIBE students;
SELECT * FROM students;
SELECT COUNT(*) FROM students;
SELECT AVG(marks) FROM students;
SELECT MAX(marks), MIN(marks) FROM students;
SELECT SUM(marks) FROM students;
SELECT * FROM students WHERE marks >= 80;
SELECT name, marks FROM students ORDER BY marks DESC;
SELECT marks, COUNT(*) FROM students GROUP BY marks;
SELECT * FROM students LIMIT 5;
CREATE TABLE IF NOT EXISTS students_copy LIKE students;
LOAD DATA INPATH '/bda/hive/students.txt' INTO TABLE students;
```

### Expected output (Hive)

- `SHOW DATABASES;`: a list of database names, including `bda` after creation.
- `CREATE DATABASE ...;` and `USE bda;`: success/status messages; `USE` confirms the active database.
- `SHOW TABLES;`: lists `students` after successful table creation.
- `DESCRIBE students;`: rows for `name` (`string`) and `marks` (`int`).
- `SELECT * FROM students;`: prints rows loaded into the table; it is empty if no data has been loaded.
- `COUNT(*)`, `AVG(marks)`, `MAX`, `MIN`, and `SUM`: one-row result containing the calculated value; exact values depend on table data.
- `WHERE marks >= 80`: only rows with marks of at least 80.
- `ORDER BY marks DESC`: rows sorted from highest marks to lowest.
- `GROUP BY marks`: each distinct marks value and its count.
- `LIMIT 5`: at most five rows.
- `CREATE TABLE ... LIKE students;`: creates the schema copy, not a copy of the rows.
- `LOAD DATA INPATH ...`: a load/status message; query the table to verify loaded rows. Source-file behavior depends on the path and Hive settings.

`LOAD DATA INPATH` can move the HDFS source file. Use a separate path if
Pig still needs the original. `DROP TABLE students;` and
`DROP DATABASE bda;` are destructive.

Hive metastore diagnosis from `$HIVE_HOME`:

``` bash
schematool -dbType derby -info
```

Only if it reports the schema is uninitialized:

``` bash
schematool -dbType derby -initSchema
```

Your Hive 3.1.3 setup currently errors with
`Unable to instantiate SessionHiveMetaStoreClient`; don't delete Derby
directories without diagnosing the cause.

## 6. Sqoop (reference only; not confirmed working)

``` bash
sqoop import \
  --connect 'jdbc:postgresql://localhost:5432/bda' \
  --connection-manager org.apache.sqoop.manager.GenericJdbcManager \
  --driver org.postgresql.Driver \
  --username sqoopuser \
  -P \
  --table students \
  --target-dir /bda/sqoop/students \
  --num-mappers 1
hdfs dfs -ls /bda/sqoop
```

The target directory must not already exist. Sqoop 1.4.7 hit
compatibility/generated-class failures with Hadoop 3.3.6 here, so this
is a template, not a working result.

## 7. MongoDB

Terminal:

``` bash
mongod --version
mongosh --version
sudo systemctl status mongod
sudo systemctl start mongod
sudo systemctl enable mongod
mongosh
```

Run inside `mongosh`:

``` javascript
show dbs
use bda
db
db.createCollection("students")
show collections
db.students.insertOne({roll: 101, name: "Amit", marks: 85})
db.students.insertMany([{roll: 102, name: "Riya", marks: 92}, {roll: 103, name: "Rahul", marks: 74}, {roll: 104, name: "Neha", marks: 88}])
db.students.find()
db.students.find({marks: {$gte: 80}})
db.students.findOne({roll: 101})
db.students.find({}, {_id: 0, name: 1, marks: 1})
db.students.countDocuments()
db.students.countDocuments({marks: {$gte: 80}})
db.students.updateOne({roll: 101}, {$set: {marks: 90}})
db.students.deleteOne({roll: 103})
db.students.deleteMany({marks: {$lt: 80}})
db.students.find().sort({marks: -1})
db.students.find().limit(2)
db.students.drop()
db.dropDatabase()
exit
```

### Expected output (MongoDB)

The following assumes you start with a fresh `bda` database and run the commands in order. MongoDB-generated `_id` values are different on each run.

| Command | Expected result |
|---|---|
| `show dbs` | Lists databases that already contain data; a new empty database may not appear yet. |
| `use bda` | `switched to db bda` |
| `db` | `bda` |
| `db.createCollection("students")` | `{ ok: 1 }` or a collection-created confirmation. |
| `show collections` | `students` |
| `insertOne(...)` | `acknowledged: true`, plus `insertedId`. |
| `insertMany(...)` | `acknowledged: true`, plus three `insertedIds`. |
| `find()` | Four student documents: Amit 85, Riya 92, Rahul 74, Neha 88. Each has an `_id`. |
| `find({marks: {$gte: 80}})` | Amit (85), Riya (92), and Neha (88). |
| `findOne({roll: 101})` | Amit's document, with `roll: 101` and `marks: 85` before the update. |
| `find({}, {_id: 0, name: 1, marks: 1})` | Four documents containing only `name` and `marks`. |
| `countDocuments()` | `4` |
| `countDocuments({marks: {$gte: 80}})` | `3` |
| `updateOne({roll: 101}, {$set: {marks: 90}})` | `matchedCount: 1`, `modifiedCount: 1`; Amit's marks become 90. |
| `deleteOne({roll: 103})` | `deletedCount: 1`; Rahul is removed. |
| `deleteMany({marks: {$lt: 80}})` | `deletedCount: 0` if run immediately after the preceding delete, because Rahul was already deleted and no other student has marks below 80. |
| `find().sort({marks: -1})` | Remaining students sorted by marks descending: Riya 92, Amit 90, Neha 88. |
| `find().limit(2)` | Any two documents; without a sort, order is not guaranteed. |
| `db.students.drop()` | `true` if the collection existed; removes the collection. |
| `db.dropDatabase()` | A result such as `{ ok: 1, dropped: "bda" }`; removes the database. |
| `exit` | Closes `mongosh`. |

`mongod --version` / `mongosh --version` print version information. `sudo systemctl status mongod` prints service status; `start` and `enable` print service-manager messages and may require permissions. `mongosh` opens a shell if the server is reachable.

`$gte` means greater than or equal to; `$lt` means less than.
`deleteMany`, `drop`, and `dropDatabase` are destructive.

## 8. R programming

Start: `R` in terminal. Run inside R:

``` r
x <- c(23, 45, 10, 34, 89, 20, 67, 99)
sort(x)
sort(x, decreasing = TRUE)

employees <- data.frame(
  name = c("Amit", "Riya", "Rahul", "Neha", "Soham"),
  age = c(21, 22, 20, 23, 21),
  salary = c(35000, 42000, 30000, 50000, 39000)
)
print(employees)
summary(employees)
str(employees)
head(employees)

new_employees <- data.frame(
  name = c("Karan", "Mary"),
  age = c(24, 22),
  salary = c(45000, 47000)
)
all_employees <- rbind(employees, new_employees)

subset(employees, age < 22)
employees[employees$age < 22, ]
employees[employees$age < 23 & employees$salary > 35000, ]

paste("Ram has scored", 89, "marks in Mathematics")
paste0("Marks: ", 89)
mean(employees$salary)
median(employees$salary)
min(employees$salary)
max(employees$salary)
sd(employees$salary)

plot(employees$age, employees$salary)
barplot(employees$salary, names.arg=employees$name)
hist(employees$salary)
boxplot(employees$salary)
dotchart(employees$salary, labels=employees$name)
pie(employees$salary, labels=employees$name)

x <- c(1, 2, 3, 4, 5)
y <- c(10, 14, 12, 20, 18)
sizes <- c(2, 5, 3, 7, 4)
symbols(x, y, circles=sizes, inches=0.3, main="Bubble chart")

data(iris)
summary(iris)
plot(iris$Sepal.Length, iris$Petal.Length)
boxplot(Sepal.Length ~ Species, data=iris)
q()
```

### Expected output (R)

For the vector `x <- c(23, 45, 10, 34, 89, 20, 67, 99)`:

- `sort(x)` returns `10 20 23 34 45 67 89 99`.
- `sort(x, decreasing = TRUE)` returns `99 89 67 45 34 23 20 10`.
- `print(employees)` prints the five-row data frame with the specified name, age and salary columns.
- `summary(employees)` prints summaries for each column: age and salary have Min, 1st Qu., Median, Mean, 3rd Qu. and Max; name is summarized as character data.
- `str(employees)` prints the data-frame structure and column types.
- `head(employees)` prints the first six rows, or all five here.
- `rbind(...)` creates a seven-row data frame containing the original five employees and Karan and Mary.
- `subset(employees, age < 22)` and `employees[employees$age < 22, ]` return Amit and Soham.
- `employees[employees$age < 23 & employees$salary > 35000, ]` returns Riya and Soham.
- `paste(...)` prints `Ram has scored 89 marks in Mathematics`; `paste0(...)` prints `Marks: 89`.
- `mean`, `median`, `min`, `max`, and `sd` print numeric summaries of salary. For the five salaries shown: mean = `39200`, median = `39000`, min = `30000`, max = `50000`; `sd` is approximately `7589.47`.
- `plot`, `barplot`, `hist`, `boxplot`, `dotchart`, `pie`, and `symbols` open or draw the requested plot in the active graphics device; they generally do not print a table.
- `data(iris)` loads the built-in Iris data set; `summary(iris)` prints summaries of its five columns; the `plot` and `boxplot` commands draw graphs.
- `q()` exits R (it may ask whether to save the workspace).

For churn, supermarket, and loan practicals, use the actual data files
provided by your course; their column names vary. Subsetting:
`df[rows, columns]`, `subset(df, condition)`, `&` AND, `|` OR, `!` NOT.

## Quick recall

-   **HDFS:** `-ls`, `-mkdir`, `-put`, `-get`, `-cat`, `-count`, `-du`,
    `-rm`, `-cp`, `-mv`, `-chmod`, `-chown`, `-setrep`.
-   **HBase:** `create`, `put`, `get`, `scan`, `count`, `delete`,
    `deleteall`, `disable`, `drop`.
-   **Pig:** `LOAD`, `DUMP`, `FILTER`, `FOREACH ... GENERATE`, `GROUP`,
    `ORDER`, `DISTINCT`, `LIMIT`, `STORE`.
-   **Hive:** `CREATE DATABASE`, `USE`, `CREATE TABLE`, `LOAD DATA`,
    `SELECT`, `WHERE`, `GROUP BY`, `COUNT`, `AVG`, `MIN`, `MAX`,
    `ORDER BY`.
-   **MongoDB:** `insertOne`, `insertMany`, `find`, `findOne`,
    `updateOne`, `deleteOne`, `countDocuments`, `sort`, `limit`.
-   **R:** `c`, `data.frame`, `summary`, `sort`, `subset`, `[ ]`,
    `rbind`, `paste`, `plot`, `barplot`, `hist`, `boxplot`, `dotchart`,
    `pie`.
