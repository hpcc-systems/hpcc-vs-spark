<span id="_Toc423597827" class="anchor"><span id="_Toc492896162" class="anchor"><span id="_Toc495415016" class="anchor"></span></span></span>Introduction
=========================================================================================================================================================

In the past, there have been papers that discussed the performance of Apache Spark<sup>1</sup>. But, no paper has compared the Apache Spark’s performance to the HPCC Systems Thor cluster<sup>2</sup> performance.

When we first became interested in comparing a Thor cluster to an Apache Spark cluster we started to look at the performance of a Thor cluster when executing the Gray Sort. Why? Because a Spark cluster had won the 2014 Gray Sort competition where 100 TBs of data where sorted using 206 AWS i2.8xlarge instance types<sup>1</sup>. We abandoned this effort because of the expense of 206 i2.8xlarge instance types (currently $6.820 per instance per hour or $1,404.92 per hour for 206 instances)<sup>3</sup>.

We decided to host both a Thor and Apache Spark clusters on a lower cost AWS instance type and few of them. We felt this would be a good test for two reasons: 1) the lower cost made it possible to do the experiments, and 2) most often those interested in using a data cluster like the Thor or Apache Spark would use a smaller number of instances and if they used AWS they would probably use a less expensive instance type. Also, we decided to test the performance of both clusters on a variety of different functions because it would give the reader a better feel for what computation each cluster type performed best. <span id="_Toc492896163" class="anchor"></span>

Cluster Specifications
======================

Both the Thor and Spark clusters were created on AWS with one r3.2xlarge instance type for the master and 3 r3.2xlarge instance types for slaves. The r3.2xlarge instance type has 8 cores, 61 GB RAM, and 160 GB SSD storage.

<span id="_Toc492896164" class="anchor"><span id="_Toc495415018" class="anchor"></span></span>2.1 Thor
------------------------------------------------------------------------------------------------------

A parameter that was set on the Thor is the number of slave nodes per instance, i.e. slavesPerNode. This parameter determines A) how many file parts exists on each instance, e.g. if there are 16 slave nodes per instance then each logical file will have 16 parts on each instance, and b) the number of virtual slave nodes on each slave instance.

We tried 3 different settings for slavesPerNode, 4, 8, and 16. We got the fastest execution times with slavesPerNode set to 16. The execution times shown in this paper are for slavesPerNode set to 16.

<span id="_Toc492896165" class="anchor"><span id="_Toc495415019" class="anchor"></span></span>2.2 Spark
---------------------------------------------------------------------------------------------------

There are three parameters we have considered while tuning the performance of Spark namely number of executors, executor core, and executor memory. We found that fastest execution times with executors as 24, executor core as 1 and executor memory is 7000MB.

<span id="_Toc492896166" class="anchor"><span id="_Toc495415020" class="anchor"></span></span>Experimental Methodology
======================================================================================================================

The functions executed by both the Thor and Apache Spark clusters were selected for 2 reasons: 1) both have these functions as fundamental operations (for HPCC Systems in the ECL language and for Spark in the Scala language); and 2) others have used the same functions studying the performance of the Apache Spark cluster<sup>4</sup>.

<span id="_Toc492896167" class="anchor"><span id="_Toc495415021" class="anchor"></span></span>3.1 Data Generation
-----------------------------------------------------------------------------------------------------------------

In this work, we have tried to emulate the standard practice of benchmarking followed by other works. Benchmark’s requiring integer data were run with 12.5 billion records for the 100 GB dataset and 25 billion for 200 GB dataset. While, benchmark’s requiring string data were run with 1 billion records for the 100 GB dataset and 2 billion for the 200 GB. A record of string data has 10 bytes for the key field and 90 bytes for the fill field; while, a record of integer data has 8 bytes for the key field and 8 bytes for the fill field.

For the data, we chose 2 sizes: 100 GB and 200 GB. These sizes were chosen because 100GB when partitioned (distributed) to the 3 slave instances would fit in RAM (61 GB of RAM per instance). And, 200 GB was selected because it would not fit in RAM.

<span id="_Toc492896169" class="anchor"><span id="_Toc495415022" class="anchor"></span></span>3.2 Benchmarking Functions
------------------------------------------------------------------------------------------------------------------------

### <span id="_Toc492896170" class="anchor"><span id="_Toc495415023" class="anchor"></span></span>***3.2.1 Aggregate by String Key***

![](./media/image1.png)

### <span id="_Toc492896171" class="anchor"><span id="_Toc495415024" class="anchor"></span></span>***3.2.2 Aggregate by Integer Key***

![](./media/image2.png)

### <span id="_Toc492896173" class="anchor"><span id="_Toc495415025" class="anchor"></span></span>***3.2.3 Count***

![](./media/image3.png)

### <span id="_Toc492896174" class="anchor"><span id="_Toc495415026" class="anchor"></span></span>***3.2.4 Count with Filter***

![](./media/image4.png)

1.  ### <span id="_Toc492896175" class="anchor"><span id="_Toc495415027" class="anchor"></span></span>***Sort by String Key***

    ![](./media/image5.png)

