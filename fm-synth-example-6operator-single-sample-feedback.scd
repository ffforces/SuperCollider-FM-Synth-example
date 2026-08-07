
/////////////


// forces - permutations
// https://biodiversitarecords.bandcamp.com/album/permutations
// track: Filter Moisture

//fm example


//important evaluate this buffer for a single sample feedback possibility

//free buffers if you have buffers evaluated: Buffer.freeAll;

// first evaluate this

b = Buffer.alloc(s, 1);

// this is inspired by algorithm #2 of yamaha dx 7
// https://www.righto.com/2021/12/yamaha-dx7-chip-reverse-engineering.html

(
SynthDef(\fm,{ arg amp=0.8,freq=20,splay=0.4, index2, index3, index4, index5, index6=10, ratio1=1,ratio2=2,ratio3=3,ratio4=3,ratio5=6,ratio6=2,env1att=0.007,env1rel=3, env2att=0.007,env2rel=3, env3att=0.007,env3rel=3;
	var osc1, osc2, osc3,osc4,osc5,osc6, env1, env2,env3,env4,env5,env6,env7,env8,env9,sound, osc2fb;
//modulation envelope
	env2=EnvGen.ar(Env.perc(env2att,env2rel),doneAction:0);


//osc block 1
	osc2fb = Dbufrd(b); // read from buffer
	osc2fb = SinOsc.ar(freq + (ratio2*freq * env2* Duty.ar(SampleDur.ir,0,osc2fb) ), mul:freq*ratio2*env2*index2);
    osc2 = Dbufwr(osc2fb, b); // write to buffer
    osc2 = Duty.ar(SampleDur.ir, 0, osc2);
	osc1=LeakDC.ar(SinOsc.ar((ratio1*freq)+osc2,mul:0.5));

//osc block 2

	osc3=SinOsc.ar(freq*ratio3*env2,mul:freq*ratio3*env2*index3);
	osc4=SinOsc.ar(((freq*ratio4*env2)+osc3),mul:freq*ratio4*env2*index4);
	osc5=SinOsc.ar(((freq*ratio5*env2)+osc4),mul:freq*ratio5*env2*index5);
	osc6=LeakDC.ar(SinOsc.ar((freq*ratio6)+osc5,mul:0.5));


//envelopes
	env1=EnvGen.ar(Env.perc(env1att,env1rel),doneAction:2);
	env3=EnvGen.ar(Env.perc(env3att,env3rel),doneAction:2);

//free the synth
	FreeSelf.kr(Done.kr(env1) * Done.kr(env3));


	sound=Limiter.ar(((osc1*env1)+(osc6*env3))*amp);

	sound=Splay.ar(sound,splay,1,0.0);
	Out.ar(0, sound);
	}
).add;
)





//basic pattern with every paramater as 1


(
~pat=Pdef(\a,
	Pbind(
	\instrument,\fm,
	\dur, 3,
	\freq, Pseq([30,35,37,49],inf).midicps,
	\ratio1,1,
	\ratio2,1,
	\ratio3,1,
	\ratio4,1,
	\ratio5,1,
	\splay, 1,

	\index2,1,
	\index3,1,
	\index4,1,
	\index5,1,

	\env1att,1,
	\env1rel,1,

	\env2att,1,
	\env2rel,1,

	\env3att,1,
	\env3rel,1,


	\amp, 0.5,

);
);
)

~patPlay=~pat.play;
~patPlay.stop;






//not very interestin so more modulations





(
~pat=Pdef(\a,
	Pbind(
	\instrument,\fm,
	\dur, 3,
	\freq, Pseq([30,35,37,49],inf).midicps,

	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),

	\ratio1,1,
	\ratio2,2,
	\ratio3,3,
	\ratio4,3,
	\ratio5,6,
	\ratio6,2,
	\env1att,0.007,
	\env1rel,3,
	\env2att,0.007,
	\env2rel,3,
	\env3att,0.007,
	\env3rel,3,

	\index2,Pwhite(0.3,7.0, inf),
	\index3,Pwhite(3.0,7.0,inf),
	\index4,Pwhite(0.1,7.0,inf),
	\index5,Pwhite(3.0,5.0,inf),


	\amp, 0.5,

);
);
)

