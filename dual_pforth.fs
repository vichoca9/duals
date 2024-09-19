FVARIABLE reg1
FVARIABLE reg2

: MAKE-DUAL ( f: a b -- dual )
;

: DUAL ( f: a b -- f: b )
	fswap fdrop
;

: REAL ( f: a b -- f: a)
	fdrop
;

: f-rot ( f: a b c -- c a b )
	frot frot
;

: ftuck ( f: a b c -- a c b c)
	fswap fover
;

: DUAL-SWAP ( f: a1 b1 a2 b2 -- f: a2 b2 a1 b1 )
	frot reg2 f!
	frot reg2 f@
;

: DUAL-DUP
	fover fover
;

: DUAL-CONJ
	fnegate
;

: DUAL+ ( f: a1 b1 a2 b2 -- f: d3 )
	frot f+ f-rot f+ fswap
;

: DUAL- ( f: a1 b1 a2 b2 -- f: d3 )
	fnegate fswap fnegate fswap dual+ 
;

: DUAL* ( f: a1 b1 a2 b2 -- f: dual3 ) ( d1*d2 = a1a2 + a1b2+b1a2_e )
	4 fpick f* reg1 f!	( a1b2 )
	fswap fover f*		( a2b1 )
	f-rot f* 
	fswap reg1 f@ f+
;

: DUAL*K ( f: a1 b1 k -- k*a1 k*b1 )
	ftuck f* f-rot f* fswap
;

: DUAL/ ( f: a1 b1 a2 b2 -- f: dual3 ) ( d1/d2 = d1 x d2* / real_d2^2 )
	fover fdup f* dual*k dual-conj dual*
;

: DUAL-EXP_E ( f: d_dual -- 1e0 d_dual )
	1e0 fswap
;

: fexp
	2718281828e-9 fswap f**
;

: DUAL-EXP ( f: a1 b1 -- e^a1 e^a1*b1 )
	fswap fexp fdup frot f*
;