### <span id="_Toc492896176" class="anchor"><span id="_Toc495415028" class="anchor"></span></span>***3.2.6 Sort by Integer Key***

![](./media/image6.png)

<span id="_Toc492896177" class="anchor"><span id="_Toc495415029" class="anchor"></span></span>4. Results: Comparison of Thor to Apache Spark
============================================================================================================================================

Below are the bar charts comparing execution times for each benchmark function executed on both Apache Spark and Thor. In section 4.1 and section 4.2 there are 2 bar charts that compare Apache Spark to Thor. The 1<sup>st</sup> bar chart compares execution times when the size of the data is 100GB; while, the 2<sup>nd</sup> compares execution times when the size of the data is 200 GB. In each bar chart, there are 2 bars: one for Spark (**Blue bars**), and one for Thor (**tan**).

### 4.1 Bar Charts Comparing Execution Times When Data was 100GB 

![](./media/barchart100GB.png)

### 4.2 Bar Charts Comparing Execution Times When Data was 200GB 

![](./media/barchart200GB.png)

<span id="_Toc492896181" class="anchor"></span>

<span id="_Toc495415032" class="anchor"><span id="_Toc492896182" class="anchor"><span id="_Toc423597838" class="anchor"></span></span></span>4.3 Gain Bar Charts
----------------------------------------------------------------------------------------------------------------------------------------------------------------

In this section, there are 2 bar graphs showing the gain where the gain calculation is: Thor’s execution over Spark’s execution. The 1<sup>st</sup> graph shows the gain when the inputted dataset size is 100GB. The 2<sup>nd</sup>, shows the gain when the inputted dataset size is 200 GB.

Any gain above 1.0 means Spark had a better execution time. And, gains below 1.0 means Thor had a better execution. You will notice that all but one gain is below 1.0.

### 4.3 Gains for Execution Times of Section 4.1

![](./media/Gain100GB.png)

![](./media/Gain200GB.png)

<span id="_Toc492896183" class="anchor"><span id="_Toc495415034" class="anchor"></span></span>Appendix A. ECL Code for HPCC Systems
===================================================================================================================================

Below is the ECL code that executes the benchmark functions. You will notice that the last statement of each function is an OUTPUT that outputs the COUNT, i.e. the number of records in the resulting dataset. The main purpose for this statement is to cause the execution of the code. Why? Because statements of an ECL program do NOT execute until an “action” statement is encounter. The OUTPUT statement is our “action” statement.

Also, we have added a statement that one would normally not use, the NOFOLD statement. Why? When doing a COUNT after a SORT, the code generator noticed that since your output was only the COUNT of the sorted dataset, the sort didn’t need to be done because the COUNT of the sorted dataset is that same as the original unsorted dataset. So, the code generated simply created code that gets the COUNT from the meta data of the original unsorted dataset. The NOFOLD statement causes the SORT to be performed.

A.1 BWR\_AggregateByKey.ecl
---------------------------

\#WORKUNIT('name', 'AggregateByKey');

unique\_keys := 100000;

unique\_values := 10212;

dataset\_name := '~benchmark::string';

rs := {integer key, integer fill};

rs\_str := {string10 key, string90 fill};

outdata := DATASET(dataset\_name, rs\_str, THOR);

outdata1 := project(outdata, transform(rs, self.fill:=ABS((integer)left.fill); self:=left));

outdata2 := table(outdata1, {key, sum(group, fill)}, key, FEW);

OUTPUT(COUNT(NOFOLD(outdata2)));

A.2 BWR\_AggregateByKeyInt.ecl
------------------------------

\#WORKUNIT('name', 'AggregateByKeyInt');

dataset\_name := '~benchmark::integer';

rs := {integer key, integer fill};

outdata := DATASET(dataset\_name, rs, THOR);

outdata1 := table(outdata, {key, sum(group, fill)}, key, FEW);

OUTPUT(COUNT(NOFOLD(outdata1)));

A.3 BWR\_Count.ecl
------------------

\#WORKUNIT('name', 'Count');

dataset\_name := '~benchmark::integer';

rs := {integer key, integer fill};

outdata := DATASET(dataset\_name, rs, THOR);

OUTPUT(COUNT(NOFOLD(outdata)));

A.4 BWR\_CountWithFilter.ecl
----------------------------

\#WORKUNIT('name', 'CountWithFilter');

dataset\_name := '~benchmark::integer';

rs := {integer key, integer fill};

outdata := DATASET(dataset\_name, rs, THOR);

OUTPUT(COUNT(NOFOLD(outdata(fill%2=1))));

A.5 BWR\_DataGenerationInteger.ecl
----------------------------------

\#WORKUNIT('name', 'DataGenerationInteger');

IMPORT STD;

unique\_keys := 100000;

unique\_values := 10212;

dataset\_name := '~benchmark::integer';

totalrecs := 12500000000;

unsigned8 numrecs := totalrecs/CLUSTERSIZE;

rec := {integer key, integer fill};

outdata := DATASET(totalrecs, transform(rec, self.key := random() % unique\_keys; self.fill := random() % unique\_values;), DISTRIBUTED);

