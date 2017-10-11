#WORKUNIT('name', 'AggregateByKeyInt');
dataset_name := '~benchmark::integer::200GB';

rs := {integer key, integer fill};
outdata := DATASET(dataset_name, rs, THOR);
outdata1 := table(outdata, {key, sum(group, fill)}, key, FEW);
OUTPUT(COUNT(NOFOLD(outdata1)));