~patPlay=~pat.play;
~patPlay.stop;






//faster!

(
~pat=Pdef(\a,
	Pbind(
	\instrument,\fm,
		\dur, Pwrand([0.08,0.3,0.1],[10,5,100].normalizeSum,inf)+0,
	\freq, Pseq([30,35,37,49],inf).midicps,

	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),

	\ratio1,Prand([1,2,3,4],inf)+0,
	\ratio2,2,
	\ratio3,1,
	\ratio4,2,
	\ratio5,20,
	\ratio6,2,
	\env1att,0.004,
	\env1rel,Prand([1,1.5],inf)*0.5,
	\env2att,0.007,
	\env1rel,Prand([1,1.5,3],inf),
	\env3att,0.07,
	\env3rel,Prand([1,1.5,3],inf)*0.05,

	\index2,Pwhite(0.3,5.0, inf),
	\index3,Pwhite(3.0,2.0,inf),
	\index4,Pwhite(0.1,2.0,inf),
	\index5,Pwhite(1.0,5.0,inf),


	\amp, 0.5,

);
);
)

~patPlay=~pat.play;
~patPlay.stop;






//fm drone
// prand 1 3 5
(
~pat=Pdef(\a,
	Pbind(
	\instrument,\fm,
	\dur, 10,
	\freq, ([30,34,37,42]+Prand([1,3,5],inf)).midicps,

	\splay, 0.9,

	\ratio1,Prand([1,3,5],inf),
	\ratio2,Prand([1,3,5],inf),
	\ratio3,Prand([1,3,5],inf),
	\ratio4,Prand([1,3,5],inf),
	\ratio5,Prand([1,3,5],inf),
	\ratio6,Prand([1,3,5],inf),
	\env1att,5.004,
	\env1rel,20,
	\env2att,10.007,
	\env2rel,10.007,

	\env3att,8,
	\env3rel,20,

	\index2,Prand([1,3,5,],inf),
	\index3,Prand([1,3,5],inf),
	\index4,Prand([1,3,5],inf),
	\index5,Prand([1,3,5],inf),


	\amp, 0.5,

);
);
)



~patPlay=~pat.play;
~patPlay.stop;





//weird

(
~pat=Pdef(\a,
	Pbind(
	\instrument,\fm,
		\dur, 1,
	\freq, 20.midicps,

	\splay, 0.91,

	\ratio1,5,
	\ratio2,2,
	\ratio3,3,
	\ratio4,4,
	\ratio5,5,
	\ratio6,6,
	\env1att,2,
	\env1rel,3,
	\env2att,1.007,
	\env2rel,3.007,

	\env3att,3,
	\env3rel,3,

	\index2,Pn(Pseries(0.0,5,200),inf),
		\index3,Pn(Pseries(0.0, 3,200),inf),
	\index4,Pwhite(0.1,2.0,inf),
	\index5,Pwhite(1.0,5.0,inf),


	\amp, 0.3,

);
);
)


~patPlay=~pat.play;
~patPlay.stop;




//funny computer music

(
~pat=Pdef(\a,
	Pbind(
	\instrument,\fm,
	\dur, Pn(Pseries(0.03,0.1,10),inf),
	\freq, Pn(Pseries(1,1,40),inf).midicps,

	\splay, Pseq([0.91,0.01],inf),

	\ratio1,Prand([0.5,10],inf),
	\ratio2,Pn(Pseries(0.1,10,3),inf),
	\ratio3,0.30,
	\ratio4,40,
	\ratio5,50,
	\ratio6,0.60,
	\env1att,0.2,
	\env1rel,Prand([0.8,2],inf),
	\env2att,Pn(Pseries(0.001,0.1,10),inf),
	\env2rel,13.007,

	\env3att,0.3,
	\env3rel,Prand([0.8,2],inf),

		\index2,Pn(Pseries(10.0,50,20),inf)-Prand([10,20,50,100],inf),
		\index3,Pn(Pseries(10.0, 30,200),inf)-Prand([10,20,50,100],inf),
		\index4,Pseq([1,2,4,5,100],inf),
		\index5,Pseq([10,0.1,30],inf),


	\amp, 0.3,

);
);
)



~patPlay=~pat.play;
~patPlay.stop;







//approaching acid

