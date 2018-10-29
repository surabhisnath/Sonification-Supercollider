//------------------------------------- WEEK 12 (Mid-recess break), 13 --------------------------------------------------------
//Encapsulate all work with GUI to provide more user control

//-------------------------------------------------------------------------------------------------------
//Initialize all data

(
(
~data_state_crime = CSVFileReader.read("C:/Users/Surabhi/Desktop/IIITD/IP/Datasets/Crime_Women_States_CSV.csv",true);
~data_state_crime.removeAt(0);
);

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
.items_(["","Crimes Rates Against Women in Indian States", "3D Animation Object Spacial Data"])
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
		.string_("Sonification is a process and field of study wherein data is represented through sound. Visual graphs, charts are a common way for expressing data, similarly, sound can also be an affective mode of data representation. Large, detailed data can often not be represents through visual strategies and sonification comes in very useful here. Our aim is to represent chronological and spatial data through sound. For chronological data, we have chosen to depict the crimes rates against women in Indian states and for spatial data, we have mapped different positions of 3D animating objects.")
		.font_(Font("Monaco",14));
		~label2 = StaticText.new(~w1,Rect.new(200,280,600,30))
		.string_("Choose type of Sonification to perform")
		.font_(Font("Monaco",14));
		~choosetype = PopUpMenu(~w1,Rect.new(200,310,600,30))
		.items_(["", "Sequence through years for a particular crime in a particular state - DISCRETE", "Sequence through years for a particular crime in a particular state - CONTINUOUS", "Compare various crimes in the same state", "Compare various states on the same crime", "Play 2 years for a particular state and crime", "Play average values for all states in sequence for a particular crime", "Apply filters on buffers"])
		.action = {
			//----------------------------------------------------------
			if(~choosetype.value == 1,{//Sequence through years for a particular crime in a particular state - DISCRETE
				"hi1".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~state = 0;
				~crime = 0;
				~dur = 0.5;
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

				~label5 = StaticText.new(~w2,Rect.new(362.5,200,275,30))
				.string_("Select speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(362.5,230,275,30),controlSpec:ControlSpec(1,10));
				~choosedur.action = {~dur = 1/~choosedur.value;};

				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					~sig = Pbindef(\final, \freq, Pseq(~data2[~crime*~numstates+~state]), \dur, ~dur);
					~sig.play;
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
							~sig.play;});
					if(~sound == 1,
						{~sig = {Pulse.ar(EnvGen.ar(Env(~data2[~crime*~numstates+~state].asInteger,[~dur!11]),doneAction:2))};
							~sig.play;});
					if(~sound == 2,
						{~sig = {Saw.ar(EnvGen.ar(Env(~data2[~crime*~numstates+~state].asInteger,[~dur!11]),doneAction:2))};
							~sig.play;});
					if(~sound == 3,
						{~sig = {LFNoise0.ar(EnvGen.ar(Env(~data2[~crime*~numstates+~state].asInteger,[~dur!11]),doneAction:2))};
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
			//----------------------------------------------------------
			if(~choosetype.value == 3,{//Compare various crimes in the same state

				//PROBLEM: FAILURE IN SERVER (SOMETIMES) ON PLAYING -- 24.00min in Supercollider GUI Video 14 for soln
				"hi3".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

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

				//PROBLEM: FAILURE IN SERVER (SOMETIMES) ON PLAYING -- 24.00min in Supercollider GUI Video 14 for soln
				"hi4".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

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

				~avg = 0;
				~sound = 0;
				~dur = 1;
				//
				~label3 = StaticText.new(~w2,Rect.new(360,100,275,30))
				.string_("Choose type of Averaging to Perform")
				.font_(Font("Monaco",14));
				~chooseavg = PopUpMenu(~w2,Rect.new(360,130,275,30))
				//ADD MORE AVG TYPES
				.items_(["Yearwise"]);
				~chooseavg.action = {~avg = ~chooseavg.value;};

				~label4 = StaticText.new(~w2,Rect.new(200,200,275,30))
				.string_("Select sound type")
				.font_(Font("Monaco",14));
				~choosesound = PopUpMenu(~w2,Rect.new(200,230,275,30))
				.items_(["SinOsc","Pulse","Saw","LFNoise0"]);
				~choosesound.action = {~sound = ~choosesound.value; ~sound.postln};

				~label5 = StaticText.new(~w2,Rect.new(525,200,275,30))
				.string_("Select speed")
				.font_(Font("Monaco",14));
				~choosedur = EZSlider.new(~w2,Rect.new(525,230,275,30),controlSpec:ControlSpec(1,10));
				~choosedur.action = {~dur = 1/~choosedur.value;};

				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					//ADD MORE ONCE MORE AVG TYPES ADDED
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

				//PROBLEM: FREQUENCY HAS NO EFFECT ON FILTERS!!!!!!!!
				"hi7".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);


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
				~playorig.action = {s.freeAll; ~buffer.play;};

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
		.string_("3D ANIMATION OBJECT SPACIAL DATA")
		.font_(Font("Monaco",25))
		.align_(\center);
		~description1 = StaticText.new(~w1,Rect.new(200,120,600,120))
		.string_("Sonification is a process and field of study wherein data is represented through sound. Visual graphs, charts are a common way for expressing data, similarly, sound can also be an affective mode of data representation. Large, detailed data can often not be represents through visual strategies and sonification comes in very useful here. Our aim is to represent chronological and spatial data through sound. For chronological data, we have chosen to depict the crimes rates against women in Indian states and for spatial data, we have mapped different positions of 3D animating objects.")
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

					r = ~part21.play;
				};



				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					r.stop;
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
				//
				// Pbind(\freq,Pseq(~pseqarrx.normalize(100,1000),1),\dur,0.1).play;//How x coordinate of any point is changing
				// Pbind(\freq,Pseq(~pseqarry.normalize(100,1000),1),\dur,0.1).play;//How y coordinate of any point is changing
				// Pbind(\freq,Pseq(~pseqarrz.normalize(100,1000),1),\dur,0.1).play;//How z coordinate of any point is changing
				//OBSERVATION: x coordinate and z change the same
				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
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
				//

				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
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
				//
/*				(
					~rout2 = Routine({
						for(0, 119, {arg i;

							~in1 = 69;
							~in2 = 73;
							~in3 = 76;

							if(d[0][i*2]<0.1,{~in1 = 69});
							if((d[0][i*2]>0.1) && (d[0][i*2]<0.3),{~in1 = 68});
							if((d[0][i*2]>0.3) && (d[0][i*2]<0.5),{~in1 = 67});
							if((d[0][i*2]>0.5) && (d[0][i*2]<0.7),{~in1 = 61});
							if((d[0][i*2]>0.7) && (d[0][i*2]<1),{~in1 = 63});
							if((d[0][i*2]>1) && (d[0][i*2]<1.3),{~in1 = 65});
							if((d[0][i*2]>1.5) && (d[0][i*2]<1.5),{~in1 = 64});
							if((d[0][i*2]>1.5) && (d[0][i*2]<1.8),{~in1 = 66});
							if((d[0][i*2]>1.8) && (d[0][i*2]<=2),{~in1 = 62});

							if(d[1][i*2]<0.1,{~in2 = 73});
							if((d[1][i*2]>=0.1) && (d[1][i*2]<0.3),{~in2 = 72});
							if((d[1][i*2]>0.3) && (d[1][i*2]<0.5),{~in2 = 71});
							if((d[1][i*2]>0.5) && (d[1][i*2]<0.7),{~in2 = 75});
							if((d[1][i*2]>0.7) && (d[1][i*2]<1),{~in2 = 78});
							if((d[1][i*2]>1) && (d[1][i*2]<1.3),{~in2 = 76});
							if((d[1][i*2]>1.3) && (d[1][i*2]<1.5),{~in2 = 70});
							if((d[1][i*2]>1.5) && (d[1][i*2]<1.8),{~in2 = 74});
							if((d[1][i*2]>1.8) && (d[1][i*2]<=2),{~in2 = 77});


							if(d[2][i*2]<0.1,{~in3 = 76});
							if((d[2][i*2]>0.1) && (d[2][i*2]<0.3),{~in3 = 75});
							if((d[2][i*2]>0.3) && (d[2][i*2]<0.5),{~in3 = 74});
							if((d[2][i*2]>0.5) && (d[2][i*2]<0.8),{~in3 = 73});
							if((d[2][i*2]>0.8) && (d[2][i*2]<1),{~in3 = 79});
							if((d[2][i*2]>1) && (d[2][i*2]<1.3),{~in3 = 81});
							if((d[2][i*2]>1.3) && (d[2][i*2]<1.5),{~in3 = 83});
							if((d[2][i*2]>1.5) && (d[2][i*2]<1.8),{~in3 = 80});
							if((d[2][i*2]>1.8) && (d[2][i*2]<=2),{~in3 = 82});

							~in1.postln;
							~in2.postln;
							~in3.postln;

							Pbind(\freq,Pseq([[~in1.midicps,~in2.midicps,~in3.midicps]],1),\dur,0.01).play;
							0.08.yield;
						});
					});
				)

				~rout2.play;*/
				//

				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
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
				//
				/*				~go = 0.01;
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
				)*/
				//

				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
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