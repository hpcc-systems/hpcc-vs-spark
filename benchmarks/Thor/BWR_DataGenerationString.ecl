#WORKUNIT('name', 'DataGenerationString');

dataset_name := '~benchmark::string::200GB'; // dataset_name should be the same in terasort.ecl and should correspond with number of records selected below.
totalrecs := 2000000000; //2030000000 //5000000000
unsigned8 numrecs := totalrecs/CLUSTERSIZE;    // 203GB total data size

rec := {string10  key, string90  fill};

string10 gen_key() := function
    return (>string1<)(48+RANDOM()%9)+
                (>string1<)(48+RANDOM()%9)+
                (>string1<)(48+RANDOM()%9)+
                (>string1<)(48+RANDOM()%9)+
                (>string1<)(48+RANDOM()%9)+
                (>string1<)(48+RANDOM()%9)+
                (>string1<)(48+RANDOM()%9)+
                (>string1<)(48+RANDOM()%9)+
                (>string1<)(48+RANDOM()%9)+
                (>string1<)(48+RANDOM()%9);
END;

string90 gen_fill():= function
    string1 c1 := (>string1<)(48+RANDOM()%9);
    string1 c2 := (>string1<)(RANDOM()%9+48);
    string1 c3 := (>string1<)(RANDOM()%9+48);
    string1 c4 := (>string1<)(RANDOM()%9+48);
    string1 c5 := (>string1<)(RANDOM()%9+48);
    string1 c6 := (>string1<)(RANDOM()%9+48);
    string1 c7 := (>string1<)(RANDOM()%9+48);
    string1 c8 := (>string1<)(RANDOM()%9+48);
    string1 c9 := (>string1<)(RANDOM()%9+48);
    return c1+c1+c1+c1+c1+c1+c1+c1+c1+c1+
             c2+c2+c2+c2+c2+c2+c2+c2+c2+c2+
             c3+c3+c3+c3+c3+c3+c3+c3+c3+c3+
             c4+c4+c4+c4+c4+c4+c4+c4+c4+c4+
             c5+c5+c5+c5+c5+c5+c5+c5+c5+c5+
             c6+c6+c6+c6+c6+c6+c6+c6+c6+c6+
             c7+c7+c7+c7+c7+c7+c7+c7+c7+c7+
             c8+c8+c8+c8+c8+c8+c8+c8+c8+c8+
             c9+c9+c9+c9+c9+c9+c9+c9+c9+c9;
  END;
  
outdata := DATASET(totalrecs, transform(rec, self.key := gen_key(), self.fill := gen_fill()), DISTRIBUTED);
OUTPUT(outdata,,dataset_name,overwrite);