(
~pat=Pdef(\a,
	Pbind(
	\instrument,\fm,
	\dur, 0.1,
	\freq, (Pseq([30,30,30,\, 29,35,39,39],inf)).midicps,
	\ratio1,4,
	\ratio2,2,
	\ratio3,4,
	\ratio4,5,
	\ratio5,2,
	\splay, 1,

	\index2,Prand([6,7,10],inf),
	\index3,3,
	\index4,5,
	\index5,2,

	\env1att,0.1,
	\env1rel,Pwrand([0.3,0.5,],[10,1].normalizeSum, inf),

	\env2att,0.01,
	\env2rel,Pwrand([0.3,0.5,],[10,1].normalizeSum, inf),

	\env3att,0.1,
	\env3rel,Pwrand([0.3,1.5,],[10,1].normalizeSum, inf),


	\amp, 0.3,

);
);
)



~patPlay=~pat.play;
~patPlay.stop;












//////////////////////////////////////////////////////////
// not cleaned up
//the actual code for the track: Filter Moisture
// has some random values
(
SynthDef(\fm,{ arg fb=0.4,amp=0.8,azim,angle,freq=20,decim=100,splay=0.4,plus1=0.1,plus2=0.1,multiple=1, index2, index3, index4, index5, index6=10, ratio1=1,ratio2=2,ratio3=1.5,ratio4=120,ratio5=6,ratio6=2;
	var osc1, osc2, osc3,osc4,osc5,osc6, env1, env2,env3,env4,env5,env6,env7,env8,env9,sound, osc2fb;

	env2=EnvGen.ar(Env.perc(0.007,Rand(0.7,5.0)),doneAction:0);







	osc2fb = Dbufrd(b); // read from buffer
	osc2fb = SinOsc.ar(freq + ((ratio2*env2)*freq * (multiple*env2)* Duty.ar(SampleDur.ir,0,osc2fb) ), mul:freq*(ratio2*env2)*index2);


    osc2 = Dbufwr(osc2fb, b); // write to buffer
    osc2 = Duty.ar(SampleDur.ir, 0, osc2);


	osc1=LeakDC.ar(SinOsc.ar((ratio1*freq)+osc2,mul:0.5));



osc3=SinOsc.ar(freq*ratio3,mul:freq*ratio3*index3);
	osc4=SinOsc.ar(((freq*(ratio4*env2))+osc3),mul:freq*(ratio4*env2)*index4);
osc5=SinOsc.ar(((freq*ratio5)+osc4),mul:freq*ratio5*index5);
	osc6=LeakDC.ar(SinOsc.ar((freq*ratio6)+osc5,mul:0.5));



env1=EnvGen.ar(Env.perc(0.03,Rand(0.5,4.4)+plus1),doneAction:2);
env3=EnvGen.ar(Env.perc(0.03,Rand(0.5,4.4)),doneAction:2);

	sound=Limiter.ar(((osc1*env1)+(osc6*env3))*amp);
//notice the multichannel expansion !2
	sound=LeakDC.ar(Limiter.ar(Splay.ar(sound,splay,1,0.0,)));
	Out.ar(0, sound);
	}
).add;
)





(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\fm,
	\dur, Pwrand2([0.51,0.3,0.56]*0.24,[0.3, 0.5, 0.2],inf),
	\dur, Pwrand2([0.51,0.3,0.56],[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42],[300,100,20],inf),

	\freq, 30.midicps,
	\multiple, Prand([0.01,0.1,0.6,0.2]*3.6,inf),
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[3,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	\index2,Pwhite(3.0,7.0, inf),
	\index3,Pwhite(3.0,7.0,inf),
	\index4,Pwhite(0.1,7.0,inf),
	\index5,Pwhite(3.0,5.0,inf),


	\amp, 0.5,

);
);
)

~pat2Play=~pat2.play;
~pat2Play.stop;



