; scheme version R5RS - tinyscheme
; FIXME - add checks for types in all of this!!!
(define (make-dual a b) (vector a b) )
(define (dl-real dl) (vector-ref dl 0) )
(define (dl-dual dl) (vector-ref dl 1) )

(define (dual? dl) (vector? dl))

(define (dl-conj dl1)
	(make-dual (dl-real dl1) (- (dl-dual dl1)) )
)

(define (dl_f f dl1 dl2 )
	(f (dl-real dl1) (dl-dual dl1)  
		(dl-real dl2) (dl-dual dl2) 
	)
)

(define (dl_apply dl_op dl_opv2 dl1 lst)
	(if (null? lst) dl1
		(apply dl_op (dl_opv2 dl1 (car lst)) (cdr lst))
	)
)

(define (square x)
	(* x x)
)
; ##### sum
; sum virtual func
(define (dl+_v a1 b1 a2 b2) 
	(make-dual (+ a1 a2) (+ b1 b2))
)
; sum apply
(define (dl+ dl1 dl2)
	(dl_f dl+_v dl1 dl2)
)

;(define (dl+ dl1 . lst )
;	(dl_apply dl+ dl+_v2 dl1 lst)
;) 
; ##### sum

; ##### sub
; sub virtual func
(define (dl-_v a1 b1 a2 b2) 
	(make-dual (- a1 a2) (- b1 b2))
)
; sub apply
(define (dl- dl1 dl2)
	(dl_f dl-_v dl1 dl2)
)

;(define (dl- dl1 . lst )
;	(dl_apply dl- dl-_v2 dl1 lst)
;)
; ##### sub

; ##### mul
(define (dl*_v a1 b1 a2 b2)
	(make-dual (* a1 a2 ) (+ (* a1 b2) (* b1 a2)))
)

(define (dl* dl1 dl2)
	(dl_f dl*_v dl1 dl2)
)

;(define (dl* dl1 . lst )
;	(dl_apply dl* dl*_v2 dl1 lst)
;)
; ##### mul

; ##### scalar_mul
(define (dl*k_v a1 b1 k)
	(make-dual (* a1 k) (* b1 k))
)

(define (dl*k dl1 k)
	(dl*k_v (dl-real dl1) (dl-dual dl1) k)
)
; #### scalar mul

; ##### scalar_div
(define (dl/k_v a1 b1 k)
	(make-dual (/ a1 k) (/ b1 k))
)

(define (dl/k dl1 k)
	(dl/k_v (dl-real dl1) (dl-dual dl1) k)
)
; #### scalar div

; ##### div
; div uses mul!! --> SLOW

(define (dl/_v a1 b1 a2 b2 c)
	(make-dual (/ (* a1 b2) c) 
		(/ (- (* b1 a2) (* a1 b2)) c)
	)
)
;inline all operations!!
(define (dl/ dl1 dl2)
	(dl/_v (dl-real dl1) (dl-dual dl1) 
		(dl-real dl2) (dl-dual dl2) (square (dl-real dl2)))
)

;(define (dl/ dl1 . lst )
;	(dl_apply dl/ dl/_v2 dl1 lst)
;)
; ##### div

; ##### exp
(define (dlexp dl1)
	(dl*k (make-dual 1 (dl-dual dl1)) (exp (dl-real dl1)))  
)
; ##### exp

; ##### log
( define (dllog dl1)
	(make-dual (log (dl-real dl1)) 
		(/ (dl-dual dl1) (dl-real dl1)) 
	)
)
; ##### log

; ##### sin
(define (dlsin dl1)
	(make-dual (sin (dl-real dl1)) 
		(* (dl-dual dl1) (cos (dl-real dl1)) )
	)
)
; ##### sin

; ##### cos
(define (dlcos dl1)
	(make-dual (cos (dl-real dl1)) 
		(* -1.0 (dl-dual dl1) (sin (dl-real dl1)) )
	)
)
; ##### cos

; ##### tan
(define (dltan dl1)
	(make-dual (tan (dl-real dl1)) 
		(* (dl-dual dl1) 
			(+ 1.0 
				(square (tan (dl-real dl1)))
			) 
		)
	)
)
; ##### tan

; ##### sinh
(define (dlsinh dl1)
	(make-dual (sinh (dl-real dl1)) 
		(* (dl-dual dl1) (cosh (dl-real dl1))
		)
	)
)
; ##### sinh

; ##### cosh
(define (dlcosh dl1)
	(make-dual (cosh (dl-real dl1)) 
		(* (dl-dual dl1) (sinh (dl-real dl1))
		)
	)
)
; ##### cosh

; ##### tanh
(define (dltanh dl1)
	(make-dual (tanh (dl-real dl1)) 
		(/ (dl-dual dl1) 
			(square (cosh (dl-real dl1)))
		)
	)
)
; ##### tanh

; ##### asin
(define (dlasin dl1)
	(make-dual (asin (dl-real dl1)) 
		(/ (dl-dual dl1) 
			(sqrt 
				(- 1 (square (dl-real dl1)))
		)
	)
)
; ##### asin

; ##### acos
(define (dlacos dl1)
	(make-dual (acos (dl-real dl1)) 
		(/ (- (dl-dual dl1)) 
			(sqrt 
				(- 1 (square (dl-real dl1)))
		)
	)
)
; ##### acos

; ##### atan
(define (dlatan dl1)
	(make-dual (atan (dl-real dl1)) 
		(/ (dl-dual dl1) 
			(+ 1 (square (dl-real dl1)))
	)
)
; ##### atan

; ##### asinh
(define (dlasinh dl1)
	(make-dual (asinh (dl-real dl1)) 
		(/  (dl-dual dl1) 
			(sqrt 
				(+ 1 (square (dl-real dl1)))
		)
	)
)
; ##### asinh

; ##### acosh
(define (dlacosh dl1)
	(make-dual (acosh (dl-real dl1)) 
		(/  (dl-dual dl1) 
			(sqrt 
				(- (square (dl-real dl1)) 1)
		)
	)
)
; ##### acosh

; ##### atanh
(define (dlatanh dl1)
	(make-dual (atanh (dl-real dl1)) 
		(/  (dl-dual dl1) 
			(- 1 (square (dl-real dl1))
		)
	)
)
; ##### atanh

; ##### expt 
(define (dlexpt dl1 dl2)
	(dlexp (dl* (dllog dl1) dl2))
)
; ##### expt
