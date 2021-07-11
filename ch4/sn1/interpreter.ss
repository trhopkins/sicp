;;; Metacircular evaluator, pages 362-398

;; EVAL/APPLY

(define (eval exp env) ; beware, shadows underlying eval
  (cond
    ((self-evaluating? exp)
      exp)
    ((variable? exp)
      (lookup-variable-value exp))
    ((quoted? exp)
      (text-of-quotation exp))
    ((assignment? exp)
      (eval-assignment exp env))
    ((definition? exp)
      (eval-definition exp env))
    ((if? exp)
      (eval-if exp env))
    ((lambda? exp)
      (make-procedure (lambda-parameters exp)
                      (lambda-body exp)
                      env))
    ((begin? exp)
      (eval-sequence (begin-actions exp) env))
    ((cond? exp)
      (eval (cond->if exp) env))
    ((application? exp)
      (apply (eval (operator exp) env)
             (list-of-values (operands exp) env)))
    (else
      (error "Unknown expression type -- EVAL" exp))))

(define apply-in-underlying-scheme apply) ; save reference to original

(define (apply procedure arguments) ; beware, shadows underlying apply
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
      (error "Unknown procedure type -- APPLY" apply))))

;; PROCEDURE ARGUMENTS

(define (list-of-values exps env) ; evaluate arguments to a function
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

;; CONDITIONALS

(define (eval-if exp env) ; normal order special form
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

;; SEQUENCES

(define (eval-sequence exps env) ; compound expression parser
  (if (last-exp? exps)
      (eval (first-exp exps) env) ; returns final expression value
      (eval-sequence (rest-exps exps) env)))

;; ASSIGNMENTS AND DEFINITIONS

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (eval (assignment-value exp) env)
                       env)
  'ok) ; I guess it has to return something

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (eval (definition-value env)
                          env)
                    env)
  'ok) ; I guess it has to return something

;; EXPRESSIONS

(define (self-evaluating? exp) ; slightly changed. See page 369
  (or (number? exp)
      (string? exp))) ; notably excludes booleans, which are globally defined

(define (variable? exp) ; rewrite to one-liner?
  (symbol? exp))

(define (tagged-list? exp tag) ; essentially a type wrapper check
  (and (pair? exp) ; slightly changed. See page 369
       (eq? tag (car exp))))

(define (quoted? exp)
  (tagged-list? exp 'quote))

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
      (make-lambda (cdadr exp) ; formal parameters
                   (cddr exp)))) ; body

;; LAMBDAS

(define (lambda? exp)
  (tagged-list? exp 'lambda))

(define (lambda-parameters exp)
  (cadr exp))

(define (lambda-body exp)
  (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda
        (cons parameters
              body)))

;; IFS

(define (if? exp)
  (tagged-list? exp 'if))

(define (if-predicate exp)
  (cadr exp))

(define (if-consequent exp)
  (caddr exp))

(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      '#f))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

;; BEGINS

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

;; APPLICATIONS

(define (application? exp)
  (pair? exp)) ; could be more robust?

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

;; DERIVED EXPRESSIONS

;; TODO: implement let from exercises

;; CONDS

(define (cond? exp)
  (tagged-list? exp 'cond))

(define (cond-clauses exp)
  (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause)
  (car clause))

(define (cond-actions clause)
  (cdr clause)) ; cound be a sequence

(define (cond->if exp) ; deriving cond from nested ifs
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses) ; base case
      '#f
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF" clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first)) ; typical element
                     (expand-clauses rest)))))) ; natural recursion

;; PREDICATES

(define (true? x) ; truthy langauge
  (not (false? x)))

(define (false? x)
  (or (eq? x #f)
      (eq? x false)))

;; PROCEDURES

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

;; ENVIRONMENTS

(define (first-frame env)
  (car env))

(define (enclosing-environment env)
  (cdr env))

(define the-empty-environment '())

;; frame = pair of lists, variables and values

(define (make-frame variables values)
  (cons variables
        values))

(define (frame-variables frame)
  (car frame))

(define (frame-values frame)
  (cdr frame))

(define (add-binding-to-frame! var val frame) ; mutable change
  (set-car! frame (cons var (car frame))) ; note: set-car! is unique to Scheme
  (set-cdr! frame (cons val (car frame)))) ; note: set-cdr! is unique to Scheme

(define (extend-environment vars vals base-env) ; temporary extension
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (error "mismatched number of arguments" vars vals)))

(define (lookup var env) ; retrieve value of variable
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
        (error "unbound variable -- LOOKUP" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define lookup-variable-value lookup) ; shadow for convenience. REMOVE?

(define (set-variable-value! var val env) ; mutable change
  (define (env-loop env)
    (define (scan vars vals)
      (cond
        ((null? vars)
          (env-loop (enclosing-environment env)))
        ((eq? var (car vars))
          (set-car! vals val))
        (else
          (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env) ; mutable
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond
        ((null? vars)
          (add-binding-to-frame! var val frame))
        ((eq? var (car vars))
          (set-car! vals val))
        (else
          (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

;; PRIMITIVES

(define (setup-environment) ; add primitives to initially-empty environment
  (let ((initial-env (extend-environment
                       (primitive-procedure-names)
                       (primitive-procedure-objects)
                       the-empty-environment)))
    (define-variable! '#t #t initial-env) ; defined here rather than in self-evaluating forms?
    (define-variable! 'true true initial-env)
    (define-variable! '#f #f initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define the-global-environment (setup-environment))

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (primitive-implementation proc)
  (cadr proc))

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list 'eq? eq?)
        <etc etc, more all primitives here>))

(define (primitive-procedure-names)
  (map car
       primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc)
         (list 'primitive (cadr proc)))
       primitive-procedures))

(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme ; primitives are innately defined in implementation langauge
    (primitive-implementation proc) args))

;; REPL

(define input-prompt ";;; M-eval input:")

(define output-prompt ";;; M-eval value:")

(define (driver-loop) ; read-eval-print-loop
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

(define (prompt-for-input string)
  (newline)
  (newline)
  (display string)
  (newline))

(define (announce-output string)
  (newline)
  (display string)
  (newline))

(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))