(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\fm,
		\dur, Pwrand2([0.51,0.3,0.56]*0.41,[0.3, rrand(0.0,1.0), 0.2].scramble,inf),
//	\dur, Pwrand2([0.51,0.3,0.56].scramble,[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42].scramble,[300,100,20],inf),
	//\dur, 0.8,
	\freq, 30.midicps,
		\freq, Pseq([30,40,40,30,30,40,[30,35,42].choose].scramble,inf).midicps,
	//\freq, Pwhite(10,17).midicps,
	//\freq, Prand([10,10,10,10,10,Pwhite(10,17,1)],inf).midicps,
		\multiple, Prand([0.01,0.1,0.6,0.2],inf)*Pwhite(3.0,8.0),
//	\freq, Pwhite(30,33).midicps,

	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[320,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	//\plus2, 0,
	\amp, 0.5,
	\index2,Pwhite(3.0,7.0, inf),
	\index3,Pwhite(3.0,7.0,inf),
	\index4,Pwhite(0.1,7.0,inf),
	\index5,Pwhite(3.0,5.0,inf),
);
);
)





//final
(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\fm,
	\dur, Pwrand2([0.51,0.3,0.56]*0.41,[0.3, rrand(0.0,1.0), 0.2].scramble,inf),
	\freq, Pseq([30,40,40,30,30,40,[30,35,42].choose].scramble,inf).midicps,
	\multiple, Prand([0.01,0.1,0.6,0.2],inf)*Pwhite(3.0,1.0),
//	\freq, Pwhite(30,33).midicps,
	\decim, Pn(Pseries(300,100,400),inf),
	\decim, Prand([44100,44100,44100,44100,2300],inf),
	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[320,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	//\plus2, 0,
	\amp, 0.5,
	\index2,Pwhite(3.0,7.0, inf),
	\index3,Pwhite(3.0,7.0,inf),
	\index4,Pwhite(0.1,7.0,inf),
	\index5,Pwhite(3.0,5.0,inf),
);
);
)















////////////////////////////////////

//new indices
//toimiva


(
SynthDef(\fm,{ arg ratio1=2,  fb=0.4,amp=0.8,azim,angle,freq=20,decim=100,splay=0.4,plus1=0.1,plus2=0.1,multiple=1, index2, index3, index4, index5, index6=10;
	var osc1, osc2, osc3,osc4,osc5,osc6, env1, env2,env3,env4,env5,env6,env7,env8,env9,sound, ratio2,ratio3,ratio4, ratio5,ratio6, osc2fb;

	env2=EnvGen.ar(Env.perc(0.007,Rand(0.7,5.0)),doneAction:0).clip(0,1);

	ratio1=1.99;
	ratio1=1;
	ratio2=2*(env2);
	ratio3=1.5;
	ratio4=120*env2;
	ratio5=6;
	ratio6=2;





	osc2fb = Dbufrd(b); // read from buffer
	osc2fb = SinOsc.ar(freq + (ratio2*freq * (multiple*env2)* Duty.ar(SampleDur.ir,0,osc2fb) ), mul:freq*ratio2*index2);


    osc2 = Dbufwr(osc2fb, b); // write to buffer
    osc2 = Duty.ar(SampleDur.ir, 0, osc2);


	osc1=LeakDC.ar(SinOsc.ar((ratio1*freq)+osc2,mul:0.5));



osc3=SinOsc.ar(freq*ratio3,mul:freq*ratio3*index3);
osc4=SinOsc.ar(((freq*ratio4)+osc3),mul:freq*ratio4*index4);
osc5=SinOsc.ar(((freq*ratio5)+osc4),mul:freq*ratio5*index5);
	osc6=LeakDC.ar(SinOsc.ar((freq*ratio6)+osc5,mul:0.5));



env1=EnvGen.ar(Env.perc(0.03,Rand(0.5,4.4)+plus1),doneAction:2).clip(0,1);
env3=EnvGen.ar(Env.perc(0.03,Rand(0.5,4.4)),doneAction:2).clip(0,1);

	sound=Limiter.ar(((osc1*env1)+(osc6*env3))*amp);
//notice the multichannel expansion !2
	sound=LeakDC.ar(Limiter.ar(Splay.ar(sound,splay,1,0.0,)));
	Out.ar(0, sound);
	}
).add;
)



//////////////////////////
//old indices

