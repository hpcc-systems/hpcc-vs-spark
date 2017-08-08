#WORKUNIT('name', 'DataGenerationInteger');

unique_keys :=  100000;  // Should be less than number of records
unique_values := 10212; // Should be less than number of records
dataset_name := '~benchmark::integer::200GB'; // dataset_name should be the same in terasort.ecl and should correspond with number of records selected below.
totalrecs := 12500000000; //2030000000 //5000000000
unsigned8 numrecs := totalrecs/CLUSTERSIZE;    // total data size - 203GB

rec := {integer  key, integer  fill};
outdata := DATASET(totalrecs, transform(rec, self.key := random() % unique_keys; self.fill := random() % unique_values;), DISTRIBUTED); 

OUTPUT(outdata,,dataset_name,overwrite);



