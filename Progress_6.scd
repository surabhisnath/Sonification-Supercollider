//------------------------------------- WEEK 12 (Mid-recess break), 13 --------------------------------------------------------
//Encapsulate all work with GUI to provide more user control

//-------------------------------------------------------------------------------------------------------
//Initialize all data

(
(
~data_state_crime = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Datasets/Crime_Women_States_CSV.csv",true);
~data_state_crime.removeAt(0);
);

Platform.userConfigDir.openOS;

(
~data = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Datasets/Crime_Women_States_CSV.csv",true);
~data1 = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Datasets/Crime_Women_States_CSV.csv",true);
~data2 = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Datasets/Crime_Women_States_CSV.csv",true);
~data.removeAt(0);
~data1.removeAt(0);
~data2.removeAt(0);

~states = ["Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar","Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh","Jammu & Kashmir", "Jharkhand", "Karnataka", "Kerala","Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram","Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim","Tamil Nadu", "Tripura", "Uttar Pradesh", "Uttarakhand","West Bengal", "A&N Islands", "Chandigarh", "D&N Haveli","Daman & Diu", "Delhi UT", "Lakshadweep", "Puducherry","All India"];
~crimes = ["RAPE","KIDNAPPING & ABDUCTION","DOWRY DEATH","ASSAULT","INSULT","CRUELTY BY HUSBAND/RELATIVES","IMMORAL TRAFFIC","INDECENT REPRESENTATION","TOTAL CRIMES"];
~years = ["2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012"];
~numstates = 36;

324.do{|n|
	~data[n].removeAt(0);
	~data[n].removeAt(0);
	~data1[n].removeAt(0);
	~data1[n].removeAt(0);
	if(~data1[n][0]==0,{~data1[n][0]=1};);
	~data2[n].removeAt(0);
	~data2[n].removeAt(0);
};
);

//Normalize by dividing by data[i][0]
(
324.do{|n|
	~data1[n]=~data1[n].asInteger/~data1[n][0].asInteger;
	~data1[n] = ~data1[n].normalize(500,1000);
};
);

//Normalize by subtracting by data[i][0]
(
324.do{|n|
	~data2[n]=(~data2[n].asInteger)-(~data2[n][0].asInteger);
	~data2[n] = ~data2[n].normalize(500,1000);
};
);

(
~dataavg = Array.fill(35,{arg i; ~data[i].asInteger.sum});
~dataavg = ~dataavg.normalize(400,1200).round(1);
);

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
);

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
);

//--------------------------

~points = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42];

(
~data_abstract_shape = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Animation_Data/abstractShape_pointwise.csv",true);
~data_abstract_shape.removeAt(0);
~data_abstract_shape.postln;
~numrows = ~data_abstract_shape.size;
~numcols = ~data_abstract_shape[0].size;
~data_abstract_shape = Array2D.fromArray(~numrows, ~numcols, ~data_abstract_shape.flatten);
);

//Remove Negatives
(
~newarr = [0]!~numcols;
~newarr[0] = ~data_abstract_shape.colAt(0);
~newarr[1] = ~data_abstract_shape.colAt(1);
~newarr[2] = ~data_abstract_shape.colAt(2);
~newarr[3] = ((~data_abstract_shape.colAt(3).asFloat + 2)*1000000000);
~newarr[4] = ((~data_abstract_shape.colAt(4).asFloat + 2)*1000000000);
~newarr[5] = ((~data_abstract_shape.colAt(5).asFloat + 2)*1000000000);
~newarr = ~newarr.flop
);

(
~newarr1 = Array2D.fromArray(~numrows, ~numcols, ~newarr.flatten);
~newarr2 = Array2D.fromArray(~numrows, ~numcols, ~newarr.flatten);
);

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
);

(
~pseqarrx = 0!239;
~pseqarry = 0!239;
~pseqarrz = 0!239;
for(0, 238, {arg j; (0*239+j).postln;
	~pseqarrx[0*239+j] = ~newarr1[j,3];
	~pseqarry[0*239+j] = ~newarr1[j,4];
	~pseqarrz[0*239+j] = ~newarr1[j,5];
});
~pseqarr = [~pseqarrx,~pseqarry,~pseqarrz];
);

(
~store = 0!10038;
for(42, 10037, {arg i;
	~one = ~data_abstract_shape[i,2].asFloat - ~data_abstract_shape[i%42,2].asFloat;
	~two = ~data_abstract_shape[i,3].asFloat - ~data_abstract_shape[i%42,3].asFloat;
	~three = ~data_abstract_shape[i,4].asFloat - ~data_abstract_shape[i%42,4].asFloat;
	~val = ((~one*~one) + (~two*~two) + (~three*~three));
	~store[i] = sqrt(~val);
})
);

//Take avg of 14-14-14 points-----------------------------------------------------------------------------
(
a = 0!239;
b = 0!239;
c = 0!239;
d = 0!3;
d[0] = a;
d[1] = b;
d[2] = c;

e = 0!239;
f = 0!239;
g = 0!239;
h = 0!3;
h[0] = e;
h[1] = f;
h[2] = g;
);

(
for (0, 238, { arg i;

	~temp1 = 0;
	~temp2 = 0;
	~temp3 = 0;
	~temp4 = 0;
	~temp5 = 0;
	~temp6 = 0;

	for(0, 41, {arg j;
		~ind = (i*42+j);
		if(j<14,{~temp1 = ~temp1 + ~store[~ind].asFloat;
			~temp4 = ~temp4 + ~data_abstract_shape[~ind,5].asFloat});
		if(((j>13)&&(j<28)),{~temp2 = ~temp2 + ~store[~ind].asFloat;
			~temp5 = ~temp5 + ~data_abstract_shape[~ind,5].asFloat});
		if(((j>27)&&(j<42)),{~temp3 = ~temp3 + ~store[~ind].asFloat;
			~temp6 = ~temp6 + ~data_abstract_shape[~ind,5].asFloat});
	});

	d[0][i] = ~temp1/14;
	d[1][i] = ~temp2/14;
	d[2][i] = ~temp3/14;
	h[0][i] = ~temp4/14;
	h[1][i] = ~temp5/14;
	h[2][i] = ~temp6/14;

});
);

//Normalize in the range 0-2
d[0] = d[0].normalize(0,2);
d[1] = d[1].normalize(0,2);
d[2] = d[2].normalize(0,2);
h[0] = h[0].normalize(0,2);
h[1] = h[1].normalize(0,2);
h[2] = h[2].normalize(0,2);


t = {0!239}!42;

(
(
for (0, 238, { arg i;

	for(0, 41, {arg j;
		~inde = (i*42+j);
		t[j][i] = ~store[~inde].asFloat;
	});
});
);

//Normalize in the range 0-2
for(0,41,{arg i;
	t[i] = t[i].normalize(0,2);
});
);

(
x = 440!14;
y = 554!14;
z = 659!14;
~notes = x++y++z;
~notestemp = Array.fill(42,{arg i; 0});
);

)