(
SynthDef(\fm,{ arg ratio1=2,  fb=0.4,amp=0.8,azim,angle,freq=20,decim=100,splay=0.4,plus1=0.1,plus2=0.1,multiple=1, theta, phi;
	var osc1, osc2, osc3,osc4,osc5,osc6, env1, env2,env3,env4,env5,env6,env7,env8,env9,sound, localin, localout,ratio2,ratio3,ratio4, ratio5,ratio6,index1,index2,index3,index4, index5,index6, osc2fb;

	env2=EnvGen.ar(Env.perc(0.007,Rand(0.7,5.0)),doneAction:0).clip(0,1);

	ratio1=1.99;
	ratio1=1;
	ratio2=2*(env2);
	ratio3=1.5;
	ratio4=120*env2;
	ratio5=6;
	ratio6=2;


	index2=Rand(3.0,7.0)*env2;
	index3=Rand(3.0,7.0)*env2;
	index4=Rand(0.1,7.0)*env2;
	index5=Rand(3.0,5.0)*env2;
	index6=10;



	osc2fb = Dbufrd(b); // read from buffer
	osc2fb = SinOsc.ar(freq + (ratio2*freq * (multiple*env2)* Duty.ar(SampleDur.ir,0,osc2fb) ), mul:freq*ratio2*(index2*env2));


    osc2 = Dbufwr(osc2fb, b); // write to buffer
    osc2 = Duty.ar(SampleDur.ir, 0, osc2);


	osc1=LeakDC.ar(SinOsc.ar((ratio1*freq)+osc2,mul:0.5));



	osc3=SinOsc.ar(freq*ratio3,mul:freq*ratio3*(index3*env2));
	osc4=SinOsc.ar(((freq*ratio4)+osc3),mul:freq*ratio4*(index4*env2));
	osc5=SinOsc.ar(((freq*ratio5)+osc4),mul:freq*ratio5*(index5*env2));
	osc6=LeakDC.ar(SinOsc.ar((freq*ratio6)+osc5,mul:0.5));



env1=EnvGen.ar(Env.perc(0.03,Rand(0.5,4.4)+plus1),doneAction:2).clip(0,1);
env3=EnvGen.ar(Env.perc(0.03,Rand(0.5,4.4)),doneAction:2).clip(0,1);

	sound=Limiter.ar(((osc1*env1)+(osc6*env3))*amp);
//notice the multichannel expansion !2
	sound=LeakDC.ar(Limiter.ar(Splay.ar(sound,splay,1,0.0,)));
	Out.ar(0, sound);
	}
).add;
)



//cleaned up pattern


(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\fm,
	\dur, Pwrand2([0.51,0.3,0.56]*0.24,[0.3, 0.5, 0.2],inf),
	\dur, Pwrand2([0.51,0.3,0.56],[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42],[300,100,20],inf),

	\freq, 30.midicps,
	\multiple, Prand([0.01,0.1,0.6,0.2]*3.6,inf),
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[3,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	\index2,Pwhite(3.0,7.0, inf),
	\index3,Pwhite(3.0,7.0,inf),
	\index4,Pwhite(0.1,7.0,inf),
	\index5,Pwhite(3.0,5.0,inf),


	\amp, 0.8,

);
);
)


(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\fm,
		\dur, Pwrand2([0.51,0.3,0.56]*0.41,[0.3, rrand(0.0,1.0), 0.2].scramble,inf),
//	\dur, Pwrand2([0.51,0.3,0.56].scramble,[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42].scramble,[300,100,20],inf),
	//\dur, 0.8,
	\freq, 30.midicps,
		\freq, Pseq([30,40,40,30,30,40,[30,35,42].choose].scramble,inf).midicps,
	//\freq, Pwhite(10,17).midicps,
	//\freq, Prand([10,10,10,10,10,Pwhite(10,17,1)],inf).midicps,
		\multiple, Prand([0.01,0.1,0.6,0.2],inf)*Pwhite(3.0,8.0),
//	\freq, Pwhite(30,33).midicps,

	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[320,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	//\plus2, 0,
	\amp, 0.8,
	\index2,Pwhite(3.0,7.0, inf),
	\index3,Pwhite(3.0,7.0,inf),
	\index4,Pwhite(0.1,7.0,inf),
	\index5,Pwhite(3.0,5.0,inf),
);
);
)





