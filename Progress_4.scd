//---------------------------------------WEEK 7,8(Midsem week),9-------------------------------------------------------
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
)

(
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

d
h

//------------------------------------------------------------------
//Can clearly see initial increase in distances then reduction in distances
(
for(0,238,{arg i;
	h[0][i].postln;
});
)
//-----------------------------------------------------------------


//Derive Chords
//Major: T T S T T T S
//A A# B C C# D D# E F F# G G#
//A major seqence: A B C# D E F# G# A
//A major chord: A C# E -------------- 440 554.4 659.3       69 73 76
//B major seqence: B C# D# E F# G# A# B
//B major chord: B D# F# ------------- 493.9 622.3 740       71 75 78
//C major seqence: C D E F G A B C
//C major chord: C E G --------------- 523.3 659.3 784       72 76 79
//D major seqence: D E F# G A B C# D
//D major chord: D F# A -------------- 587.3 740 440         74 78 69
//E major seqence: E F# G# A B C# D# E
//E major chord: E G# B -------------- 659.3 830.6 493.9     76 80 71
//F major seqence: F G A A# C D E F
//F major chord: F A C --------------- 698.5 440 523.3       77 69 72
//G major seqence: G A B C D E F# G
//G major chord: G B D --------------- 784 493.9 587.3       79 71 74

//Minor: T S T T S T T
//A A# B C C# D D# E F F# G G#
//A minor sequence: A B C D E F G A
//A minor chord: A C E
//B minor chord: B D F#
//C minor chord: C
//D minor chord: D F A
//E minor chord: E G B
//F minor chord: F
//G minor chord: G

//69	A4	Sa   440.0
//70	A#4	KRE  466.2
//71	B4	Re   493.9
//72	C5	KGa  523.3
//73	C#5	Ga   554.4
//74	D5	Ma   587.3
//75	D#5	TMa  622.3
//76	E5	Pa   659.3
//77	F5	KDha 698.5
//78	F#5	Dha  740.0
//79	G5	KNi  784.0
//80	G#5	Ni   830.6

//Note      Sa K.Re Re Ga K.Ga Ma T.Ma Pa K.Dha Dha K.Ni Ni

//Freq.Hz. 523 554 587 622 659 698 740 784 831 880 932 988

//Major Chords--------------------------------------------------------------------------

//A major
Pbind(\freq,Pseq([[69.midicps,73.midicps,76.midicps]],1),\dur,1).play;
Pbind(\freq,Pseq([[440,554,659]],1),\dur,1).play;

//B major
Pbind(\freq,Pseq([[71.midicps,75.midicps,78.midicps]],3),\dur,1).play;

//C major
Pbind(\freq,Pseq([[72.midicps,76.midicps,79.midicps]],3),\dur,1).play;

//D major
Pbind(\freq,Pseq([[74.midicps,78.midicps,69.midicps]],3),\dur,1).play;

//E major
Pbind(\freq,Pseq([[76.midicps,80.midicps,71.midicps]],3),\dur,1).play;

//F major
Pbind(\freq,Pseq([[77.midicps,69.midicps,72.midicps]],3),\dur,1).play;

//G major
Pbind(\freq,Pseq([[79.midicps,71.midicps,74.midicps]],3),\dur,1).play;


Pbind(\degree,Pseq([[4,5,7],[7,8,9]],3),\dur,1).play;


//Make Routine ---------------------------------------------------------------

(
~rout1 = Routine({
	for(0, 238, {arg i;

		~in1 = 69;
		~in2 = 73;
		~in3 = 76;

		if(d[0][i]<0.1,{~in1 = 69});
		if((d[0][i]>0.1) && (d[0][i]<0.3),{~in1 = 68});
		if((d[0][i]>0.3) && (d[0][i]<0.5),{~in1 = 67});
		if((d[0][i]>0.5) && (d[0][i]<0.7),{~in1 = 61});
		if((d[0][i]>0.7) && (d[0][i]<1),{~in1 = 63});
		if((d[0][i]>1) && (d[0][i]<1.3),{~in1 = 65});
		if((d[0][i]>1.5) && (d[0][i]<1.5),{~in1 = 64});
		if((d[0][i]>1.5) && (d[0][i]<1.8),{~in1 = 66});
		if((d[0][i]>1.8) && (d[0][i]<=2),{~in1 = 62});

		if(d[1][i]<0.1,{~in2 = 73});
		if((d[1][i]>=0.1) && (d[1][i]<0.3),{~in2 = 72});
		if((d[1][i]>0.3) && (d[1][i]<0.5),{~in2 = 71});
		if((d[1][i]>0.5) && (d[1][i]<0.7),{~in2 = 75});
		if((d[1][i]>0.7) && (d[1][i]<1),{~in2 = 78});
		if((d[1][i]>1) && (d[1][i]<1.3),{~in2 = 76});
		if((d[1][i]>1.3) && (d[1][i]<1.5),{~in2 = 70});
		if((d[1][i]>1.5) && (d[1][i]<1.8),{~in2 = 74});
		if((d[1][i]>1.8) && (d[1][i]<=2),{~in2 = 77});


		if(d[2][i]<0.1,{~in3 = 76});
		if((d[2][i]>0.1) && (d[2][i]<0.3),{~in3 = 75});
		if((d[2][i]>0.3) && (d[2][i]<0.5),{~in3 = 74});
		if((d[2][i]>0.5) && (d[2][i]<0.8),{~in3 = 73});
		if((d[2][i]>0.8) && (d[2][i]<1),{~in3 = 79});
		if((d[2][i]>1) && (d[2][i]<1.3),{~in3 = 81});
		if((d[2][i]>1.3) && (d[2][i]<1.5),{~in3 = 83});
		if((d[2][i]>1.5) && (d[2][i]<1.8),{~in3 = 80});
		if((d[2][i]>1.8) && (d[2][i]<=2),{~in3 = 82});

		~in1.postln;
		~in2.postln;
		~in3.postln;

		Pbind(\freq,Pseq([[~in1.midicps,~in2.midicps,~in3.midicps]],1),\dur,0.01).play;
		0.1.yield;
	});
});
)

(
~rout1.play;
)

a = 69!14
b = 73!14
c = 76!14
~notes = a++b++c


//Sample at every alternate index
(
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

~rout2.play;



//-----------------------------------------------------------------------

//Consecutive

(
~rout3 = Routine({
	for(0, 238, {arg i;

		~in1 = 69;
		~in2 = 73;
		~in3 = 76;

		if(h[0][i].asFloat<0.1,{~in1 = 69});
		if((h[0][i].asFloat>0.1) && (h[0][i].asFloat<0.5),{~in1 = 73});
		if((h[0][i].asFloat>0.5) && (h[0][i].asFloat<=1),{~in1 = 75});
		if((h[0][i].asFloat>1) && (h[0][i].asFloat<=1.5),{~in1 = 78});
		if((h[0][i].asFloat>1.5) && (h[0][i].asFloat<=2),{~in1 = 80});

		if(h[1][i]<0.1,{~in2 = 73});
		if((h[1][i]>=0.1) && (h[1][i]<=0.5),{~in2 = 76});
		if((h[1][i]>0.5) && (h[1][i]<=1),{~in2 = 79});
		if((h[1][i]>1) && (h[1][i]<=1.5),{~in2 = 83});
		if((h[1][i]>1.5) && (h[1][i]<=2),{~in2 = 85});

		if(h[2][i]<0.1,{~in3 = 76});
		if((h[2][i]>=0.1) && (h[2][i]<=0.5),{~in3 = 78});
		if((h[2][i]>0.5) && (h[2][i]<=1),{~in3 = 81});
		if((h[2][i]>1) && (h[2][i]<=1.4),{~in3 = 84});
		if((h[2][i]>1.5) && (h[2][i]<=2),{~in3 = 87});

		~in1.postln;
		~in2.postln;
		~in3.postln;

		Pbind(\freq,Pseq([[~in1.midicps,~in2.midicps,~in3.midicps]],1),\dur,0.1).play;
		0.1.yield;
	});
});
)


~rout3.play;
