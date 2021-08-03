

NEURON {
	SUFFIX SynExp
	USEION nmda READ enmda WRITE inmda VALENCE 2.0
	RANGE onset, tau, gmax,B,enmda,inmdaC, r, r0, r1, lastrelease,TimeCount,rinf,rtau,gnmda
	GLOBAL Cmax, Cdur,alpha,beta,T, Deadtime
	:RANGE alpha,beta,T
	:NONSPECIFIC_CURRENT i
}

INDEPENDENT {t FROM 0 TO 100 WITH 1 (ms)}

UNITS {
	(pA) = (picoamp)
	(mV) = (millivolt)
	(nS) = (nanosiemens)
	(mM) = (milli/liter)
}

PARAMETER {
     dt		(ms)
	Deadtime = 1	(ms)		: mimimum time between release events
	Cmax	= 1	(mM)		: max transmitter concentration
	Cdur	= 1	(ms)		: transmitter duration (rising phase)
		 
	gmax=1.1
	enmda	= 0	         (mV)		: reversal potential
	mg	= 1              (mM)		: external magnesium concentration
	onset=100            (ms)
	:delay =500          (ms)
	alpha=0.072      <0,1e4>         
	beta=0.0066
	T=1
	
	tau=90
	
	}

ASSIGNED {
	v		    (mV)	
	B		        : magnesium block
	
	:ica		    (nA)	
    gnmda
	inmda
	rinf
    rtau 
    C		(mM)		: transmitter concentration
	r				: fraction of open channels
	r0				: open channels at start of release
	r1				: open channels at end of release
lastrelease	(ms)		: time of last spike
TimeCount	(ms)		: time counter
		
}


BREAKPOINT {
    SOLVE release
   
    B = mgblock(v)		: B is the block by magnesium at this voltage
	if (gmax) { at_time(onset) }
	gnmda = gmax * alp( (t - onset)/tau )
	inmda = gnmda*B*(v - enmda)* r
:	inmda=ica
}

FUNCTION alp(x) {
	if (x < 0 || x > 10) {
		alp = 0
	}else{
		alp =  exp(1 - x)
	}
}



FUNCTION mgblock(v(mV)) {
	TABLE 
	DEPEND mg
	FROM -140 TO 80 WITH 1000

	mgblock = 1 / (1 + exp(0.062 (/mV) * -v) * (mg / 3.57 (mM)))

}


INITIAL {
    r = 0
	C = 0
	rinf = Cmax*alpha / (Cmax*alpha + beta)
	rtau = 1 / ((alpha * Cmax) + beta)
	lastrelease = -1000
	r1=0
	TimeCount=-1

}

PROCEDURE release() {

  


	:will crash if user hasn't set pre with the connect statement 

	TimeCount=TimeCount-dt			: time since last release ended

						: ready for another release?
	if (TimeCount < -Deadtime) {
			C = Cmax		
			r0 = r
			lastrelease = t
			TimeCount=Cdur
		}
						
	
	else if (C == Cmax) {		
		r1 = r
		C = 0.
	}



	if (C > 0) {				: transmitter being released?

	   r = rinf + (r0 - rinf) * exptable (- (t - lastrelease) / rtau)
				
	} else {				: no release occuring

  	   r = r1 * exptable (- beta * (t - (lastrelease + Cdur)))
	}

	
}
FUNCTION exptable(x) { 
	TABLE  FROM -10 TO 10 WITH 2000

	if ((x > -10) && (x < 10)) {
		exptable = exp(x)
	} else {
		exptable = 0.
	}
}

FUNCTION duale(x,y) {
	if (x < 0 || y < 0) {
		duale = 0
	}else{
		duale = exp(-x) - exp(-y)
	}
}

