//final
(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\fm,
	\dur, Pwrand2([0.51,0.3,0.56]*0.41,[0.3, rrand(0.0,1.0), 0.2].scramble,inf),
	\freq, Pseq([30,40,40,30,30,40,[30,35,42].choose].scramble,inf).midicps,
	\multiple, Prand([0.01,0.1,0.6,0.2],inf)*Pwhite(3.0,1.0),
//	\freq, Pwhite(30,33).midicps,
	\decim, Pn(Pseries(300,100,400),inf),
	\decim, Prand([44100,44100,44100,44100,2300],inf),
	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[320,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	//\plus2, 0,
	\amp, 0.8,
	\index2,Pwhite(3.0,7.0, inf),
	\index3,Pwhite(3.0,7.0,inf),
	\index4,Pwhite(0.1,7.0,inf),
	\index5,Pwhite(3.0,5.0,inf),
);
);
)









/////////////

//working old pattern

(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\fm,
	\dur, Pwrand2([0.51,0.3,0.56]*0.24,[0.3, 0.5, 0.2],inf),
	\dur, Pwrand2([0.51,0.3,0.56],[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42],[300,100,20],inf),
	//\dur, 0.8,
	\freq, 30.midicps,
	//\freq, Pseq([30,33,32],inf).midicps,
	//\freq, Pwhite(10,17).midicps,
	//\freq, Prand([10,10,10,10,10,Pwhite(10,17,1)],inf).midicps,
	\multiple, Prand([0.01,0.1,0.6,0.2]*3.6,inf),
//	\freq, Pwhite(30,33).midicps,
	\decim, Pn(Pseries(300,100,400),inf),
	\decim, Prand([44100,44100,44100,44100,2300],inf),
	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[3,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),

	\amp, 0.8,
	\angle, 120,
	\theta, Pwhite(-20,20),
	\phi, Pwhite(-10,10,inf),
);
);
)



~pat2Play=~pat2.play;
~pat2Play.stop;











///////////////////////////////////////////////////
//original:

// forces -


b = Buffer.alloc(s, 1);

~encoder_diffuse   = FoaEncoderKernel.newDiffuse;
~decoder = FoaDecoderKernel.newUHJ;




//edit
(
SynthDef(\sin2,{ arg ratio1=2,  fb=0.4,amp=0.8,azim,angle,freq=20,decim=100,splay=0.4,plus1=0.1,plus2=0.1,multiple=1, theta, phi;
	var osc1, osc2, osc3,osc4,osc5,osc6, env1, env2,env3,env4,env5,env6,env7,env8,env9,sound, localin, localout,ratio2,ratio3,ratio4, ratio5,ratio6,index1,index2,index3,index4, index5,index6, osc2fb;
	//freq=LFDNoise3.ar(0.001).range(40.midicps,90.midicps);
	//freq=[28,30,32, 33, 35,37, 38,40,42,44,45,47,49,50,52,54,56,58,59].choose.midicps;
//	freq=90.midicps;
	env2=EnvGen.ar(Env.perc(0.007,Rand(0.7,5.0)),doneAction:0).clip(0,1);
//	env2=1;
	ratio1=1.99;
ratio1=1;
	ratio2=2*(env2);
	ratio3=1.5;
	ratio4=120*env2;
	ratio5=6;
	ratio6=2;
	//index1=Rand(0.1,1000.0);
	//index1=300;
	index2=Rand(0.1,1000.0);
	index2=Rand(3.0,7.0)*env2;
	//index2=2000*env2;
	index3=Rand(3.0,7.0)*env2;
	//index3=100*env2;
	//index4=200;
	index4=Rand(0.1,7.0)*env2;
	index5=Rand(3.0,5.0)*env2;
	//index5=32.4;
	index6=10;
	//index6=3;


osc2fb = Dbufrd(b); // read from buffer
osc2fb = SinOsc.ar(freq + (ratio2*freq * (multiple*env2)* Duty.ar(SampleDur.ir,0,osc2fb) ), mul:freq*ratio2*index2);


    osc2 = Dbufwr(osc2fb, b); // write to buffer
    osc2 = Duty.ar(SampleDur.ir, 0, osc2);
	//osc2=Decimator.ar(osc2, decim);

	osc1=LeakDC.ar(SinOsc.ar((ratio1*freq)+osc2,mul:0.5));



osc3=SinOsc.ar(freq*ratio3,mul:freq*ratio3*index3);
osc4=SinOsc.ar(((freq*ratio4)+osc3),mul:freq*ratio4*index4);
osc5=SinOsc.ar(((freq*ratio5)+osc4),mul:freq*ratio5*index5);
	osc6=LeakDC.ar(SinOsc.ar((freq*ratio6)+osc5,mul:0.5));
	osc6=LPF.ar(osc6, 20000);


env1=EnvGen.ar(Env.perc(0.03,Rand(0.5,4.4)+plus1),doneAction:2).clip(0,1);
//env3=EnvGen.ar(Env.perc(0.031,Rand(2,8.4)+plus2),doneAction:2).clip(0,1);
env3=EnvGen.ar(Env.perc(0.03,Rand(0.5,4.4)),doneAction:2).clip(0,1);

//	sound=((osc1*env1*0.9)*amp);
	sound=Limiter.ar(((osc1*env1)+(osc6*env3))*amp);
//	sound=Limiter.ar(osc6*env3*amp);
	//sound=FoaEncode.ar(((osc1*env1*1)+(osc6*env3))*amp, ~encoder_diffuse);
	sound=FoaEncode.ar(sound, ~encoder_diffuse);
	sound=FoaTransform.ar(Limiter.ar(sound, 0.99, 0.01), 'push', angle.degrad, theta.degrad,phi.degrad);
	//sound=SineShaper.ar(sound, limit: 0.1, mul: 1, add: 0);
	sound = FoaDecode.ar(sound, ~decoder);
//notice the multichannel expansion !2
	//sound=LeakDC.ar(Limiter.ar(Splay.ar(sound,splay,1,0.0,)));
	sound=LeakDC.ar(Limiter.ar(sound));
	Out.ar(0, sound);
	}
).add;
)


