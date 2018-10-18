//------------------------------------------------WEEK 3----------------------------------------------
//Obtain data fsrom CSV file

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
	~data1[n] = ~data1[n].normalize(500,1000);

};
)

//Normalize by subtracting by data[i][0]
(
324.do{|n|
	~data2[n]=(~data2[n].asInteger)-(~data2[n][0].asInteger);
	~data2[n] = ~data2[n].normalize(500,1000);

};
)

//Averaged values
(
~dataavg = Array.fill(35,{arg i; ~data[i].asInteger.sum});
~dataavg = ~dataavg.normalize(400,1200).round(1);
)

~data.postln;
~data1.postln;
~data2.postln;

(
~datatransposeRAPE = Array2D.new(12,36);
~datatransposeKIDNAPPING = Array2D.new(12,36);
~datatransposeDOWRY = Array2D.new(12,36);
~datatransposeASSAULT = Array2D.new(12,36);
~datatransposeINSULT = Array2D.new(12,36);
~datatransposeHUSBAND = Array2D.new(12,36);
~datatransposeTRAFFIC = Array2D.new(12,36);
~datatransposeINDESCENTREP = Array2D.new(12,36);
~datatransposeTOTAL = Array2D.new(12,36);

36.do{|i|
	12.do{|j|
		~datatransposeRAPE.put(j,i,~data[i][j]);
		~datatransposeKIDNAPPING.put(j,i,~data[i+(36*1)][j]);
		~datatransposeDOWRY.put(j,i,~data[i+(36*2)][j]);
		~datatransposeASSAULT.put(j,i,~data[i+(36*3)][j]);
		~datatransposeINSULT.put(j,i,~data[i+(36*4)][j]);
		~datatransposeHUSBAND.put(j,i,~data[i+(36*5)][j]);
		~datatransposeTRAFFIC.put(j,i,~data[i+(36*6)][j]);
		~datatransposeINDESCENTREP.put(j,i,~data[i+(36*7)][j]);
		~datatransposeTOTAL.put(j,i,~data[i+(36*8)][j]);
	}
}
)

//-----------------------------------------------------------------------------------

b = Buffer.sendCollection(Server.local,[20, 30, 40, 50, 60, 70, 80, 90, 100, 1, 0, 0, 0, 1, 5, 1, 1, 4, 3, 11, 9, 10, 5, 12, 5, 10, 9, 7, 7, 14, 6, 5, 2]);

// Frequency modulation
(
y = {
	var modFreq = MouseY.kr(100,200).round(10);
	var modIndex = MouseX.kr(1,10);
	var modulator = EnvGen.ar(Env.new(~datatransposeRAPE.rowAt(0).asInteger,[0.5!35],-5),doneAction:2);
	var ampmod = EnvGen.ar(Env.new(~datatransposeRAPE.rowAt(5).asInteger,[0.5!35],-5),doneAction:2);
	SinOsc.ar(modulator+(modIndex * modFreq),mul:ampmod);
}.play
)

(
x = {
	var carrierFreq = EnvGen.ar(Env.new(~datatransposeRAPE.rowAt(0).asInteger,[0.5!35],-5),doneAction:2);
	var modulator = EnvGen.ar(Env.new(~datatransposeRAPE.rowAt(11).asInteger,[0.5!35],-5),doneAction:2);
	var ampmod = EnvGen.ar(Env.new(~datatransposeRAPE.rowAt(5).asInteger,[0.5!35],-5),doneAction:2);
	FreeVerb.ar(LPF.ar(LFNoise0.ar(carrierFreq + modulator),700),0.5,0.7);
}.play
)

//------------------------------------------------------------------------------


// Amplitude modulation, Ring modulation

(
x = {
	var carrier = Pulse.ar(EnvGen.ar(Env.new(~data2[rrand(0,36)]*10,[0.5!11],-5),doneAction:2));
	var modulator = Saw.ar(EnvGen.ar(Env.new(~data2[rrand(0,36)]*10,[0.5!11],-5),doneAction:2));
	carrier*modulator
}.play
)

(
x = {
	var freq = MouseX.kr(200,500);
	var carrier = Saw.ar(freq);
	var modulator = SinOsc.ar(EnvGen.ar(Env.new(~data2[rrand(0,36)]*10,[0.5!11],-5),doneAction:2));
	carrier*0.5+modulator
}.play
)


//---------------------------------------------------------------------------------

//One element at a time
(
SynthDef.new(\one,
{
	arg o1,o2,p,q;
	var amp1,amp2,r,s,out;
	amp1 = Line.kr(o1,0,1);
	amp2 = Line.kr(o2,0,1);
	r = FreeVerb.ar(SinOsc.ar(p,mul:amp1));
	s = FreeVerb.ar(Formant.ar(q,mul:amp2));
	out = r*s;
	Out.ar([0,1],out);
}).add;
)

(
~first = rrand(0,8).postln;
~second = rrand(0,35).postln;
~third1 = rrand(0,11).postln;
~third2 = rrand(0,11).postln;
Synth.new(\one,[\o1,~data2[~second*~first][~third1],\o2,~data2[~second*~first][~third2],\p,~data2[~second*~first][~third1],\q,~data2[~second*~first][~third2]]);
)

s.freeAll

//--------------------------------------------------------------------------------------

