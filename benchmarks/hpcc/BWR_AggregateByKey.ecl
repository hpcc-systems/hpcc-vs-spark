#WORKUNIT('name', 'AggregateByKey');
unique_keys :=  100000;  // Should be less than number of records
unique_values := 10212; // Should be less than number of records
dataset_name := '~benchmark::string::200GB';

rs := {integer key, integer fill};
rs_str := {string10 key, string90 fill};
outdata := DATASET(dataset_name, rs_str, THOR);

outdata1 := project(outdata, transform(rs, self.key:=(integer)left.key % unique_keys; self.fill:=ABS((integer)left.fill) % unique_values;));
outdata2 := table(outdata1, {key, sum(group, fill)}, key, FEW);
OUTPUT(CHOOSEN(outdata2, 10));