(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\sin2,
	\dur, Pwrand2([0.51,0.3,0.56]*0.24,[0.3, 0.5, 0.2],inf),
	\dur, Pwrand2([0.51,0.3,0.56],[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42],[300,100,20],inf),
	//\dur, 0.8,
	\freq, 30.midicps,
	//\freq, Pseq([30,33,32],inf).midicps,
	//\freq, Pwhite(10,17).midicps,
	//\freq, Prand([10,10,10,10,10,Pwhite(10,17,1)],inf).midicps,
	\multiple, Prand([0.01,0.1,0.6,0.2]*3.6,inf),
//	\freq, Pwhite(30,33).midicps,
	\decim, Pn(Pseries(300,100,400),inf),
	\decim, Prand([44100,44100,44100,44100,2300],inf),
	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[3,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	//\plus2, 0,
	\amp, 1,
	\angle, 120,
	\theta, Pwhite(-20,20),
	\phi, Pwhite(-10,10,inf),
);
);
)



~pat2Play=~pat2.play;
~pat2Play.stop;


(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\sin2,
	\dur, Pwrand2([0.51,0.3,0.56]*0.24,[0.3, 0.5, 0.2],inf),
	\dur, Pwrand2([0.51,0.3,0.56].scramble,[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42].scramble,[300,100,20],inf),
	//\dur, 0.8,
	\freq, 30.midicps,
	\freq, Pseq([30],inf).midicps,
	//\freq, Pwhite(10,17).midicps,
	//\freq, Prand([10,10,10,10,10,Pwhite(10,17,1)],inf).midicps,
	\multiple, Prand([0.01,0.1,0.6,0.2]*3.6,inf),
//	\freq, Pwhite(30,33).midicps,
	\decim, Pn(Pseries(300,100,400),inf),
	\decim, Prand([44100,44100,44100,44100,2300],inf),
	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[320,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	//\plus2, 0,
	\amp, 1,
	\angle, 120,
	\theta, Pwhite(-20,20),
	\phi, Pwhite(-10,10,inf),
);
);
)

///////////

(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\sin2,
	\dur, Pwrand2([0.51,0.3,0.56]*0.41,[0.3, 0.5, 0.2],inf),
//	\dur, Pwrand2([0.51,0.3,0.56].scramble,[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42].scramble,[300,100,20],inf),
	//\dur, 0.8,
	\freq, 30.midicps,
	\freq, Pseq([30],inf).midicps,
	//\freq, Pwhite(10,17).midicps,
	//\freq, Prand([10,10,10,10,10,Pwhite(10,17,1)],inf).midicps,
	\multiple, Prand([0.01,0.1,0.6,0.2]*3.6,inf),
//	\freq, Pwhite(30,33).midicps,
	\decim, Pn(Pseries(300,100,400),inf),
	\decim, Prand([44100,44100,44100,44100,2300],inf),
	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[320,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	//\plus2, 0,
	\amp, 1,
	\angle, 120,
	\theta, Pwhite(-20,20),
	\phi, Pwhite(-10,10,inf),
);
);
)


