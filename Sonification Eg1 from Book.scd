(
q = q ? ();
q.execdata = ();
q.execdata.years = (1977..2008);
q.execdata.regions = (
	Total: [1099, 1, 0, 2, 0, 1, 2, 5, 21, 18, 18, 25, 11, 16, 23, 14, 31, 38, 31, 56, 45, 74, 68, 98, 85, 66, 71, 65, 59, 60, 53, 42, 37],
	Northeast: [4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,1,0,0,0,0,0,1,0,0,0],
	Midwest: [129,0,0,0,0,0,1,0,0,0,1,0,0,0,1,5,1,1,4,3,11,9,10,5,12,5,10,9,7,7,14,6,5,2],
	South: [],
	West: [],
	Texas: []
);
q.getReg = {|q, regName| q.execdata.regions[regName].drop(1)};
)

(
Pbindef(\exec, \note, Pseq(q.getReg(\Midwest)),\octave, 3, \dur, 5 / q.execdata.years.size ).play;
)

Pbindef(\exec, \note, Pseq(q.getReg(\Northeast)));

(
Pbindef(\exec, \note, Pseq(q.getReg(\Midwest)),\octave,3,\dur,5/q.execdata.years.size
).play
)

Pbindef(\exec, \note, Pseq(q.getReg(\Northeast)));

b = Buffer.sendCollection(s,q.getReg(\Northeast),1);
(

Ndef(\exec, {|dur=5, scale=50, offset=200|
	var vals = PlayBuf.ar(1,b,dur/SampleRate.ir);
	Pan2.ar(SinOsc.ar(vals*scale+offset),0,EnvGen.kr(Env.linen(0.01,dur,0.01,0.2),doneAction:2));
}).play;
)

b.sendCollection(q.getReg(\Northeast));
Ndef(\exec).send;