//-------------------------------------------------------------------------------------------------------
//GUI
(
w = Window.new("Main Page",Rect.new(175, 125, 1000, 500));
w.front;
w.alwaysOnTop_(true);
//w.background_(Color.new255(204, 255, 204));
w.background_(Color.white);
~label0 = StaticText.new(w,Rect.new(200,50,600,30))
.string_("DATA SONIFICATION")
.font_(Font("Monaco",25))
.align_(\center);
~description = StaticText.new(w,Rect.new(200,120,600,120))
.string_("Sonification is a process and field of study wherein data is represented through sound. Visual graphs, charts are a common way for expressing data, similarly, sound can also be an affective mode of data representation. Large, detailed data can often not be represents through visual strategies and sonification comes in very useful here. Our aim is to represent chronological and spatial data through sound. For chronological data, we have chosen to depict the crimes rates against women in Indian states and for spatial data, we have mapped different positions of 3D animating objects.")
.font_(Font("Monaco",14));
~label1 = StaticText.new(w,Rect.new(200,280,600,30))
.string_("Choose category of Sonification to perform")
.font_(Font("Monaco",14));
~choosecateg = PopUpMenu(w,Rect.new(200,310,600,30))
.items_(["","Crimes Rates Against Women in Indian States", "3D Animation Object Spatial Data"])
.action = {
	//------------------------------------------------------------------------------------------------
	if(~choosecateg.value == 1,{//CRIME AGAINST WOMEN
		w.visible_(false);
		~w1 = Window.new(~choosecateg.items[~choosecateg.value],Rect.new(175, 125, 1000, 500));
		~w1.front;
		~w1.alwaysOnTop_(true);
		~w1.background_(Color.white);
		//Add code for Crime Data
		~label0 = StaticText.new(~w1,Rect.new(200,50,600,30))
		.string_("CRIME RATES AGAINST WOMEN IN INDIAN STATES")
		.font_(Font("Monaco",25))
		.align_(\center);
		~description1 = StaticText.new(~w1,Rect.new(200,120,600,120))
		.string_("Crime against women in India is a growing concern today. I aim to highlight this issue through a unique means of expression - sound. Make a note that all sounds that you hear are in relation to the initial level for the particular crime in the particular state. The sounds here indicate the rate of change (increase or decrease) over the years and do not directly imply the magnitude of crime.")
		.font_(Font("Monaco",14));
		~label2 = StaticText.new(~w1,Rect.new(200,280,600,30))
		.string_("Choose type of Sonification to perform")
		.font_(Font("Monaco",14));
		~choosetype = PopUpMenu(~w1,Rect.new(200,310,600,30))
		.items_(["", "Sequence through years for a particular crime in a particular state - DISCRETE", "Sequence through years for a particular crime in a particular state - CONTINUOUS", "Compare various crimes in the same state", "Compare various states on the same crime", "Play 2 years for a particular state and crime", "Play average values for all states in sequence for a particular crime", "Apply filters on buffers"])
		.action = {
			~choosetype.value.postln;
			//----------------------------------------------------------
			if(~choosetype.value == 1,{//Sequence through years for a particular crime in a particular state - DISCRETE
				"hi1".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(140,5,800,100))
				.string_("Select any state and crime. Sequence over the data for 12 years discretely and map it to either frequency or amplitude.")
				.font_(Font("Monaco",14));

				~state = 0;
				~crime = 0;
				~dur = 0.5;
				~flag = 0;
				~type = 0;
				//
				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose state")
				.font_(Font("Monaco",14));
				~choosestate = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(~states);
				~choosestate.action = {~state = ~choosestate.value;}; //if(~flag == 1,{~sig.stop; ~sig = Pbindef(\final, \freq, Pseq(~data2[~crime*~numstates+~state]), \dur, ~dur);[~sig.play,~sig.play];})};

				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Choose crime")
				.font_(Font("Monaco",14));
				~choosecrime = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(~crimes);
				~choosecrime.action = {~crime = ~choosecrime.value;}; //if(~flag == 1,{~sig.stop; ~sig = Pbindef(\final, \freq, Pseq(~data2[~crime*~numstates+~state]), \dur, ~dur);[~sig.play,~sig.play];})};

				~label5 = StaticText.new(~w2,Rect.new(200,200,275,30))
				.string_("Select speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(200,230,275,30),controlSpec:ControlSpec(1,10));
				~choosedur.action = {~dur = 1/~choosedur.value;}; //if(~flag == 1,{~sig.stop; ~sig = Pbindef(\final, \freq, Pseq(~data2[~crime*~numstates+~state]), \dur, ~dur);[~sig.play,~sig.play];})};

				~label6 = StaticText.new(~w2,Rect.new(525,200,275,30))
				.string_("Select parameter to control")
				.font_(Font("Monaco",14));
				~choosetyp = PopUpMenu(~w2,Rect.new(525,230,275,30))
				.items_(["Frequency","Amplitude"]);
				~choosetyp.action = {~type = ~choosetyp.value;};

				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					~flag = 1;
					if(~type == 0 ,{~sig = Pbindef(\final, \freq, Pseq(~data2[~crime*~numstates+~state]), \dur, ~dur);});
					if(~type == 1 ,{~sig = Pbindef(\final, \freq, Pseq(500!12), \amp, Pseq(~data2[~crime*~numstates+~state].normalize(0,3)), \dur, ~dur)});
					[~sig.play,~sig.play];
				};

				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					~sig.stop;
					~w2.close;
					~w1.visible_(true);
				};
			});

			//----------------------------------------------------------
			if(~choosetype.value == 2,{//Sequence through years for a particular crime in a particular state - CONTINUOUS
				"hi2".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(130,5,800,100))
				.string_("Select any state and crime. Sequence over the data for 12 years continuously and map it to either frequency or amplitude.")
				.font_(Font("Monaco",14));

				~state = 0;
				~crime = 0;
				~dur = 0.5;
				~sound = 0;
				//

				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose state")
				.font_(Font("Monaco",14));
				~choosestate = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(~states);
				~choosestate.action = {~state = ~choosestate.value;};

				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Choose crime")
				.font_(Font("Monaco",14));
				~choosecrime = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(~crimes);
				~choosecrime.action = {~crime = ~choosecrime.value;};

				~label5 = StaticText.new(~w2,Rect.new(525,200,275,30))
				.string_("Select speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(525,230,275,30),controlSpec:ControlSpec(1,10));
				~choosedur.action = {~dur = 1/~choosedur.value;};

				~label6 = StaticText.new(~w2,Rect.new(200,200,275,30))
				.string_("Select sound type")
				.font_(Font("Monaco",14));
				~choosesound = PopUpMenu(~w2,Rect.new(200,230,275,30))
				.items_(["SinOsc","Pulse","Saw","LFNoise0"]);
				~choosesound.action = {~sound = ~choosesound.value; ~sound.postln};


				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					s.freeAll;
					if(~sound == 0,
						{~sig = {SinOsc.ar(EnvGen.ar(Env(~data2[~crime*~numstates+~state].asInteger,[~dur!11]),doneAction:2))};
							[~sig.play,~sig.play]});
					if(~sound == 1,
						{~sig = {Pulse.ar(EnvGen.ar(Env(~data2[~crime*~numstates+~state].asInteger,[~dur!11]),doneAction:2))};
							[~sig.play,~sig.play]});
					if(~sound == 2,
						{~sig = {Saw.ar(EnvGen.ar(Env(~data2[~crime*~numstates+~state].asInteger,[~dur!11]),doneAction:2))};
							[~sig.play,~sig.play]});
					if(~sound == 3,
						{~sig = {LFNoise0.ar(EnvGen.ar(Env(~data2[~crime*~numstates+~state].asInteger,[~dur!11]),doneAction:2))};
							[~sig.play,~sig.play]});
				};

				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					s.freeAll;
					~w2.close;
					~w1.visible_(true);
				};
			});
			//----------------------------------------------------------
			if(~choosetype.value == 3,{//Compare various crimes in the same state

				"hi3".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(60,5,900,100))
				.string_("Choose any state and 3 crimes to compare their frequencies indicating difference in rate of change of crimes for that state, through the 12 years.")
				.font_(Font("Monaco",14));

				~state = 0;
				~crime1 = 0;
				~crime2 = 0;
				~crime3 = 0;
				~dur = 0.5;
				//
				~label3 = StaticText.new(~w2,Rect.new(360,100,275,30))
				.string_("Choose state")
				.font_(Font("Monaco",14));
				~choosestate = PopUpMenu(~w2,Rect.new(360,130,275,30))
				.items_(~states);
				~choosestate.action = {~state = ~choosestate.value;};

				~label4 = StaticText.new(~w2,Rect.new(70,170,275,30))
				.string_("Choose crime 1")
				.font_(Font("Monaco",14));
				~choosecrime1 = PopUpMenu(~w2,Rect.new(70,200,275,30))
				.items_(~crimes);
				~choosecrime1.action = {~crime1 = ~choosecrime1.value;};

				~label5 = StaticText.new(~w2,Rect.new(360,170,275,30))
				.string_("Choose crime 2")
				.font_(Font("Monaco",14));
				~choosecrime2 = PopUpMenu(~w2,Rect.new(360,200,275,30))
				.items_(~crimes);
				~choosecrime2.action = {~crime2 = ~choosecrime2.value;};

				~label6 = StaticText.new(~w2,Rect.new(650,170,275,30))
				.string_("Choose crime 3")
				.font_(Font("Monaco",14));
				~choosecrime3 = PopUpMenu(~w2,Rect.new(650,200,275,30))
				.items_(~crimes);
				~choosecrime3.action = {~crime3 = ~choosecrime3.value;};

				~label7 = StaticText.new(~w2,Rect.new(360,240,275,30))
				.string_("Select Speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(360,270,275,30),controlSpec:ControlSpec(1,10));
				~choosedur.action = {~dur = 1/~choosedur.value;};

				~play = Button(~w2,Rect.new(450,330,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					//s.freeAll;
					(
					a = {SinOsc.ar(EnvGen.kr(Env.new((~data2[~crime1*~numstates+~state]).asInteger,[~dur!11],5),doneAction:2))*0.25}.play;
					b = {Pulse.ar(EnvGen.kr(Env.new((~data2[~crime2*~numstates+~state]).asInteger,[~dur!11],5),doneAction:2))*0.25}.play;
					c = {Formant.ar(EnvGen.kr(Env.new((~data2[~crime3*~numstates+~state]).asInteger,[~dur!11],5),doneAction:2))*0.25}.play;
					);
				};


				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					s.freeAll;
					~w2.close;
					~w1.visible_(true);
				};
			});
			//----------------------------------------------------------
			if(~choosetype.value == 4,{//Compare various states on the same crime

				"hi4".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(50,5,950,100))
				.string_("Choose any crime and 3 states to compare their frequencies indicating difference in rate of change of the crime in those states, through the 12 years.")
				.font_(Font("Monaco",14));

				~crime = 0;
				~state1 = 0;
				~state2 = 0;
				~state3 = 0;
				~dur = 0.5;
				//
				~label3 = StaticText.new(~w2,Rect.new(360,100,275,30))
				.string_("Choose crime")
				.font_(Font("Monaco",14));
				~choosecrime = PopUpMenu(~w2,Rect.new(360,130,275,30))
				.items_(~crimes);
				~choosecrime.action = {~crime = ~choosecrime.value;};

				~label4 = StaticText.new(~w2,Rect.new(70,170,275,30))
				.string_("Choose state 1")
				.font_(Font("Monaco",14));
				~choosestate1 = PopUpMenu(~w2,Rect.new(70,200,275,30))
				.items_(~states);
				~choosestate1.action = {~state1 = ~choosestate1.value;};

				~label5 = StaticText.new(~w2,Rect.new(360,170,275,30))
				.string_("Choose state 2")
				.font_(Font("Monaco",14));
				~choosestate2 = PopUpMenu(~w2,Rect.new(360,200,275,30))
				.items_(~states);
				~choosestate2.action = {~state2 = ~choosestate2.value;};

				~label6 = StaticText.new(~w2,Rect.new(650,170,275,30))
				.string_("Choose state 3")
				.font_(Font("Monaco",14));
				~choosestate3 = PopUpMenu(~w2,Rect.new(650,200,275,30))
				.items_(~states);
				~choosestate3.action = {~state3 = ~choosestate3.value;};

				~label7 = StaticText.new(~w2,Rect.new(360,240,275,30))
				.string_("Select Speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(360,270,275,30),controlSpec:ControlSpec(1,10));
				~choosedur.action = {~dur = 1/~choosedur.value;};

				~play = Button(~w2,Rect.new(450,330,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					(
					a = {SinOsc.ar(EnvGen.kr(Env.new((~data2[~crime*~numstates+~state1]).asInteger,[~dur!11],5),doneAction:2))*0.25}.play;
					b = {Pulse.ar(EnvGen.kr(Env.new((~data2[~crime*~numstates+~state2]).asInteger,[~dur!11],5),doneAction:2))*0.25}.play;
					c = {Formant.ar(EnvGen.kr(Env.new((~data2[~crime*~numstates+~state3]).asInteger,[~dur!11],5),doneAction:2))*0.25}.play;
					);
				};

				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					s.freeAll;
					~w2.close;
					~w1.visible_(true);
				};
			});
			//----------------------------------------------------------
			if(~choosetype.value == 5,{//Play 2 years for a particular state and crime
				"hi5".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(80,5,950,100))
				.string_("Choose any crime and state. Pick 2 years and compare the level of crime (represented as frequencies of 2 distinct sounds), for the 2 years.")
				.font_(Font("Monaco",14));

				~state = 0;
				~crime = 0;
				~year1 = 0;
				~year2 = 0;
				//

				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose state")
				.font_(Font("Monaco",14));
				~choosestate = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(~states);
				~choosestate.action = {~state = ~choosestate.value;};

				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Choose crime")
				.font_(Font("Monaco",14));
				~choosecrime = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(~crimes);
				~choosecrime.action = {~crime = ~choosecrime.value;};

				~label5 = StaticText.new(~w2,Rect.new(200,200,275,35))
				.string_("Choose year to control\nFrequency and Amplitude of first sound")
				.font_(Font("Monaco",14));
				~chooseyear1 = PopUpMenu(~w2,Rect.new(200,238,275,30))
				.items_(~years);
				~chooseyear1.action = {~year1 = ~chooseyear1.value;};

				~label6 = StaticText.new(~w2,Rect.new(525,200,275,35))
				.string_("Choose year to control\nFrequency and Amplitude of second sound")
				.font_(Font("Monaco",14));
				~chooseyear2 = PopUpMenu(~w2,Rect.new(525,238,275,30))
				.items_(~years);
				~chooseyear2.action = {~year2 = ~chooseyear2.value;};

				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year1],\o2,~data2[~crime*~numstates+~state][~year2],\p,~data2[~crime*~numstates+~state][~year1],\q,~data2[~crime*~numstates+~state][~year2]]);
				};

				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					s.freeAll;
					~w2.close;
					~w1.visible_(true);
				};
			});
			//----------------------------------------------------------
			if(~choosetype.value == 6,{//Play average values for all states in sequence for a particular crime
				"hi6".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(140,5,800,100))
				.string_("Select any crime and year. Sequence over the states continuously and map it to frequency as multiple sound types.")
				.font_(Font("Monaco",14));

				~crime = 0;
				~year = 0;
				~sound = 0;
				~dur = 1;
				//

				~label3 = StaticText.new(~w2,Rect.new(362.5,100,275,30))
				.string_("Choose crime")
				.font_(Font("Monaco",14));
				~choosecrime = PopUpMenu(~w2,Rect.new(362.5,130,275,30))
				.items_(~crimes);
				~choosecrime.action = {~crime = ~choosecrime.value; ~dataavg = Array.fill(35,{arg i; ~data[~crime*36+i].asInteger.sum});~dataavg = ~dataavg.normalize(400,1200).round(1);};

				~label5 = StaticText.new(~w2,Rect.new(200,200,275,30))
				.string_("Select sound type")
				.font_(Font("Monaco",14));
				~choosesound = PopUpMenu(~w2,Rect.new(200,230,275,30))
				.items_(["SinOsc","Pulse","Saw","LFNoise0"]);
				~choosesound.action = {~sound = ~choosesound.value; ~sound.postln};

				~label6 = StaticText.new(~w2,Rect.new(525,200,275,30))
				.string_("Select speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(525,230,275,30),controlSpec:ControlSpec(1,10));
				~choosedur.action = {~dur = 1/~choosedur.value;};

				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {

					s.freeAll;
					if(~sound == 0,
						{~sig = {FreeVerb.ar(SinOsc.ar(EnvGen.ar(Env.new(~dataavg,[~dur!35],10),doneAction:2)),0.5,0.5)};
							~sig.play;});
					if(~sound == 1,
						{~sig = {FreeVerb.ar(Pulse.ar(EnvGen.ar(Env.new(~dataavg,[~dur!35],10),doneAction:2)),0.5,0.5)};
							~sig.play;});
					if(~sound == 2,
						{~sig = {FreeVerb.ar(Saw.ar(EnvGen.ar(Env.new(~dataavg,[~dur!35],10),doneAction:2)),0.5,0.5)};
							~sig.play;});
					if(~sound == 3,
						{~sig = {FreeVerb.ar(LFNoise0.ar(EnvGen.ar(Env.new(~dataavg,[~dur!35],10),doneAction:2)),0.5,0.5)};
							~sig.play;});
				};


				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					s.freeAll;
					~w2.close;
					~w1.visible_(true);
				};
			});
			//--------------------------------------------------------------
			if(~choosetype.value == 7,{//Apply filters on buffers

				"hi7".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(165,5,800,100))
				.string_("Select buffers and type of filter to apply on the buffer. The filter is controlled by a selected state and crime data.")
				.font_(Font("Monaco",14));

				a = Buffer.read(Server.local,"C:/Users/Surabhi/Desktop/IIITD/IP/Buffers/528Hz_Pure_Sine_Tone.wav");
				b = Buffer.read(Server.local,"C:/Users/Surabhi/Desktop/IIITD/IP/Buffers/Tic Toc wav.wav");
				c = Buffer.read(Server.local,"C:/Users/Surabhi/Desktop/IIITD/IP/Buffers/Sleigh-Bells-Christmas-Sounds-SOUND-EFFECT-freesound.wav");
				d = Buffer.read(Server.local,"C:/Users/Surabhi/Desktop/IIITD/IP/Buffers/ABC_Song.wav");
				~state = 0;
				~crime = 0;
				~buffer = a;
				~filter = 0;
				~freq = 750;

				//
				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose state")
				.font_(Font("Monaco",14));
				~choosestate = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(~states);
				~choosestate.action = {~state = ~choosestate.value;};

				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Choose crime")
				.font_(Font("Monaco",14));
				~choosecrime = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(~crimes);
				~choosecrime.action = {~crime = ~choosecrime.value;};

				~label5 = StaticText.new(~w2,Rect.new(200,200,275,30))
				.string_("Select buffer")
				.font_(Font("Monaco",14));
				~choosebuffer = PopUpMenu(~w2,Rect.new(200,230,275,30))
				.items_(["Pure Sin Wave", "Tic Toc", "Sleigh Bells", "ABC Song"]);
				~choosebuffer.action = {
					if(~choosebuffer.value==0,{~buffer = a});
					if(~choosebuffer.value==1,{~buffer = b});
					if(~choosebuffer.value==2,{~buffer = c});
					if(~choosebuffer.value==3,{~buffer = d});
					~buffer.postln;
				};

				~label6 = StaticText.new(~w2,Rect.new(810,200,150,30))
				.string_("Frequency")
				.font_(Font("Monaco",14));
				~choosefreq = EZSlider.new(~w2,Rect.new(810,230,150,30),controlSpec:ControlSpec(500,1000));
				~choosefreq.action = {~freq = ~choosefreq.value; ~freq.postln;};

				~label7 = StaticText.new(~w2,Rect.new(525,200,275,30))
				.string_("Select filter")
				.font_(Font("Monaco",14));
				~choosefilter = PopUpMenu(~w2,Rect.new(525,230,275,30))
				.items_(["LPF","HPF","BPS","FreqShift"]);
				~choosefilter.action = {~filter = ~choosefilter.value;
					~choosefreq.visible_(true); ~label6.visible_(true);
					if(~choosefilter.value == 3,{~choosefreq.visible_(false); ~label6.visible_(false);})
				};

				~playorig = Button(~w2,Rect.new(390,300,100,40))
				.states = [["Play Original", Color.red],["Play Original", Color.red]];
				~playorig.action = {s.freeAll; [~buffer.play,~buffer.play];};

				~play = Button(~w2,Rect.new(510,300,100,40))
				.states = [["Play with Filter", Color.red],["Play with Filter", Color.red]];
				~play.action = {
					s.freeAll;
					if(~filter == 0,
						{
							~sig = {LPF.ar(PlayBuf.ar(1,~buffer),~freq)*SinOsc.ar(EnvGen.ar(Env.new(~data2[~crime*~numstates+~state],[1.36!11]),doneAction:2))*2};
						~sig.play;

					});
					if(~filter == 1,
						{
							~sig = {HPF.ar(PlayBuf.ar(1,~buffer),~freq)*SinOsc.ar(EnvGen.ar(Env.new(~data2[~crime*~numstates+~state],[1.36!11]),doneAction:2))*2};
						~sig.play;

					});
					if(~filter == 2,
						{
							~sig = {BPF.ar(PlayBuf.ar(1,~buffer),~freq)*SinOsc.ar(EnvGen.ar(Env.new(~data2[~crime*~numstates+~state],[1.36!11]),doneAction:2))*2};
						~sig.play;

					});
					if(~filter == 3,
						{
							~sig = {FreqShift.ar(PlayBuf.ar(1,~buffer),[~data[~crime*~numstates+~state][0].asInteger,~data[~crime*~numstates+~state][11].asInteger])};
						~sig.play;

					});
				};

				~stop = Button(~w2,Rect.new(450,350,100,40))
				.states = [["Stop", Color.red],["Stop", Color.red]];
				~stop.action = {
					s.freeAll;
				};

				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					s.freeAll;
					~w2.close;
					~w1.visible_(true);
				};
			});

		};
		~back = Button(~w1,Rect.new(465,420,70,30));
		~back.states = [["Back", Color.black],["Back", Color.black, Color.red]];
		~back.action = {
			~w1.close;
			w.visible_(true);
		};
	});
	//----------------------------------------------------------------------------------------------------
	if(~choosecateg.value == 2,{//3D DATA
		w.visible_(false);
		~w1 = Window.new(~choosecateg.items[~choosecateg.value],Rect.new(175, 125, 1000, 500));
		~w1.front;
		~w1.alwaysOnTop_(true);
		~w1.background_(Color.white);
		//Add code for 3D Data
		~label0 = StaticText.new(~w1,Rect.new(200,50,600,30))
		.string_("3D ANIMATION OBJECT SPATIAL DATA")
		.font_(Font("Monaco",25))
		.align_(\center);
		~description1 = StaticText.new(~w1,Rect.new(200,120,600,120))
		.string_("We sonified data of an animating 3D object. View the animation at this link: \nhttps://drive.google.com/file/d/1635o2-cAuCpEUAnEA4PaDUD2jXcIJ6__/view?usp=sharing\nThe animation represents coordinates (X, Y, Z) of 42 points, moving and changing their positions through 239 frames. ")
		.font_(Font("Monaco",14));
		~label2 = StaticText.new(~w1,Rect.new(200,280,600,30))
		.string_("Choose type of Sonification to perform")
		.font_(Font("Monaco",14));
		~choosetype = PopUpMenu(~w1,Rect.new(200,310,600,30))
		.items_(["","Variation across frames for a particular point", "Variation in X, Y, Z coordinates individually across frames for a particular point", "Set synths for X, Y, Z coordinates in a Task", "Chord representation, distortion in 3","Chord representation, distortion in 42"])
		.action = {
			//----------------------------------------------------------
			if(~choosetype.value == 1,{
				"hi1".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(230,5,800,100))
				.string_("Choose a point to hear its variation in position mapped to frequency across the frames.")
				.font_(Font("Monaco",14));

				~point = 0;
				~yield = 0.1;
				~dur = 0.03;
				//
				~label3 = StaticText.new(~w2,Rect.new(362.5,100,275,30))
				.string_("Choose point")
				.font_(Font("Monaco",14));
				~choosepoint = PopUpMenu(~w2,Rect.new(362.5,130,275,30))
				.items_(~points);
				~choosepoint.action = {~point = ~choosepoint.value;};

				~label4 = StaticText.new(~w2,Rect.new(200,200,275,30))
				.string_("Select speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(200,230,275,30),controlSpec:ControlSpec(1,100));
				~choosedur.action = {~dur = 1/~choosedur.value;};

				~label5 = StaticText.new(~w2,Rect.new(525,200,275,30))
				.string_("Select yield")
				.font_(Font("Monaco",14));
				~chooseyield = EZSlider.new(~w2,Rect.new(525,230,275,30),controlSpec:ControlSpec(0.03,3));
				~chooseyield.action = {~yield = ~chooseyield.value;};

				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					(
						~part21 = Routine({
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
					);

					r = [~part21.play,~part21.play];
				};



				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					~part21.stop;
					//s.freeAll;
					~w2.close;
					~w1.visible_(true);
				}
			});
			//----------------------------------------------------------
			if(~choosetype.value == 2,{
				"hi2".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(120,5,800,100))
				.string_("Choose a point and a coordinate to hear its variation in position in that coordinate mapped to frequency across the frames.")
				.font_(Font("Monaco",14));

				~point = 0;
				~coord = 0;
				~dur = 0.5;
				//
				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose point")
				.font_(Font("Monaco",14));
				~choosepoint = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(~points);
				~choosepoint.action = {
					~point = ~choosepoint.value;
					(
					~pseqarrx = 0!239;
					~pseqarry = 0!239;
					~pseqarrz = 0!239;
					for(0, 238, {arg j; (~point*239+j).postln;
						~pseqarrx[j] = ~newarr1[~point*239+j,3];
						~pseqarry[j] = ~newarr1[~point*239+j,4];
						~pseqarrz[j] = ~newarr1[~point*239+j,5];
					});
					~pseqarr = [~pseqarrx,~pseqarry,~pseqarrz];
					);

					~pseqarrx.postln;
					~pseqarry.postln;
				};

				//~norm = [200,500,800,1100];
				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Choose coordinate")
				.font_(Font("Monaco",14));
				~choosecoord = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(['X','Y','Z']);
				~choosecoord.action = {~coord = ~choosecoord.value;};

				~label5 = StaticText.new(~w2,Rect.new(362.5,200,275,30))
				.string_("Select speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(362.5,230,275,30),controlSpec:ControlSpec(1,20));
				~choosedur.action = {~dur = 1/(~choosedur.value+1);};

				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];

				~play.action = {
					~sig.stop;
					//~sig = Pbind(\freq,Pseq((~pseqarr[~coord]).normalize(~norm[~coord],~norm[~coord+1]),1),\dur,~dur).play;
					(~pseqarr[~coord]/10000000).postln;
					~sig = Pbind(\freq,Pseq((~pseqarr[~coord]/10000000)+500,1),\dur,~dur).play;
					~sig.play;
				};

				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					~sig.stop;
					~w2.close;
					~w1.visible_(true);
				}
			});
			//----------------------------------------------------------
			if(~choosetype.value == 3,{
				"hi3".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(100,5,800,100))
				.string_("Choose a point. Synths controlling frequency and amplitude for each coordinate for that point are called in a routine for all frames.")
				.font_(Font("Monaco",14));

				~point = 0;
				~dur = 1;

				//
				~label3 = StaticText.new(~w2,Rect.new(362.5,100,275,30))
				.string_("Choose point")
				.font_(Font("Monaco",14));
				~choosepoint = PopUpMenu(~w2,Rect.new(362.5,130,275,30))
				.items_(~points);
				~choosepoint.action = {~point = ~choosepoint.value;};

				~label4 = StaticText.new(~w2,Rect.new(362.5,200,275,30))
				.string_("Select speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(362.5,230,275,30),controlSpec:ControlSpec(1,10));
				~choosedur.action = {~dur = 1/~choosedur.value;};

				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					(
						~part23 = Task({|i|

							238.do({arg i;
								(
									(~newarr1[~point*239+i,3]/10000000+500).postln;
									(~newarr1[~point*239+i,4]/10000000+500).postln;
									(~newarr1[~point*239+i,5]/10000000+500).postln;
									~xcoord = {SinOsc.ar([~newarr1[~point*239+i,3]/10000000+500,~newarr1[~point*239+i,3]]/10000000+500,0,Line.kr(1,0,~dur));}.play;
									~ycoord = {EnvGen.ar(Env.perc(releaseTime:~dur), doneAction: 0) * Pulse.ar([~newarr1[~point*239+i,4]/10000000+500,~newarr1[~point*239+i,4]/10000000+500], 0.25, 0.75);}.play;
									~zcoord = {Saw.ar([~newarr1[~point*239+i,5]/10000000+500,~newarr1[~point*239+i,5]/10000000+500],Line.kr(1,0,~dur));}.play;
								);

								~dur.wait;

								~xcoord.free;
								~ycoord.free;
								~zcoord.free;
							})
						});
					);

					r = ~part23.play;
				};

				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					r.stop;
					~w2.close;
					~w1.visible_(true);
				}
			});
			//----------------------------------------------------------
			if(~choosetype.value == 4,{
				"hi4".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(120,5,800,100))
				.string_("The 42 points are divided into 3 regions. Initially in an ordered state, the 3 regions represent a major chord and as they move,\nthe tone gets distorded based on mean displacement of the 14 points wrt either the initial frame or wrt the previous frame.")
				.font_(Font("Monaco",14));

				~init1 = 69;
				~init2 = 73;
				~init3 = 76;
				~type = 0;
				~yield = 0.08;
				~dur = 0.08;
				~dev = 1;
				//

				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose type")
				.font_(Font("Monaco",14));
				~choosetype = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(["All frames wrt initial", "Alternate frames wrt initial", "All frames wrt previous"]);
				~choosetype.action = {~type = ~choosetype.value;};

				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Select chord")
				.font_(Font("Monaco",14));
				~choosechord = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(["A major", "B major", "C major", "D major", "E major", "F major", "G major"]);
				~choosechord.action = {
					if(~choosechord.value==0,{~init1 = 69;~init2 = 73;~init3 = 76;});
					if(~choosechord.value==1,{~init1 = 71;~init2 = 75;~init3 = 78;});
					if(~choosechord.value==2,{~init1 = 72;~init2 = 76;~init3 = 79;});
					if(~choosechord.value==3,{~init1 = 64;~init2 = 78;~init3 = 69;});
					if(~choosechord.value==4,{~init1 = 76;~init2 = 80;~init3 = 71;});
					if(~choosechord.value==5,{~init1 = 77;~init2 = 69;~init3 = 72;});
					if(~choosechord.value==6,{~init1 = 79;~init2 = 71;~init3 = 74;});};


				~label5 = StaticText.new(~w2,Rect.new(200,200,275,30))
				.string_("Choose speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(200,230,275,30),controlSpec:ControlSpec(1,100));
				~choosedur.action = {~dur = 1/~choosedur.value; if(~dur>0.08,{~yield = ~dur}); if(~dur<=0.08,{~yield = 0.08});};

				~label5 = StaticText.new(~w2,Rect.new(525,200,275,30))
				.string_("Choose deviation")
				.font_(Font("Monaco",14));
				~choosedev = EZSlider.new(~w2,Rect.new(525,230,275,30),controlSpec:ControlSpec(1,5));
				~choosedev.action = {~dev = ~choosedev.value};



				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					s.freeAll;
					if(~type == 0, {
					(
					~part24 = Routine({
								for(0, 238, {arg i;

									~in1 = ~init1;
									~in2 = ~init2;
									~in3 = ~init3;

									if(d[0][i]<0.1,{~in1 = ~init1});
									if((d[0][i]>0.1) && (d[0][i]<0.3),{~in1 = ~init1-(1*~dev)});
									if((d[0][i]>0.3) && (d[0][i]<0.5),{~in1 = ~init1-(2*~dev)});
									if((d[0][i]>0.5) && (d[0][i]<0.7),{~in1 = ~init1 -(8*~dev)});
									if((d[0][i]>0.7) && (d[0][i]<1),{~in1 = ~init1-(6*~dev)});
									if((d[0][i]>1) && (d[0][i]<1.3),{~in1 = ~init1-(4*~dev)});
									if((d[0][i]>1.5) && (d[0][i]<1.5),{~in1 = ~init1-(5*~dev)});
									if((d[0][i]>1.5) && (d[0][i]<1.8),{~in1 = ~init1-(3*~dev)});
									if((d[0][i]>1.8) && (d[0][i]<=2),{~in1 = ~init1-(7*~dev)});

									if(d[1][i]<0.1,{~in2 = ~init2});
									if((d[1][i]>=0.1) && (d[1][i]<0.3),{~in2 = ~init2-(1*~dev)});
									if((d[1][i]>0.3) && (d[1][i]<0.5),{~in2 = ~init2-(2*~dev)});
									if((d[1][i]>0.5) && (d[1][i]<0.7),{~in2 = ~init2+(2*~dev)});
									if((d[1][i]>0.7) && (d[1][i]<1),{~in2 = ~init2+(5*~dev)});
									if((d[1][i]>1) && (d[1][i]<1.3),{~in2 = ~init2+(3*~dev)});
									if((d[1][i]>1.3) && (d[1][i]<1.5),{~in2 = ~init2-(3*~dev)});
									if((d[1][i]>1.5) && (d[1][i]<1.8),{~in2 = ~init2+(1*~dev)});
									if((d[1][i]>1.8) && (d[1][i]<=2),{~in2 = ~init2+(4*~dev)});


									if(d[2][i]<0.1,{~in3 = ~init3});
									if((d[2][i]>0.1) && (d[2][i]<0.3),{~in3 = ~init3-1});
									if((d[2][i]>0.3) && (d[2][i]<0.5),{~in3 = ~init3-2});
									if((d[2][i]>0.5) && (d[2][i]<0.8),{~in3 = ~init3-3});
									if((d[2][i]>0.8) && (d[2][i]<1),{~in3 = ~init3+3});
									if((d[2][i]>1) && (d[2][i]<1.3),{~in3 = ~init3+5});
									if((d[2][i]>1.3) && (d[2][i]<1.5),{~in3 = ~init3+7});
									if((d[2][i]>1.5) && (d[2][i]<1.8),{~in3 = ~init3+4});
									if((d[2][i]>1.8) && (d[2][i]<=2),{~in3 = ~init3+6});

									~in1.postln;
									~in2.postln;
									~in3.postln;

									Pbind(\freq,Pseq([[~in1.midicps,~in2.midicps,~in3.midicps]],1),\dur,~dur).play;
									~yield.yield;
								});
							});
						);
						r = [~part24.play,~part24.play];});

					if(~type == 1, {
					(
					~part24 = Routine({
								for(0, 119, {arg i;

									~in1 = ~init1;
									~in2 = ~init2;
									~in3 = ~init3;
									~init1.postln;
									~init2.postln;
									~init3.postln;

									if(d[0][i*2]<0.1,{~in1 = ~init1});
									if((d[0][i*2]>0.1) && (d[0][i*2]<0.3),{~in1 = ~init1-(1*~dev)});
									if((d[0][i*2]>0.3) && (d[0][i*2]<0.5),{~in1 = ~init1-(2*~dev)});
									if((d[0][i*2]>0.5) && (d[0][i*2]<0.7),{~in1 = ~init1-(8*~dev)});
									if((d[0][i*2]>0.7) && (d[0][i*2]<1),{~in1 = ~init1-(6*~dev)});
									if((d[0][i*2]>1) && (d[0][i*2]<1.3),{~in1 = ~init1-(4*~dev)});
									if((d[0][i*2]>1.5) && (d[0][i*2]<1.5),{~in1 = ~init1-(5*~dev)});
									if((d[0][i*2]>1.5) && (d[0][i*2]<1.8),{~in1 = ~init1-(3*~dev)});
									if((d[0][i*2]>1.8) && (d[0][i*2]<=2),{~in1 = ~init1-(7*~dev)});

									if(d[1][i*2]<0.1,{~in2 = ~init2});
									if((d[1][i*2]>=0.1) && (d[1][i*2]<0.3),{~in2 = ~init2-(1*~dev)});
									if((d[1][i*2]>0.3) && (d[1][i*2]<0.5),{~in2 = ~init2-(2*~dev)});
									if((d[1][i*2]>0.5) && (d[1][i*2]<0.7),{~in2 = ~init2+(2*~dev)});
									if((d[1][i*2]>0.7) && (d[1][i*2]<1),{~in2 = ~init2+(5*~dev)});
									if((d[1][i*2]>1) && (d[1][i*2]<1.3),{~in2 = ~init2+(3*~dev)});
									if((d[1][i*2]>1.3) && (d[1][i*2]<1.5),{~in2 = ~init2-(3*~dev)});
									if((d[1][i*2]>1.5) && (d[1][i*2]<1.8),{~in2 = ~init2+(1*~dev)});
									if((d[1][i*2]>1.8) && (d[1][i*2]<=2),{~in2 = ~init2+(4*~dev)});


									if(d[2][i*2]<0.1,{~in3 = ~init3});
									if((d[2][i*2]>0.1) && (d[2][i*2]<0.3),{~in3 = ~init3-(1*~dev)});
									if((d[2][i*2]>0.3) && (d[2][i*2]<0.5),{~in3 = ~init3-(2*~dev)});
									if((d[2][i*2]>0.5) && (d[2][i*2]<0.8),{~in3 = ~init3-(3*~dev)});
									if((d[2][i*2]>0.8) && (d[2][i*2]<1),{~in3 = ~init3+(3*~dev)});
									if((d[2][i*2]>1) && (d[2][i*2]<1.3),{~in3 = ~init3+(5*~dev)});
									if((d[2][i*2]>1.3) && (d[2][i*2]<1.5),{~in3 = ~init3+(7*~dev)});
									if((d[2][i*2]>1.5) && (d[2][i*2]<1.8),{~in3 = ~init3+(4*~dev)});
									if((d[2][i*2]>1.8) && (d[2][i*2]<=2),{~in3 = ~init3+(6*~dev)});

									~in1.postln;
									~in2.postln;
									~in3.postln;

									Pbind(\freq,Pseq([[~in1.midicps,~in2.midicps,~in3.midicps]],1),\dur,~dur).play;
									~yield.yield;
								});
							});
						);
						r = [~part24.play,~part24.play];});

					if(~type == 2, {
					(
					~part24 = Routine({
								for(0, 119, {arg i;

									~in1 = ~init1;
									~in2 = ~init2;
									~in3 = ~init3;

									if(h[0][i*2].asFloat<0.1,{~in1 = ~init1});
									if((h[0][i*2].asFloat>0.1) && (h[0][i*2].asFloat<0.3),{~in1 = ~init1-(1*~dev)});
									if((h[0][i*2].asFloat>0.3) && (h[0][i*2].asFloat<0.5),{~in1 = ~init1-(2*~dev)});
									if((h[0][i*2].asFloat>0.5) && (h[0][i*2].asFloat<0.7),{~in1 = ~init1-(8*~dev)});
									if((h[0][i*2].asFloat>0.7) && (h[0][i*2].asFloat<1),{~in1 = ~init1-(6*~dev)});
									if((h[0][i*2].asFloat>1) && (h[0][i*2].asFloat<1.3),{~in1 = ~init1-(4*~dev)});
									if((h[0][i*2].asFloat>1.5) && (h[0][i*2].asFloat<1.5),{~in1 = ~init1-(5*~dev)});
									if((h[0][i*2].asFloat>1.5) && (h[0][i*2].asFloat<1.8),{~in1 = ~init1-(3*~dev)});
									if((h[0][i*2].asFloat>1.8) && (h[0][i*2].asFloat<=2),{~in1 = ~init1-(7*~dev)});

									if(h[1][i*2].asFloat<0.1,{~in2 = ~init2});
									if((h[1][i*2].asFloat>=0.1) && (h[1][i*2].asFloat<0.3),{~in2 = ~init2-(1*~dev)});
									if((h[1][i*2].asFloat>0.3) && (h[1][i*2].asFloat<0.5),{~in2 = ~init2-(2*~dev)});
									if((h[1][i*2].asFloat>0.5) && (h[1][i*2].asFloat<0.7),{~in2 = ~init2+(2*~dev)});
									if((h[1][i*2].asFloat>0.7) && (h[1][i*2].asFloat<1),{~in2 = ~init2+(5*~dev)});
									if((h[1][i*2].asFloat>1) && (h[1][i*2].asFloat<1.3),{~in2 = ~init2+(3*~dev)});
									if((h[1][i*2].asFloat>1.3) && (h[1][i*2].asFloat<1.5),{~in2 = ~init2-(3*~dev)});
									if((h[1][i*2].asFloat>1.5) && (h[1][i*2].asFloat<1.8),{~in2 = ~init2+(1*~dev)});
									if((h[1][i*2].asFloat>1.8) && (h[1][i*2].asFloat<=2),{~in2 = ~init2+(4*~dev)});


									if(h[2][i*2].asFloat<0.1,{~in3 = ~init3});
									if((h[2][i*2].asFloat>0.1) && (h[2][i*2].asFloat<0.3),{~in3 = ~init3-(1*~dev)});
									if((h[2][i*2].asFloat>0.3) && (h[2][i*2].asFloat<0.5),{~in3 = ~init3-(2*~dev)});
									if((h[2][i*2].asFloat>0.5) && (h[2][i*2].asFloat<0.8),{~in3 = ~init3-(3*~dev)});
									if((h[2][i*2].asFloat>0.8) && (h[2][i*2].asFloat<1),{~in3 = ~init3+(3*~dev)});
									if((h[2][i*2].asFloat>1) && (h[2][i*2].asFloat<1.3),{~in3 = ~init3+(5*~dev)});
									if((h[2][i*2].asFloat>1.3) && (h[2][i*2].asFloat<1.5),{~in3 = ~init3+(7*~dev)});
									if((h[2][i*2].asFloat>1.5) && (h[2][i*2].asFloat<1.8),{~in3 = ~init3+(4*~dev)});
									if((h[2][i*2].asFloat>1.8) && (h[2][i*2].asFloat<=2),{~in3 = ~init3+(6*~dev)});

									~in1.postln;
									~in2.postln;
									~in3.postln;

									Pbind(\freq,Pseq([[~in1.midicps,~in2.midicps,~in3.midicps]],1),\dur,~dur).play;
									~yield.yield;
								});
							});
						);
						"https://youtu.be/fTOq23oLAH4".openOS;
						r = [~part24.play,~part24.play];

					});
				};
				//

				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					r.stop;
					~w2.close;
					~w1.visible_(true);
				}
			});
			//----------------------------------------------------------
			if(~choosetype.value == 5,{
				"hi5".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(120,5,800,100))
				.string_("The 42 points each output a unique sound. Initially in an ordered state, the 42 points represent a major chord and as they move,\nthe tone gets distorded based on mean displacement of each point points wrt the initial frame. Distortion amount can be controlled")
				.font_(Font("Monaco",14));

				~type = 0;
				~yield = 1;
				~dur = 1;
				~dev = 1;
				//

				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose type")
				.font_(Font("Monaco",14));
				~choosetype = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(["All frames wrt initial", "Alternate frames wrt initial"]);
				~choosetype.action = {~type = ~choosetype.value;};

				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Select chord")
				.font_(Font("Monaco",14));
				~choosechord = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(["A major", "B major", "C major", "D major", "E major", "F major", "G major"]);
				~choosechord.action = {
					if(~choosechord.value==0,{x = 440!14;y = 554!14;z = 659!14;~notes = x++y++z;~notestemp = Array.fill(42,{arg i; 0})});
					if(~choosechord.value==1,{x = 494!14;y = 622!14;z = 740!14;~notes = x++y++z;~notestemp = Array.fill(42,{arg i; 0})});
					if(~choosechord.value==2,{x = 523!14;y = 659!14;z = 784!14;~notes = x++y++z;~notestemp = Array.fill(42,{arg i; 0})});
					if(~choosechord.value==3,{x = 587!14;y = 740!14;z = 440!14;~notes = x++y++z;~notestemp = Array.fill(42,{arg i; 0})});
					if(~choosechord.value==4,{x = 659!14;y = 831!14;z = 494!14;~notes = x++y++z;~notestemp = Array.fill(42,{arg i; 0})});
					if(~choosechord.value==5,{x = 699!14;y = 440!14;z = 523!14;~notes = x++y++z;~notestemp = Array.fill(42,{arg i; 0})});
					if(~choosechord.value==6,{x = 784!14;y = 494!14;z = 587!14;~notes = x++y++z;~notestemp = Array.fill(42,{arg i; 0})});};


				~label5 = StaticText.new(~w2,Rect.new(200,200,275,30))
				.string_("Choose speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(200,230,275,30),controlSpec:ControlSpec(1,5));
				~choosedur.action = {~dur = 1/~choosedur.value; ~yield = ~dur};

				~label5 = StaticText.new(~w2,Rect.new(525,200,275,30))
				.string_("Choose deviation")
				.font_(Font("Monaco",14));
				~choosedev = EZSlider.new(~w2,Rect.new(525,230,275,30),controlSpec:ControlSpec(1,5));
				~choosedev.action = {~dev = ~choosedev.value};


				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					s.freeAll;
					if(~type == 0, {
					(
					~part25 = Routine({
								for(0, 238, {arg i;

									for(0,41, {arg j;

										// if(t[j][i*2]<0.2,{~notestemp[j] = ~notes[j]});
										// if((t[j][i*2]>0.2) && (t[j][i*2]<0.3),{~notestemp[j] = ~notes[j]-rrand(0,20)});
										// if((t[j][i*2]>0.3) && (t[j][i*2]<0.5),{~notestemp[j] = ~notes[j]-rrand(20,40)});
										// if((t[j][i*2]>0.5) && (t[j][i*2]<0.7),{~notestemp[j] = ~notes[j]-rrand(40,60)});
										// if((t[j][i*2]>0.7) && (t[j][i*2]<1),{~notestemp[j] = ~notes[j]-rrand(60,80)});
										// if((t[j][i*2]>1) && (t[j][i*2]<1.3),{~notestemp[j] = ~notes[j]-rrand(60,80)});
										// if((t[j][i*2]>1.5) && (t[j][i*2]<1.5),{~notestemp[j] = ~notes[j]-rrand(0,60)});
										// if((t[j][i*2]>1.5) && (t[j][i*2]<1.8),{~notestemp[j] = ~notes[j]-rrand(20,40)});
										// if((t[j][i*2]>1.8) && (t[j][i*2]<=2),{~notestemp[j] = ~notes[j]-rrand(0,20)});


										if(t[j][i]<0.2,{~notestemp[j] = ~notes[j]});
										if((t[j][i]>0.2) && (t[j][i]<0.3),{~notestemp[j] = ~notes[j]-(~dev*rrand(0,10))});
										if((t[j][i]>0.3) && (t[j][i]<0.5),{~notestemp[j] = ~notes[j]+(~dev*rrand(0,10))});
										if((t[j][i]>0.5) && (t[j][i]<0.7),{~notestemp[j] = ~notes[j]-(~dev*rrand(10,20))});
										if((t[j][i]>0.7) && (t[j][i]<1),{~notestemp[j] = ~notes[j]+(~dev*rrand(10,20))});
										if((t[j][i]>1) && (t[j][i]<1.3),{~notestemp[j] = ~notes[j]-(~dev*rrand(20,30))});
										if((t[j][i]>1.5) && (t[j][i]<1.5),{~notestemp[j] = ~notes[j]+(~dev*rrand(20,30))});
										if((t[j][i]>1.5) && (t[j][i]<1.8),{~notestemp[j] = ~notes[j]-(~dev*rrand(30,40))});
										if((t[j][i]>1.8) && (t[j][i]<=2),{~notestemp[j] = ~notes[j]+(~dev*rrand(30,40))});

									});

									Pbind(\freq,Pseq([~notestemp],1),\dur,~dur).play;
									~yield.yield;
								});
							});
						);
						r = [~part25.play,~part25.play];});

					if(~type == 1, {
					(
					~part25 = Routine({
								for(0, 119, {arg i;

									for(0,41, {arg j;

										// if(t[j][i*2]<0.2,{~notestemp[j] = ~notes[j]});
										// if((t[j][i*2]>0.2) && (t[j][i*2]<0.3),{~notestemp[j] = ~notes[j]-rrand(0,20)});
										// if((t[j][i*2]>0.3) && (t[j][i*2]<0.5),{~notestemp[j] = ~notes[j]-rrand(20,40)});
										// if((t[j][i*2]>0.5) && (t[j][i*2]<0.7),{~notestemp[j] = ~notes[j]-rrand(40,60)});
										// if((t[j][i*2]>0.7) && (t[j][i*2]<1),{~notestemp[j] = ~notes[j]-rrand(60,80)});
										// if((t[j][i*2]>1) && (t[j][i*2]<1.3),{~notestemp[j] = ~notes[j]-rrand(60,80)});
										// if((t[j][i*2]>1.5) && (t[j][i*2]<1.5),{~notestemp[j] = ~notes[j]-rrand(0,60)});
										// if((t[j][i*2]>1.5) && (t[j][i*2]<1.8),{~notestemp[j] = ~notes[j]-rrand(20,40)});
										// if((t[j][i*2]>1.8) && (t[j][i*2]<=2),{~notestemp[j] = ~notes[j]-rrand(0,20)});


										if(t[j][i*2]<0.2,{~notestemp[j] = ~notes[j]});
										if((t[j][i*2]>0.2) && (t[j][i*2]<0.3),{~notestemp[j] = ~notes[j]-(~dev*rrand(0,10))});
										if((t[j][i*2]>0.3) && (t[j][i*2]<0.5),{~notestemp[j] = ~notes[j]+(~dev*rrand(0,10))});
										if((t[j][i*2]>0.5) && (t[j][i*2]<0.7),{~notestemp[j] = ~notes[j]-(~dev*rrand(10,20))});
										if((t[j][i*2]>0.7) && (t[j][i*2]<1),{~notestemp[j] = ~notes[j]+(~dev*rrand(10,20))});
										if((t[j][i*2]>1) && (t[j][i*2]<1.3),{~notestemp[j] = ~notes[j]-(~dev*rrand(20,30))});
										if((t[j][i*2]>1.5) && (t[j][i*2]<1.5),{~notestemp[j] = ~notes[j]+(~dev*rrand(20,30))});
										if((t[j][i*2]>1.5) && (t[j][i*2]<1.8),{~notestemp[j] = ~notes[j]-(~dev*rrand(30,40))});
										if((t[j][i*2]>1.8) && (t[j][i*2]<=2),{~notestemp[j] = ~notes[j]+(~dev*rrand(30,40))});

									});

									Pbind(\freq,Pseq([~notestemp],1),\dur,~dur).play;
									~yield.yield;
								});

							});
						);
						r = [~part25.play,~part25.play];});
				};

				//

				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					~part25.stop;
					~w2.close;
					~w1.visible_(true);
				}
			});
		};
		~back = Button(~w1,Rect.new(465,420,70,30));
		~back.states = [["Back", Color.black],["Back", Color.black, Color.red]];
		~back.action = {
			~w1.close;
			w.visible_(true);
		};
	});
};
)