IF( not STD.File.FileExists(dataset\_name)

,OUTPUT(outdata,,dataset\_name)

,OUTPUT('Dataset '+dataset\_name+' ALREADY EXISTS.')

);

A.6 BWR\_DataGenerationString.ecl
---------------------------------

\#WORKUNIT('name', 'DataGenerationString');

IMPORT STD;

dataset\_name := '~benchmark::string';

totalrecs := 2000000000;

unsigned8 numrecs := totalrecs/CLUSTERSIZE;

rec := {string10 key, string90 fill};

unique\_keys := 100000;

unique\_values := 10212;

STRING10 gen\_key() := INTFORMAT(RANDOM()%unique\_keys,10,1);

STRING10 gen\_fill() := INTFORMAT(RANDOM()%unique\_values,90,1);

outdata := DATASET(totalrecs, transform(rec, self.key := gen\_key(), self.fill := gen\_fill()), DISTRIBUTED);

OUTPUT(outdata,,dataset\_name,overwrite);

A.7 BWR\_SortByKey.ecl
----------------------

\#WORKUNIT('name', 'SortByKey');

dataset\_name := '~benchmark::string';

rs\_str := {string10 key, string90 fill};

outdata := DATASET(dataset\_name, rs\_str, THOR);

outdata1 := sort(outdata, key);

OUTPUT(COUNT(NOFOLD(outdata1)));

A.8 BWR\_SortByKeyInt.ecl
-------------------------

\#WORKUNIT('name', 'SortByKeyInt');

dataset\_name := '~benchmark::integer';

rs := {integer key, integer fill};

outdata := DATASET(dataset\_name, rs, THOR);

outdata1 := sort(outdata, key);

OUTPUT(COUNT(NOFOLD(outdata1)));

<span id="_Toc423597842" class="anchor"><span id="_Toc492896191" class="anchor"><span id="_Toc495415043" class="anchor"></span></span></span>Appendix B. Code for Spark (Scala)
===============================================================================================================================================================================

class AggregateByKey(sc: SparkContext) extends KVDataTest(sc) {

  override def runTest(rdd: RDD[\_], reduceTasks: Int) {

    rdd.asInstanceOf[RDD[(String, String)]]

      .map{case (k, v) =\> (k, v.toInt)}.reduceByKey(\_ + \_, reduceTasks).count()

  }

}

class AggregateByKeyInt(sc: SparkContext) extends KVDataTest(sc, "int") {

  override def runTest(rdd: RDD[\_], reduceTasks: Int) {

    rdd.asInstanceOf[RDD[(Int, Int)]]

      .reduceByKey(\_ + \_, reduceTasks).count()

  }

}

class AggregateByKeyNaive(sc: SparkContext) extends KVDataTest(sc) {

  override def runTest(rdd: RDD[\_], reduceTasks: Int) {

    rdd.asInstanceOf[RDD[(String, String)]]

      .map{case (k, v) =\> (k, v.toInt)}.groupByKey.map{case (k, vs) =\> vs.sum}.count()

  }

}

class SortByKey(sc: SparkContext) extends KVDataTest(sc) {

  override def runTest(rdd: RDD[\_], reduceTasks: Int) {

    rdd.asInstanceOf[RDD[(String, String)]]

      .sortByKey(numPartitions=reduceTasks).count()

  }

}

class SortByKeyInt(sc: SparkContext) extends KVDataTest(sc, "int") {

  override def runTest(rdd: RDD[\_], reduceTasks: Int) {

    rdd.asInstanceOf[RDD[(Int, Int)]]

      .sortByKey(numPartitions=reduceTasks).count()

  }

}

class Count(sc: SparkContext) extends KVDataTest(sc, "int") {

  override def runTest(rdd: RDD[\_], reduceTasks: Int) {

    rdd.asInstanceOf[RDD[(Int, Int)]]

      .count()

  }

}

class CountWithFilter(sc: SparkContext) extends KVDataTest(sc, "int") {

  override def runTest(rdd: RDD[\_], reduceTasks: Int) {

    rdd.asInstanceOf[RDD[(Int, Int)]]

      .filter{case (k, v) =\> k.toInt % 2 == 1}.count()

  }

}

[1] [https://spark.apache.org/news/spark-wins-daytona-gray-sort-100tb-benchmark.html](../customXml/item1.xml)

[https://link.springer.com/chapter/10.1007/978-3-319-31409-9\_3](../customXml/item2.xml)

https://www.oreilly.com/ideas/investigating-sparks-performance

[2] An HPCC Systems ®can have 2 different types of clusters – a Thor and/or ROXIE cluster. A ROXIE cluster, or rapid delivery engine, functions as the engine that delivers answers to queries (e.g. from the web). The function of a Thor cluster is very similar to the function of a Spark cluster. Both are designed to execute big data workflows, such tasks as extraction, loading, cleansing, transformations, linking and indexing.

[3] i2.8xlarge instance type is a retired instance type. Today, an equivalent is i3.8xlarge which costs much less, $2.496 per hour.

[4] [https://wr.informatik.uni-hamburg.de/\_media/teaching/wintersemester\_2015\_2016/bd-1516-spark.pdf](numbering.xml)