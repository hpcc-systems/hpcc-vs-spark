#WORKUNIT('name', 'SortByKey');
dataset_name := '~benchmark::string::200GB';

rs_str := {string10 key, string90 fill};
outdata := DATASET(dataset_name, rs_str, THOR);
outdata1 := sort(outdata, key);
OUTPUT(CHOOSEN(outdata1,10));

