//-------------------------------------------- WEEK 10, 11 -------------------------------------------------------------

//s.initTree

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
};
)

//Normalize by subtracting by data[i][0]
(
324.do{|n|
	~data2[n]=(~data2[n].asInteger)-(~data2[n][0].asInteger);
};
)


//Set global args and keep changing them using slider and re-evaluate synth each time----------------------------
(
~globala = 10;
~globalb = 2;
~globalc = 30;
~globald = 4;
~globale = 50;
~globalf = 6;
~globalg = 70;
~globalh = 8;
)

q = [500,700,800,1000]
~global = 2;
(
SynthDef.new(\mySynth,{
	var sig;
/*	sig = SinOsc.ar(~data2[~globala][~globalb]*100,0,0.25,0)+
	SinOsc.ar(~data2[~globalc][~globald]*100,90,0.25,0.2)+
	SinOsc.ar(~data2[~globale][~globalf]*100,180,0.25,0.4)+
	SinOsc.ar(~data2[~globalg][~globalh]*100,270,0.25,0.8);*/
	sig = SinOsc.ar(q[~global],0,1,0);
	/*SinOsc.ar(~data2[~globalc][~globald]*100,90,0.25,0.2)+
	SinOsc.ar(~data2[~globale][~globalf]*100,180,0.25,0.4)+
	SinOsc.ar(~data2[~globalg][~globalh]*100,270,0.25,0.8);
*/
	Out.ar([0,1],sig)
}).add
)

Synth.new(\mySynth)

(
var sliderLables = [\slider1, \slider2, \slider3, \slider4, \slider5, \slider6, \slider7, \slider8];
var controlSpecs = [ControlSpec(0,3),ControlSpec(0,323),ControlSpec(0,323),ControlSpec(0,323),ControlSpec(0,323),ControlSpec(0,323), ControlSpec(0,323),ControlSpec(0,323)];
var synthArg = [\a,\b,\c,\d,\e,\f,\g,\h];
w = Window("mySynth",350@300);
w.front;
~sliderArray = Array.fill(8,{ |i| EZSlider(w,Rect(10,10 + (i * 30),300,20),sliderLables[i],controlSpecs[i])});
~sliderArray[0].action = {|slider| ~global=slider.value.postln; ~global.round(1).postln; s.free; Synth.new(\mySynth)};
/*~sliderArray[1].action = {|slider| ~globalb=slider.value.postln; ~globalb.round(1).postln; s.free; Synth.new(\mySynth)};
~sliderArray[2].action = {|slider| ~globalc=slider.value.postln; ~globalc.round(1).postln; s.freeAll; Synth.new(\mySynth)};
~sliderArray[3].action = {|slider| ~globald=slider.value.postln; ~globald.round(1).postln; s.freeAll; Synth.new(\mySynth)};
~sliderArray[4].action = {|slider| ~globale=slider.value.postln; ~globale.round(1).postln; s.freeAll; Synth.new(\mySynth)};
~sliderArray[5].action = {|slider| ~globalf=slider.value.postln; ~globalf.round(1).postln; s.freeAll; Synth.new(\mySynth)};
~sliderArray[6].action = {|slider| ~globalg=slider.value.postln; ~globalg.round(1).postln; s.freeAll; Synth.new(\mySynth)};
~sliderArray[7].action = {|slider| ~globalh=slider.value.postln; ~globalh.round(1).postln; s.freeAll; Synth.new(\mySynth)};*/
)

//-------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------

//Back to animation data
//42 points of sound instead of 3 parts/regions

{{rrand(100,1500)}!42}!2
Pbind(\freq,Pseq({{rrand(0,2000)}!42}!119,1),\dur,1).play;

//------------------------------------------------------------------------
(
~data_abstract_shape = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Animation_Data/abstractShape.csv",true);
~data_abstract_shape.removeAt(0);
~data_abstract_shape.postln;
~numrows = ~data_abstract_shape.size;
~numcols = ~data_abstract_shape[0].size;
~data_abstract_shape = Array2D.fromArray(~numrows, ~numcols, ~data_abstract_shape.flatten);
)


