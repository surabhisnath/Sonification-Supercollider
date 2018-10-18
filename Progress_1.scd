//--------------------------------------------WEEK 1-------------------------------------------------
(
SynthDef.new(\womencrime, { arg freq=0;
	var sig;
	sig = SinOsc.ar(freq);
	Out.ar([0,1],sig);
}).add;
)

//-----------------------------------------------------------------------------------

//Obtain data from CSV file

(
~data_state_crime = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Datasets/Crime_Women_States_CSV.csv",true);
~data_state_crime.removeAt(0);
)

(
~data = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Datasets/Crime_Women_States_CSV.csv",true);
~data1 = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Datasets/Crime_Women_States_CSV.csv",true);
~data2 = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Datasets/Crime_Women_States_CSV.csv",true);
~data.removeAt(0);
~data1.removeAt(0);
~data2.removeAt(0);
324.do{|n|
	~data[n].removeAt(0);
	~data[n].removeAt(0);
	~data1[n].removeAt(0);
	~data1[n].removeAt(0);
	if(~data1[n][0]==0,{~data1[n][0]=1};);
	~data2[n].removeAt(0);
	~data2[n].removeAt(0);
};
)

//Normalize by dividing by data[i][0]
(
324.do{|n|
	~data1[n]=~data1[n].asInteger/~data1[n][0].asInteger;
	~data1[n].postln;
	~data1[n] = ~data1[n].normalize(100,1000);
	~data1[n].postln;
};
)

//Normalize by subtracting by data[i][0]
(
324.do{|n|
	~data2[n]=(~data2[n].asInteger)-(~data2[n][0].asInteger);
	~data2[n].postln;
	~data2[n] = ~data2[n].normalize(500,1000);
	~data2[n].postln;
};
)

~data.postln;
~data1.postln;
~data2[32].postln;

//-----------------------------------------------------------------------------------

//1  AP
//2  Arun P
//3  Assam
//4  Bihar
//5  Chattisgarh
//6  Goa
//7  Gujarat
//8  Haryana
//9  Himachal
//10 Jammu
//11 Jharkhand
//12 Karnataka
//13 Kerala
//14 MP
//15 Maharashtra
//16 Manipur
//17 Meghalaya
//18 Mizoram
//19 Nagaland
//20 Odisha
//21 Punjab
//22 Rajasthan
//23 Sikkim
//24 TN
//25 Tripura
//26 UP
//27 Uttarakhand
//28 WB
//29 A&N
//30 Chandigarh
//31 D&N H
//32 Daman Diu
//33 Delhi
//34 Lakshadweep
//35 Pondicherry
//36 All states

//1 Rape
//2 Kidnapping
//3 Dowry deaths
//4

//-------------------------------------------
//Make synthdef and change frequency continuously - CORRECT (Keep setting inside the loop)

~type = 1;  //1 to 9
~state = 33 //1 to 36

(
{
	(	12.do{ |i|
		if(i==0,{x = Synth.new(\womencrime);});
		x.set(\freq,~data2[((~type-1)*36 + (~state-1))][i].asInteger);
		0.5.wait;
		if(i==11,{x.free})
	})
}.fork(t);
)


~data.postln;
~data1.postln;
~data2.postln;


//Make synthdef and change frequency continuously - WRONG

//Delhi RAPE
(
{
	(	12.do{ |i|
		x = {SinOsc.ar(~data[32][i].asInteger)}.play;
		0.5.wait;
		x.free;
	})
}.fork(t);
)


// Delhi KIDNAPPING
// (
// {
// 	(	12.do{ |i|
// 		x = {SinOsc.ar(data[68][i].asInteger)}.play;
// 		0.5.wait;
// 		x.free;
// 	})
// }.fork(t);
// )


//-----------------------------------------------------------------------------------------

Pbindef(\final, \note, Pseq(~data1[32].asInteger/30),\octave, 5, \dur, 1/2).play;//Delhi RAPE
Pbindef(\final, \note, Pseq(~data1[68].asInteger/30),\octave, 5, \dur, 1/2).play;//Delhi KIDNAPPING
Pbindef(\final, \note, Pseq(~data1[104].asInteger/30),\octave, 5, \dur, 1/2).play;//Delhi DOWRY DEATHS
Pbindef(\final, \note, Pseq(~data[140].asInteger/30),\octave, 5, \dur, 1/2).play;//Delhi ASSAULT
Pbindef(\final, \note, Pseq(~data[176].asInteger/30),\octave, 5, \dur, 1/2).play;//Delhi INSULT
Pbindef(\final, \note, Pseq(~data[212].asInteger/30),\octave, 5, \dur, 1/2).play;//Delhi CRUELTY BY HUSBAND
Pbindef(\final, \note, Pseq(~data[248].asInteger/30),\octave, 5, \dur, 1/2).play;//Delhi IMMORAL TRAFFIC
Pbindef(\final, \note, Pseq(~data[284].asInteger/30),\octave, 5, \dur, 1/2).play;//Delhi INDESCENT REPRESENTATION



//-------------------------------------------WEEK 2-----------------------------------------------

//MULTIPLE STATES' RAPE CASES, played SYNCHRONOUSLY

(
var en1, en2, en3;
en1 = Env.new((~data2[32]).asInteger,[0.5!11],5);
en2 = Env.new((~data2[68]).asInteger,[0.5!11],5);
en3 = Env.new((~data2[104]).asInteger,[0.5!11],5);
z = [en1,en2,en3];
)


(
a = {SinOsc.ar(EnvGen.kr(z[0],doneAction:2))*0.25};
b = {Pulse.ar(EnvGen.kr(z[1],doneAction:2))*0.25};
c = {Formant.ar(EnvGen.kr(z[2],doneAction:2))*0.25};
)

(
a.play;
b.play;
c.play;
)


//MULTIPLE STATES' RAPE CASES, played SEQUENCIALLY

d = [a,b,c]

(
{
	(	3.do{ |i|
		d[i].play;
		7.wait;
	})
}.fork(t);
)

//------------------------------------------------------------------------------------

//CONTINUOUS
{SinOsc.ar(EnvGen.ar(Env(~data[32].asInteger,[0.5!11]),doneAction:2))}.play//DELHI RAPE


//Duration and divide by factors controlled by a slider

//CONTROLLING DIFFERENT PARAMETERS
(
{
var e1, e2, e3, e4;
	e1 = EnvGen.ar(Env.new(~data[32].asInteger/50,[0.5!11],-5));//DELHI RAPE - add
	e2 = EnvGen.ar(Env.new(~data[68].asInteger/50,[0.5!11],5));//DELHI KIDNAPPING - amplitude
	e3 = EnvGen.ar(Env.new(~data[104].asInteger/50,[0.5!11],5));//DELHI DOWRY DEATHS - phase
	e4 = EnvGen.ar(Env.new(~data[140].asInteger,[0.5!11],-5),doneAction:2);//DELHI ASSAULT - freq
	SinOsc.ar(e4,e3,e2,e1)*0.25;
}.play
)


// Keep playing, randomly chooses any data
(
{
var temp = rrand(0,324);
var freq, signal;
temp.postln;
~data_state_crime[temp][0].postln;
~data_state_crime[temp][1].postln;
freq = EnvGen.kr(Env.new((~data1[temp]).asInteger,[0.25!11],5),doneAction: 2);
signal = Pulse.ar(freq)
}.play;
)

