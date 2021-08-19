;;; Metacircular evaluator

;; EVALUATION

(define (eval exp env)
  (cond
    ((self-evaluating? exp)
      exp)
    ((variable? exp)
      (lookup-variable-value exp env))
    ((quoted? exp)
      (text-of-quotation exp))
    ((assignment? exp)
      (eval-assignment exp env))
    ((definition? exp)
      (eval-definition exp env))
    ((if? exp)
      (eval-if exp env))
    ((lambda? exp)
      (make-procedure
	(lambda-parameters exp)
	(lambda-body exp)
	env))
    ((begin? exp)
      (eval-sequence
	(begin-actions exp)
	env))
    ((cond? exp)
      (eval (cond->if exp) env))
    ((application? exp)
      (apply (eval (operator exp) env)
	     (list-of-values (operands exp) env)))
    (else
      (error "Unknown expression type -- EVAL" exp))))

;; APPLICATION

(define (apply procedure arguments)
  (cond
    ((primitive-procedure? procedure)
      (apply-primitive-procedure procedure arguments))
    ((compound-procedure? procedure)
      (eval-sequence
	(procedure-body procedure)
	(extend-environment
	  (procedure-parameters procedure)
	  arguments
	  (procedure-environment procedure))))
    (else
      (error "Unknown procedure type -- APPLY" procedure))))

;; PROCEDURE ARGUMENTS

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
	    (list-of-values (rest-operands exps) env))))

;; CONDITIONALS

(define (eval-if exp env)
  (if (true? (eval (if-predicaet exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

;; SEQUENCES

(define (eval-sequence exps env) ; definition with if statement
  (if (last-exp? exps)
      (eval (first-exp exps) env)
      (begin
	(eval (first-exps) env)
	(eval-sequence (rest-exps exps) env))))

#;(define (eval-sequence exps env) ; book's definition
  (cond
    ((last-exp? exps)
      (eval (first-exp exps) env))
    (else
      (eval (first-exps) env)
      (eval-sequence (rest-exps exps) env))))

;; ASSIGNMENTS

(define (eval-assignment exp env)
  (set-variable-value!
    (assignment-variable exp)
    (eval (assignment-value exp) env)
    env)
  'ok) ; needs to return something?

;; DEFINITIONS

(define (eval-definition exp env)
  (define-variable!
    (definition-variable exp)
    (eval (definition-value exp) env)
    env)
  'ok)

;; REPRESENTING EXPRESSIONS

(define (tagged-list? exp tag) ; consider shortening
  (and (pair? exp)
       (eq? tag (car exp))))

(define (variable? exp)
  (symbol? exp))

(define (self-evaluating? exp)
  (cond
    ((number? exp)
      #t) ; consider replacing with 'true
    ((string? exp)
      #t)
    (else
      #f)))

;; QUOTATIONS

(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp)
  (cadr exp))

;; ASSIGNMENTS

(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp)
  (cadr exp))

(define (assignment-value exp)
  (caddr exp))

;; DEFINITIONS

(define (definition? exp)
  (tagged-list? exp 'define))

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
		   (cddr exp))))

;; LAMBDA EXPRESSIONS

(define (lambda? exp)
  (tagged-list? exp 'lambda))

(define (lambda-parameters exp)
  (cadr exp))

(define (lambda-body exp)
  (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda ; should be list?
	(cons parameters
	      body)))

;;CONDITIONALS

(define (if? exp)
  (tagged-list? exp 'if))

(define (if-predicate exp)
  (cadr exp))

(define (if-consequent exp)
  (caddr exp))

(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false)) ; not certain if this should be #f or 'false

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative)) ; should be cons?

;; BEGIN STATEMENTS

(define (begin? exp)
  (tagged-list? exp 'begin))

(define (begin-actions exp)
  (cdr exp))

(define (last-exp? seq)
  (null? (cdr seq)))

(define (first-exp seq)
  (car seq))

(define (rest-exps seq)
  (cdr seq))

(define (sequence->exp seq)
  (cond
    ((null? seq)
      seq)
    ((last-exp? seq)
      (first-exp seq))
    (else
      (make-begin seq))))

(define (make-begin seq)
  (cons 'begin
	seq))

;; PROCEDURE APPLICATIONS

(define (application? exp)
  (pair? exp))

(define (operator exp)
  (car exp))

(define (operands exp)
  (cdr exp))

(define (no-operands? ops)
  (null? ops))

(define (first-operand ops)
  (car ops))

(define (rest-operands ops)
  (cdr ops))

;; COND DERIVED FROM IFS

(define (cond? exp)
  (tagged-list? exp 'cond))

(define (cond-clauses exp)
  (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause)
  (car clause))

(define (cond-actions clause)
  (cdr clause))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
	    (rest (cdr clauses)))
	(if (null? rest)
	    (sequence->exp (cond-actions first))
	    (error "ELSE clause isn't last -- COND->IF" clauses))
	(make-if (cond->predicate first)
		 (sequence->exp (cond-actions first))
		 (expand-clauses rest)))))

;; TESTING PREDICATES

(define (true? x)
  (not (eq? x false))) ; truthy

(define (false? x)
  (eq? x false))

;; REPRESENTING PROCEDURES

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))

(define (procedure-parameters p)
  (cadr p))

(define (procedure-body p)
  (caddr p))

(define (procedure-environment p)
  (cadddr p))

;; OPERATIONS ON ENVIRONMENTS

(define (enclosing-environment env)
  (cdr env))

(define (first-frame env)
  (car env))

(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables
	values))

(define (frame-variables frame)
  (car frame))

(define (frame-values frame)
  (cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var
			(car frame)))
  (set-cdr! frame (cons val
			(cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals)
	    base-env)
      (if (< (length vars) (length vals))
	  (error "Too many arguments supplied" vars vals)
	  (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond
	((null? vars)
	  (env-loop (enclosing-environment env)))
	((eq? var (car vars))
	  (car vals))
	(else
	  (scan (cdr vars)
		(cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
	(let ((frame (first-frame env)))
	  (scan (frame-variables frame)
		(frame-values frame)))))
  (env-loop env))
