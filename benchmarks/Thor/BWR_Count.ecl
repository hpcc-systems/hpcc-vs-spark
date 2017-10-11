#WORKUNIT('name', 'Count');
dataset_name := '~benchmark::integer::200GB';

rs := {integer key, integer fill};
outdata := DATASET(dataset_name, rs, THOR);
output(COUNT(NOFOLD(outdata)));
