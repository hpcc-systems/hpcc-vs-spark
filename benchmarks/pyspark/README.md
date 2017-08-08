## Setup
[This](http://eclsummer2017.blogspot.com/2017/07/how-to-set-up-spark-multi-node-cluster.html) tutorial was used to the spark cluster on AWS (ec2). 

Note: We did not used [EMR](https://aws.amazon.com/emr/), since we could not place the nodes in the same placement group (similar to the setup for HPCC).

## Usage
### Run
```
spark-submit --master spark://10.60.4.220:7077 --num-executors 24 --verbose spark_benchmark.py -a
```

### Parameters
- Change the num_records to control the number of records used for the benchmark run.
- --unique-keys: number of unique keys: For the benchmark experiments, number of unique keys were set to 100000
- --key-length: length of the keys (applicable for string data generation). For the benchmark experiments, length of the keys is 10
- --unique-values: number of unique values: For the benchmark experiments, number of unique values were set to 10212
- --value-length: length of the values (applicable for string data generation). For the benchmark experiments, length of the values is 90
- --num-partitions: number of partition of the RDD. (Tuning required)
- --num-trails: number of trails of each benchmark experiment.

### Spark parameters used (1 master and 3 worker nodes - r3-2xlarge):
Number of executors used is 24 (3x8)
Executor cores is 1
Executor memory is 7G

Content of $SPARK_HOME/conf/spark-env.sh
```
export SPARK_LOCAL_DIRS=/home/ec2-user/data
export JAVA_HOME=/opt/jdk1.8.0_131/
export SPARK_EXECUTOR_CORES=1
export SPARK_EXECUTOR_MEMORY=7000M
```


