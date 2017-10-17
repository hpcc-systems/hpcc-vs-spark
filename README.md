<h1>Performance on AWS: HPCC Systems Thor vs Apache Spark</h1>

There have been several Spark performance studies. But, until now no one has compared Spark's performance to HPCC Systems Thor's performance. [This paper](Documentation) does so by putting both cluster architectures on a few low-cost AWS instances and executing different benchmark functions on both. The functions we chose have been used by others to study the performance of Spark. We found (see section 4), for a dataset that fit in memory, Spark had a better execution time for SortByKey; both clusters had similar execution times for Count, Count Filter and SortByKeyInt; and Thor had better execution times for AggregateByKey,  AggregateByKeyInt, DataGenerationString and DataGenerationInt. Furthermore, for a dataset too large to fit in memory, Thor had better execution times than Spark on all but one benchmark function. Spark and Thor had similar execution times for SortByKey.

## Click [here](Documentation) to read the document describing the performance comparison.

## Click [here](benchmarks) to see both Thor's ECL code and Spark's scala code.
