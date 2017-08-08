#WORKUNIT('name', 'SortByKeyInt');
dataset_name := '~benchmark::integer::200GB';

rs := {integer key, integer fill};
outdata := DATASET(dataset_name, rs, THOR);
outdata1 := sort(outdata, key);
output(CHOOSEN(outdata1,10));