//Play with India ppt
(
{FreeVerb.ar(SinOsc.ar(EnvGen.ar(Env.new(~dataavg,[1!35],10),doneAction:2)),0.5,0.5)}.play;
)

//----------------------------------------------------------------------------------------

// Applying filters made from the data on Buffers

b=Buffer.read(Server.local,"C:/Users/Surabhi/Desktop/IIITD/IP/Buffers/Tic Toc wav.wav");
b.play;
~data2[32]
~data[2]
~data2[2]
{LPF.ar(PlayBuf.ar(1,b),750)*SinOsc.ar(EnvGen.ar(Env.new(~data2[32],[1!11]),doneAction:2))*2}.play
{HPF.ar(PlayBuf.ar(1,b),750)*SinOsc.ar(EnvGen.ar(Env.new(~data2[32],[1!11]),doneAction:2))*2}.play
c=Buffer.read(Server.local,"C:/Users/Surabhi/Desktop/IIITD/IP/Buffers/Sleigh-Bells-Christmas-Sounds-SOUND-EFFECT-freesound.wav");
c.play;
{BPF.ar(PlayBuf.ar(1,c),750)*SinOsc.ar(EnvGen.ar(Env.new(~data1[32],[1!11]),doneAction:2))*2}.play

d=Buffer.read(Server.local,"C:/Users/Surabhi/Desktop/IIITD/IP/Buffers/ABC_Song.wav");
d.play;
{BPF.ar(PlayBuf.ar(1,d),500)*SinOsc.ar(EnvGen.ar(Env.new(~data1[rrand(0,323)],[1.36!11]),doneAction:2))*2}.play

{FreqShift.ar(PlayBuf.ar(1,d),[~data[40][0].asInteger,~data[40][11].asInteger])}.play
//-----------------------------------------------------------------------------------------

// Working with GUI to control parameters - DOESNT WORK, CANNOT SET ARGS VIA GUI, Soln in Progress_5 - setting global var and reevaluating synth

(
~mySynth =
{

	arg a, b;
	//c = 30, d = 4, e = 50, f = 6, g = 70, h = 8;
	a.postln;
	a.source.postln;
	a.source.values[0].postln;
	b.source.values[1].postln;
	h.source.value.postln;
	/*SinOsc.ar(~data2[a.source.values.round(1).asInteger[0]][b.source.values.round(1).asInteger[0]]*10,0,0.2) +
	SinOsc.ar(~data2[c.source.values.round(1).asInteger[0]][d.source.values.round(1).asInteger[0]]*10,0,0.2) +
	SinOsc.ar(~data2[e.source.values.round(1).asInteger[0]][f.source.values.round(1).asInteger[0]]*10,0,0.2) +
	SinOsc.ar(~data2[g.source.values.round(1).asInteger[0]][h.source.values.round(1).asInteger[0]]*10,0,0.2)*/
	~data2[a.source.values[0]][b.source.values[1]].postln;
	SinOsc.ar(~data2[a.source.values[0]][b.source.values[1]],0,0.2)
	//SinOsc.ar(~data2[30][4],0,0.2)
	//SinOsc.ar(~data2[50][6],0,0.2)
	//SinOsc.ar(~data2[70][8],0,0.2)
}.play
)

(
SynthDef.new(\myS,{
	arg a, b, c, d;
	e = SinOsc.ar(a,0,0.2);// +
	/*SinOsc.ar(b,0,0.2) +
	SinOsc.ar(c,0,0.2) +
	SinOsc.ar(d,0,0.2);*/
	Out.ar([0,1],e);
}).add;
)
x = 10;
y = 2;
n = Synth.new("myS", [\a,~data2[x][y], \b,4])
n.set(\a,~data2[x][y],\b,4)

(
var sliderLables = [\slider1, \slider2, \slider3, \slider4, \slider5, \slider6, \slider7, \slider8];
var controlSpecs = [ControlSpec(0,323),ControlSpec(0,323),ControlSpec(0,323),ControlSpec(0,323),ControlSpec(0,323),ControlSpec(0,323), ControlSpec(0,323),ControlSpec(0,323)];
var synthArg = [\a,\b,\c,\d,\e,\f,\g,\h];
w = Window("mySynth",350@300);
w.front;
~sliderArray = Array.fill(8,{ |i| EZSlider(w,Rect(10,10 + (i * 30),300,20),sliderLables[i],controlSpecs[i])});
//8.do{|i|
~sliderArray[i].action = {|slider| ~mySynth.set(\a,slider.value.round(1))};
//};
)

//---------------------------------------------------------
(
~mySynth = { var freq1 = rrand(0,323), freq2 = rrand(0,323), freq3 = rrand(0,323), freq4 = rrand(0,323);
	freq1.postln;freq2.postln;freq3.postln;freq4.postln;
	SinOsc.ar(EnvGen.ar(Env.new(~data2[freq1]*10,[1!11],5),doneAction:2),0,0.2) + SinOsc.ar(EnvGen.ar(Env.new(~data2[freq2]*10,[1!11],5),doneAction:2),0,0.2) + SinOsc.ar(EnvGen.ar(Env.new(~data2[freq3]*10,[1!11],5),doneAction:2),0,0.2) + SinOsc.ar(EnvGen.ar(Env.new(~data2[freq4]*10,[1!11],5),doneAction:2),0,0.2)
}.play;
)
//-------------------------------------------------------------------------------------------------