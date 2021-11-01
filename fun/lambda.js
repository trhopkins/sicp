#!/usr/bin/node

// COMBINATORS

I = x => x                    // Identity/Idiot bird
K = x => y => x               // Kestrel
KI = x => y => y              // Kite
M = x => x(x)                 // Mockingbird
B = x => y => z => x(y(z))    // Bluebird
C = x => y => z => x(z)(y)    // Cardinal
W = x => y => x(y)(y)         // Warbler
V = x => y => z => z(x)(y)    // Vireo
S = x => y => z => x(z)(y(z)) // Starling

// CHURCH NUMERALS

zero   = f => x => x
once   = f => x => f(x)
twice  = f => x => f(f(x))
thrice = f => x => f(f(f(x)))

succ = n => f => x => f(n(f)(x))
inc = succ
add = m => n => f => x => m(f)(n(f)(x))
mul = m => n => f => x => m(n(f))
pow = b => e => e(b)
pred = n => f => x => n(g => h => h(g(f)))(u => x)(u => u) // doublecheck?
dec = pred
sub = m => n => m(pred)(n)

one   = succ(zero)
two   = succ(one)
three = succ(two)
four  = succ(three)
five  = succ(four)
six   = succ(five)
seven = succ(six)
eight = succ(seven)
nine  = succ(eight)
ten   = succ(nine)

// BOOLEANS

truth = x => y => x
falsehood = x => y => y
and = p => q => p(q)(p)
or = p => q => p(p)(q)
not = p => p(falsehood)(truth)
// not = p => C(p)
eq = p => q => p(q)(not(q))
ifThenElse = p => c => a => p(c)(a)
isZero = n => n(x => falsehood)(truth)
lessEq = m => n => isZero(sub(m)(n))

// PAIRS

cons = l => r => f => f(l)(r)
car = p => p(truth)
cdr = p => p(falsehood)
nil = x => truth
isNul = p => p(x => y => falsehood)
phi = x => cons(cdr(x))(inc(cdr(x)))
dec = n => car(n(phi)(cons(zero)(zero)))

// RECURSION

Y = f => (x => f(x(x)))(x => f(x(x))) // Y g = g(Y g)
lazyY = f => (x => f(_ => x(x)))(x => f(_ => x(x))) // thunk return values
lazyFact = cont => n => n == 0 ? 1 : n * cont()(n-1) // CPS
churchFact = cont => n => isZero(n)(one)(mul(n)(cont()(dec(n))))

crazyFact = cont => n => isZero(n)(_ => one)(_ => mul(n)(cont()(dec(n)))())

// HELPER FUNCTIONS

churchToInt = n => n(x => x+1)(0)
console.log(lazyY(churchFact)(five))
console.log(lazyY(lazyFact)(5))

