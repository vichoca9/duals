; time returns C clock()
(define CLOCKS_PER_SEC 1000000 )
(define (out) (open-output-file "results_scheme.txt"))

(define (difftime a b)
	(/ (- b a) CLOCKS_PER_SEC)
)
(define (difftime-ms a b)
	(* (difftime a b) 1000)
)

; ignore results!
(define (void f) 
	(list? (list (f)))
)

(define (bench f ) 
	(list (time) (void f) (time))
)

(define (results lst)
	(difftime-ms (car lst) (caddr lst))
)

(define (benchmark f)
	(results (bench f))
)

(define (write-res t outfile)
	(begin
		(write t outfile)
		(newline outfile)
	)
)

(define (write-result t)
	(begin
		(write-res t (out))
		(newline (out))
	)
)

(define (write-bench f)
	(write-result (benchmark f))
)

(define (close-res outfile)
	(close-output-port outfile)
)

(load "dual.scm")

(define (test1 dl1 f)
	(lambda () (f dl1))
)

(define (test2 dl1 dl2 f)
	(lambda () (f dl1 dl2))
)

; do test 10000 times
(define NTEST 10000)
; holy moly my mind is spinning...
(define (repeat-test f)
	(do ((n 1 (+ n 1)) (v 0 (+ v (benchmark f))))
		((= n NTEST) (/ v NTEST))
		(+ v 0)
	)
)

(define (do-tests dl1 dl2 outfile)
	(list
		(write-res (repeat-test (test2 dl1 dl2 dl+)) outfile)
		(write-res (repeat-test (test2 dl1 dl2 dl-)) outfile)
		(write-res (repeat-test (test2 dl1 dl2 dl*)) outfile)
		(write-res (repeat-test (test2 dl1 dl2 dl/)) outfile)
		(write-res (repeat-test (test1 dl1 dlsin)) outfile)
		(close-res outfile)
	)
)

(display "Doing tests...\n")
(do-tests (make-dual 1.0 1.0) (make-dual 1.0 0.0) (out)) 
(display "Test written at: results-scheme.txt\n")
