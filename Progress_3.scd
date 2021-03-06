//------------------------------------------- WEEK 4 5 6 ----------------------------------------------

(
~data_abstract_shape = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Animation_Data/abstractShape_pointwise.csv",true);

//~data_covering_shape = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Animation_Data/packingTheSphere_500frames.csv",true);

~data_abstract_shape.removeAt(0);
~data_abstract_shape.postln;
~numrows = ~data_abstract_shape.size;
~numcols = ~data_abstract_shape[0].size;
~data_abstract_shape = Array2D.fromArray(~numrows, ~numcols, ~data_abstract_shape.flatten);
)

//Remove negatives
(
~newarr = [0]!~numcols;
~newarr[0] = ~data_abstract_shape.colAt(0);
~newarr[1] = ~data_abstract_shape.colAt(1);
~newarr[2] = ~data_abstract_shape.colAt(2);
~newarr[3] = ((~data_abstract_shape.colAt(3).asFloat + 2)*1000000000);
~newarr[4] = ((~data_abstract_shape.colAt(4).asFloat + 2)*1000000000);
~newarr[5] = ((~data_abstract_shape.colAt(5).asFloat + 2)*1000000000);
~newarr = ~newarr.flop
)

//-----------------------------------------------
//Shallow vs Deep copy
//Say a,b are arrays
//a = b makes shallow copy, changing one changes the other
//For deep copy, do the following:
(
a = [1,2,3,4,5];
b = Array.fill(5,{arg i; a[i]});
b[2] = 9;
b.postln;
a.postln;
)
//-----------------------------------------------

//Make deep copies of ~newarr
(
~newarr1 = Array2D.fromArray(~numrows, ~numcols, ~newarr.flatten);
~newarr2 = Array2D.fromArray(~numrows, ~numcols, ~newarr.flatten);
)

//--------------------------------------------

//APPROACH 1

//Tried normalizing entire column in one go, but that creates very little variation across consecutive samples. Hence need to normalize pointwise

//Normalize and scale in chunks pointwise (normalize rows of individual points)

(
for (0, 41, { arg i; (i*239).postln;
	~temp1 = 0!239;
	~temp2 = 0!239;
	~temp3 = 0!239;

	for(0, 238, {arg j; (i*239+j).postln;
		~ind = (i*239+j);
		~temp1[j] = ~newarr[~ind][3];
		~temp2[j] = ~newarr[~ind][4];
		~temp3[j] = ~newarr[~ind][5];
	});

	~temp1 = ~temp1.normalize(24*i+200,24*i+208);
	~temp2 = ~temp2.normalize(24*i+208,24*i+216);
	~temp3 = ~temp3.normalize(24*i+216,24*i+224);

	for(0, 238, {arg j; (i*239+j).postln;
		~ind = (i*239+j);
		~newarr[~ind][3] = ~temp1[j];
		~newarr[~ind][4] = ~temp2[j];
		~newarr[~ind][5] = ~temp3[j];
	});
});
)

(
for (0, 41, { arg i; (i*239).postln;
	~temp1 = 0!239;
	~temp2 = 0!239;
	~temp3 = 0!239;

	for(0, 238, {arg j; (i*239+j).postln;
		~ind = (i*239+j);
		~temp1[j] = ~newarr1[~ind,3];
		~temp2[j] = ~newarr1[~ind,4];
		~temp3[j] = ~newarr1[~ind,5];
	});

	~temp1 = ~temp1.normalize(200,500);
	~temp2 = ~temp2.normalize(500,800);
	~temp3 = ~temp3.normalize(800,1100);

	for(0, 238, {arg j; (i*239+j).postln;
		~ind = (i*239+j);
		~newarr1[~ind,3] = ~temp1[j];
		~newarr1[~ind,4] = ~temp2[j];
		~newarr1[~ind,5] = ~temp3[j];
	});
});
)



//Routines and Patterns
//Var for given point across frames
~yield = 0.75;
~dur = 0.25
~point = 30
(
~rout1 = Routine({
//	for (0, 41, { arg i; (i*239).postln;
	for(0, 238, {arg j; (40*239+j).postln;

			~yield.yield;
			~newarr[~point*239+j][3].postln;
			~newarr[~point*239+j][4].postln;
			~newarr[~point*239+j][5].postln;
			Pbind(\freq,Pseq([~newarr[~point*239+j][3],~newarr[~point*239+j][4],~newarr[~point*239+j][5]],1),\dur,~dur).play;
		});
//	});
});
)


//Play and record routine
(
//s.record("C:/Users/Surabhi/Desktop/IIITD/IP/Recordings/out.wav");
~rout1.play;
)
~glo = 4
//Stop recorder and routine
(
//s.stopRecording;
~rout.stop;
)


//APPROACH 2
//Individual Coordinates separately

