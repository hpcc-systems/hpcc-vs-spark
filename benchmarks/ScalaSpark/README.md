## Original Benchmark
The code for this benchmark was taken from https://github.com/databricks/spark-perf and modified for the comparison with the ECL benchmarks.

## Usage
### Build Jar
```
sbt assembly 
```

### Run Tests

```
spark-submit --class "spark.perf.TestRunner" --master spark://{spark_master_ip}:7077 Benchmark.jar {test_name} \
--key-length 10 \
--value-length 90 \
--num-trials 3 \
--unique-values 10212 \
--reduce-tasks 24 \
--random-seed 1 \
--persistent-type disk \
--unique-keys 100000 \
--inter-trial-wait 0 \
--storage-location /tmp/spark_kv_data_test \
--num-partitions 24 \
--num-records 100000
```