~pat2Play=~pat2.play;
~pat2Play.stop;



(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\sin2,
		\dur, Pwrand2([0.51,0.3,0.56]*0.41,[0.3, rrand(0.0,1.0), 0.2].scramble,inf),
//	\dur, Pwrand2([0.51,0.3,0.56].scramble,[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42].scramble,[300,100,20],inf),
	//\dur, 0.8,
	\freq, 30.midicps,
	\freq, Pseq([30,40],inf).midicps,
	//\freq, Pwhite(10,17).midicps,
	//\freq, Prand([10,10,10,10,10,Pwhite(10,17,1)],inf).midicps,
	\multiple, Prand([0.01,0.1,0.6,0.2],inf)*Pwhite(0.0,8.0),
//	\freq, Pwhite(30,33).midicps,
	\decim, Pn(Pseries(300,100,400),inf),
	\decim, Prand([44100,44100,44100,44100,2300],inf),
	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[320,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	//\plus2, 0,
	\amp, 1,
	\angle, 120,
	\theta, Pwhite(-20,20),
	\phi, Pwhite(-10,10,inf),
);
);
)



(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\sin2,
		\dur, Pwrand2([0.51,0.3,0.56]*0.41,[0.3, rrand(0.0,1.0), 0.2].scramble,inf),
//	\dur, Pwrand2([0.51,0.3,0.56].scramble,[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42].scramble,[300,100,20],inf),
	//\dur, 0.8,
	\freq, 30.midicps,
		\freq, Pseq([30,40,40,30,30,40,[30,35,42].choose].scramble,inf).midicps,
	//\freq, Pwhite(10,17).midicps,
	//\freq, Prand([10,10,10,10,10,Pwhite(10,17,1)],inf).midicps,
		\multiple, Prand([0.01,0.1,0.6,0.2],inf)*Pwhite(3.0,8.0),
//	\freq, Pwhite(30,33).midicps,
	\decim, Pn(Pseries(300,100,400),inf),
	\decim, Prand([44100,44100,44100,44100,2300],inf),
	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[320,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	//\plus2, 0,
	\amp, 0.5,
	\angle, 120,
	\theta, Pwhite(-20,20),
	\phi, Pwhite(-10,10,inf),
);
);
)



(
~pat2=Pdef(\b,
	Pbind(
	\instrument,\sin2,
		\dur, Pwrand2([0.51,0.3,0.56]*0.41,[0.3, rrand(0.0,1.0), 0.2].scramble,inf),
//	\dur, Pwrand2([0.51,0.3,0.56].scramble,[0.3, 0.5, 0.2],inf)*Pwrand2([0.28,0.31,0.42].scramble,[300,100,20],inf),
	//\dur, 0.8,
	\freq, 30.midicps,
		\freq, Pseq([30,40,40,30,30,40,[30,35,42].choose].scramble,inf).midicps,
	//\freq, Pwhite(10,17).midicps,
	//\freq, Prand([10,10,10,10,10,Pwhite(10,17,1)],inf).midicps,
		\multiple, Prand([0.01,0.1,0.6,0.2],inf)*Pwhite(3.0,180.0),
//	\freq, Pwhite(30,33).midicps,
	\decim, Pn(Pseries(300,100,400),inf),
	\decim, Prand([44100,44100,44100,44100,2300],inf),
	//	\decim, 44100,
	\splay, Prand([0.9,0.4,0.5,0.6,0.7,0.1,0],inf),
	\plus1, Pwrand2([0,2],[320,3],inf),
	\plus2, Pwrand2([0,2],[300,3],inf),
	//\plus2, 0,
	\amp, 0.5,
	\angle, 120,
	\theta, Pwhite(-20,20),
	\phi, Pwhite(-10,10,inf),
);
);
)


