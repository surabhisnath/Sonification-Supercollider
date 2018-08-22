(
var data;
data = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/Other/IP/Datasets/Crime_Women_States_CSV.csv",true,true);
data.removeAt(0);
324.do{|n|
	data[n].removeAt(0);
	data[n].removeAt(0);
};

//Pbindef(\final, \note, Pseq(data[32].asInteger/30),\octave, 5, \dur, 1/4).play;//Delhi RAPE
//Pbindef(\final, \note, Pseq(data[68].asInteger/30),\octave, 5, \dur, 1/4).play;//Delhi KIDNAPPING
//Pbindef(\final, \note, Pseq(data[104].asInteger/30),\octave, 5, \dur, 1/4).play;//Delhi DOWRY DEATHS
//Pbindef(\final, \note, Pseq(data[140].asInteger/30),\octave, 5, \dur, 1/4).play;//Delhi ASSAULT
//Pbindef(\final, \note, Pseq(data[176].asInteger/30),\octave, 5, \dur, 1/4).play;//Delhi INSULT
//Pbindef(\final, \note, Pseq(data[212].asInteger/30),\octave, 5, \dur, 1/4).play;//Delhi CRUELTY BY HUSBAND
//Pbindef(\final, \note, Pseq(data[248].asInteger/30),\octave, 5, \dur, 1/4).play;//Delhi IMMORAL TRAFFIC
//Pbindef(\final, \note, Pseq(data[284].asInteger/30),\octave, 5, \dur, 1/4).play;//Delhi INDESCENT REPRESENTATION

//Make synthdef and change frequency continuously

(
{
(	12.do{ |i|
		x = {SinOsc.ar(data[32][i].asInteger)}.play;
		0.125.wait;
		x.free;
	})
}.fork(t);
)


)