(
~pseqarrx = 0!239;
~pseqarry = 0!239;
~pseqarrz = 0!239;
for(0, 238, {arg j; (0*239+j).postln;
	~pseqarrx[0*239+j] = ~newarr1[j,3];
	~pseqarry[0*239+j] = ~newarr1[j,4];
	~pseqarrz[0*239+j] = ~newarr1[j,5];
});
)

//All these 3 together with dur = 0.03 will sound like above - if all were 100,1000 (and not 100-333, 333-666, 666-1000)
Pbind(\freq,Pseq(~pseqarrx.normalize(100,1000),1),\dur,0.1).play;//How x coordinate of any point is changing
Pbind(\freq,Pseq(~pseqarry.normalize(100,1000),1),\dur,0.1).play;//How y coordinate of any point is changing
Pbind(\freq,Pseq(~pseqarrz.normalize(100,1000),1),\dur,0.1).play;//How z coordinate of any point is changing
//OBSERVATION: x coordinate and z change the same


//Normalize frame wise


//----------------------------------------------------------------------------------------------------

//Make synthdefs and send data as arguements

~xc = 400;
~yc = 300;
~zc = 800;
(
~xcoord = {
	//arg value = 500;
	//var sig, noise, xadd, temp, amp;
	//amp = Line.kr(2,0,1);
	Saw.ar(~xc/2+rrand(10,20),Line.kr(2,0,1));
}.play;
~ycoord = {
	//arg value = 500;
	//var env, sig, yadd;
	//env = Env.perc;
	EnvGen.ar(Env.perc, doneAction: 0) * Pulse.ar(~yc, 0.25, 0.75);
}.play;
~zcoord = {
	//arg value=500;
	//var amp, zadd;
	//amp = Line.kr(2,0,1);
	SinOsc.ar(~zc,0,Line.kr(2,0,1));
}.play;
)



(
SynthDef.new(\xcoord,
{
	arg value = 500;
	var sig, noise, xadd, temp, amp;
	amp = Line.kr(2,0,1);
	sig = Saw.ar(value/2+rrand(10,20),amp);
	Out.ar([0,1],sig);
}).add;
)

(
SynthDef.new(\ycoord,
{
	arg t_gate = 1, value = 500;
	var env, sig, yadd;
	env = Env.perc;
	yadd = EnvGen.ar(env,t_gate,doneAction: 0) * Pulse.ar(value, 0.25, 0.75);
	Out.ar([0,1],yadd);
}).add;
)

(
SynthDef.new(\zcoord,
{
	arg value=500;
	var amp, zadd;
	amp = Line.kr(2,0,1);
	zadd = SinOsc.ar(value,0,amp);
	Out.ar([0,1],zadd);
}).add;
)

(
Synth.new(\xcoord);
Synth.new(\ycoord);
Synth.new(\zcoord);
)

//Task

(
~tasktest=Task({|i|
	/*~xc= Synth.new(\xcoord, [
		\value, ~newarr[0][3],
	]);
	~yc= Synth.new(\ycoord, [
		\value, ~newarr[0][4],
	]);
	~zc= Synth.new(\zcoord, [
		\value, ~newarr[0][5],
	]);*/

	238.do({arg item, i;

		(
			~xcoord = {Saw.ar([~newarr1[i,3]/2,~newarr1[i,3]/2],Line.kr(1,0,~dur));}.play;
			~ycoord = {EnvGen.ar(Env.perc(releaseTime:~dur), doneAction: 0) * Pulse.ar([~newarr1[i,4],~newarr1[i,4]], 0.25, 0.75);}.play;
			~zcoord = {SinOsc.ar([~newarr1[i,5],~newarr1[i,5]],0,Line.kr(1,0,~dur));}.play;
		);


		/*Synth.new(\xcoord, [
		\value, ~newarr[i][3]]);
		Synth.new(\ycoord, [
		\value, ~newarr[i][4]]);
		Synth.new(\zcoord, [
		\value, ~newarr[i][5]]);*/
		//~xc.set(\xcoord, one);
		//~yc.set(\t_gate,1,\value, two);
		//~zc.set(\zcoord, three);

		~dur.wait;

		~xcoord.free;
		~ycoord.free;
		~zcoord.free;
	})
});
)

~tasktest.play;
~dur = 0.05
{SinOsc.ar([1200,200])}.play

//----------------------------------------------------------------------------------------------------
//Tgrains
(
b=Buffer.read(Server.local,"C:/Users/Surabhi/Desktop/IIITD/IP/Buffers/Tic Toc wav.wav");
//b.play;

~trate = MouseY.kr(2,200,1);

~dur = 4 / ~trate;

~rate = Dseq([10, 1, 1, 0.5, 0.5, 0.2, 0.1], inf);
{TGrains.ar(2, Impulse.ar(~trate), b, ~rate, MouseX.kr(0,BufDur.kr(b)), ~dur, Dseq([-1, 1], inf), 0.1, 2)}.play;
)