//Form Euclidean distance vector--------------------------------------------------------------------------
(
~store = 0!10038;
for(42, 10037, {arg i;
	~one = ~data_abstract_shape[i,2].asFloat - ~data_abstract_shape[i%42,2].asFloat;
	~two = ~data_abstract_shape[i,3].asFloat - ~data_abstract_shape[i%42,3].asFloat;
	~three = ~data_abstract_shape[i,4].asFloat - ~data_abstract_shape[i%42,4].asFloat;
	~val = ((~one*~one) + (~two*~two) + (~three*~three));
	~store[i] = sqrt(~val);
})
)


//42 points-----------------------------------------------------------------------------
(
a = {0!239}!42;
)

(
(
for (0, 238, { arg i;

	for(0, 41, {arg j;
		~inde = (i*42+j);
		a[j][i] = ~store[~inde].asFloat;
	});
});
);

//Normalize in the range 0-2
for(0,41,{arg i;
	a[i] = a[i].normalize(0,2);
});
)

(
x = 880!14;
y = 1108!14;
z = 1318!14;
~notes = x++y++z;
~notestemp = Array.fill(42,{arg i; 0});
)


~go = 0.1;
(
~rout = Routine({
	for(0, 119, {arg i;

		for(0,41, {arg j;

			// if(a[j][i*2]<0.2,{~notestemp[j] = ~notes[j]});
			// if((a[j][i*2]>0.2) && (a[j][i*2]<0.3),{~notestemp[j] = ~notes[j]-rrand(0,20)});
			// if((a[j][i*2]>0.3) && (a[j][i*2]<0.5),{~notestemp[j] = ~notes[j]-rrand(20,40)});
			// if((a[j][i*2]>0.5) && (a[j][i*2]<0.7),{~notestemp[j] = ~notes[j]-rrand(40,60)});
			// if((a[j][i*2]>0.7) && (a[j][i*2]<1),{~notestemp[j] = ~notes[j]-rrand(60,80)});
			// if((a[j][i*2]>1) && (a[j][i*2]<1.3),{~notestemp[j] = ~notes[j]-rrand(60,80)});
			// if((a[j][i*2]>1.5) && (a[j][i*2]<1.5),{~notestemp[j] = ~notes[j]-rrand(0,60)});
			// if((a[j][i*2]>1.5) && (a[j][i*2]<1.8),{~notestemp[j] = ~notes[j]-rrand(20,40)});
			// if((a[j][i*2]>1.8) && (a[j][i*2]<=2),{~notestemp[j] = ~notes[j]-rrand(0,20)});


			if(a[j][i*2]<0.2,{~notestemp[j] = ~notes[j]});
			if((a[j][i*2]>0.2) && (a[j][i*2]<0.3),{~notestemp[j] = ~notes[j]-rrand(0,20)});
			if((a[j][i*2]>0.3) && (a[j][i*2]<0.5),{~notestemp[j] = ~notes[j]+rrand(0,20)});
			if((a[j][i*2]>0.5) && (a[j][i*2]<0.7),{~notestemp[j] = ~notes[j]-rrand(20,40)});
			if((a[j][i*2]>0.7) && (a[j][i*2]<1),{~notestemp[j] = ~notes[j]+rrand(20,40)});
			if((a[j][i*2]>1) && (a[j][i*2]<1.3),{~notestemp[j] = ~notes[j]-rrand(40,60)});
			if((a[j][i*2]>1.5) && (a[j][i*2]<1.5),{~notestemp[j] = ~notes[j]+rrand(40,60)});
			if((a[j][i*2]>1.5) && (a[j][i*2]<1.8),{~notestemp[j] = ~notes[j]-rrand(60,80)});
			if((a[j][i*2]>1.8) && (a[j][i*2]<=2),{~notestemp[j] = ~notes[j]+rrand(60,80)});

		});

		~notestemp.postln;
		Pbind(\freq,Pseq([~notestemp],1),\dur,0.1).play;
		~go.yield;
	});
});
)

(
~rout.play;
//s.record;
)