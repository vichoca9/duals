FVARIABLE reg1
FVARIABLE reg2

\ short version uses stack, long version uses pointers

: make-dl ( f: a b -- dual )
;

: dl ( f: a b -- f: b )
	fswap fdrop
;

: dl-real ( f: a b -- f: a)
	fdrop
;

: f-rot ( f: a b c -- c a b )
	frot frot
;

: ftuck ( f: a b c -- a c b c)
	fswap fover
;

: dlswap ( f: a1 b1 a2 b2 -- f: a2 b2 a1 b1 )
	frot reg2 f!
	frot reg2 f@
;

: dldup
	fover fover
;

: dlconj
	fnegate
;

: dl+ ( f: a1 b1 a2 b2 -- f: d3 )
	frot f+ f-rot f+ fswap
;

: dl- ( f: a1 b1 a2 b2 -- f: d3 )
	fnegate fswap fnegate fswap dl+ 
;

: dl* ( f: a1 b1 a2 b2 -- f: dual3 ) ( d1*d2 = a1a2 + a1b2+b1a2_e )
	4 fpick f* reg1 f!	( a1b2 )
	fswap fover f*		( a2b1 )
	f-rot f* 
	fswap reg1 f@ f+
;

: dl*K ( f: a1 b1 k -- k*a1 k*b1 )
	ftuck f* f-rot f* fswap
;

: dl/ ( f: a1 b1 a2 b2 -- f: dual3 ) ( d1/d2 = d1 x d2* / real_d2^2 )
	fover fdup f* dl*k dlconj dl*
;

: dlexp_d ( f: d_dual -- 1e0 d_dual )
	1e0 fswap
;

: fexp
	 fdup fsinh fswap fcosh f+
;

: dlexp ( f: a1 b1 -- e^a1 e^a1*b1 )
	fswap fexp fdup frot f*
;

: dlln ( f : a1 b1 -- ln[a1] b/a )
	fover f/ fswap fln fswap
;

: dlcos ( f: a1 b1 -- cos[a] -b*sin[a] )
	fover fsin fswap fnegate f* fswap fcos fswap
;

: dlsin ( f: a1 b1 -- sin[a]  b*cos[a] )
	fover fcos fswap f* fswap fsin fswap
;

: dltan ( f: a1 b1 -- tan[a] b*[1+tan2[a]] )
	fswap ftan fswap fover fdup f* 1e0 f+ f*
;

: dlsinh ( f: a b -- sinh[a] b*cosh[a] )
	fover fcosh f* fswap fsinh fswap
;

: dlcosh ( f: a b -- cosh[a] b*sinh[a] )
	fover fsinh f* fswap fcosh fswap
;

: dltanh ( f: a b -- tanh[a] b/cosh^2[a] )
	fover fcosh fdup f* f/
	fswap ftanh fswap
;

: dl** ( f: dl1 dl2 -- dl1^dl2 = [e^[ln[dl1]*dl2]] )
	dlswap dlln dl* dlexp
;

: dlacos ( f: a1 b1 -- acos[a] -b/sqrt[1-a*a] ) 
	fnegate fover fdup f* fnegate 1e0 f+ fsqrt f/ 
	fswap facos fswap
;

: dlasin ( f: a1 b1 -- asin[a] b/sqrt[1-a*a] )
	fover fdup f* fnegate 1e0 f+ fsqrt f/ 
	fswap fasin fswap
;

: dlatan ( f: a1 b1 -- atan[a] b/[1+a^2] )
	fover fdup f* 1e0 f+ f/ fswap fatan fswap
;

: dlasinh ( f: a1 b1 -- asinh[a] b/sqrt[1+a*a] )
	fover fdup f* 1e0 f+ fsqrt f/ 
	fswap fasinh fswap
;

: dlacosh ( f: a1 b1 -- acosh[a] b/sqrt[a*a-1] )
	fover fdup f* -1e0 f+ fsqrt f/ 
	fswap facosh fswap
;

: dlatanh ( f: a1 b1 -- atanh[a] b/[1-a*a] )
	fover fdup f* fnegate 1e0 f+ f/
	fswap fatanh fswap
;

\ TODO: add pointer long versions! Use REAL and DUAL together to get em
\	Maybe add a GETDUAL and use stacked versions?

: display-dl ( f: a1 b1 -- "a+bd")
	fswap f. 43 emit space f. 100 emit 
;
