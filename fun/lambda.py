#!/usr/bin/env python3

import sys
sys.setrecursionlimit(5000) # default = 1000

# COMBINATORS

I = lambda x: x                              # Identity/Idiot bird
K = lambda x: lambda y: x                    # Kestrel
KI = lambda x: lambda y: y                   # Kite
M = lambda x: x(x)                           # Mockingbird
B = lambda x: lambda y: lambda z: x(y(z))    # Bluebird
C = lambda x: lambda y: lambda z: x(z)(y)    # Cardinal
W = lambda x: lambda y: x(y)(y)              # Warbler
S = lambda x: lambda y: lambda z: x(z)(y(z)) # Starling

# CHURCH NUMERALS

zero   = lambda f: lambda x: x
once   = lambda f: lambda x: f(x)
twice  = lambda f: lambda x: f(f(x))
thrice = lambda f: lambda x: f(f(f(x)))

inc = lambda n: lambda f: lambda x: f(n(f)(x))
succ = inc
add = lambda m: lambda n: lambda f: lambda x: m(f)(n(f)(x))
mul = lambda m: lambda n: lambda f: m(n(f))
pow = lambda m: lambda n: n(m)
dec = lambda n: lambda f: lambda x: n(lambda g: lambda h: h(g(f)))(lambda u: x)(lambda u: u)
pred = dec
sub = lambda m: lambda n: m(prd)(n)
add = lambda m: lambda n: n(inc)(m)
mul = lambda m: lambda n: n(add(m))(zero)
pow = lambda m: lambda n: n(mul(m))(once)

one   = inc(zero) 
two   = inc(one)  
three = inc(two)  
four  = inc(three)
five  = inc(four) 
six   = inc(five) 
seven = inc(six)  
eight = inc(seven)
nine  = inc(eight)
ten   = inc(nine) 

# BOOLEANS

true  = lambda x: lambda y: x
false = lambda x: lambda y: y

l_and = lambda p: lambda q: p(q)(p)
l_or  = lambda p: lambda q: p(p)(q)
l_not = lambda p: p(false)(true)

ifThenElse = lambda p: lambda c: lambda a: p(a)(c)
isZero = lambda n: n(lambda x:false)(true)
leq = lambda m: lambda n: isZero(sub(m)(n))

# PAIRS

pair = lambda x: lambda y: lambda f: f(x)(y)
fst = lambda p: p(true)
snd = lambda p: p(false)
nil = lambda x: true
isNull = lambda p: p(lambda x: lambda y: false)

phi = lambda x: pair(snd(x))(inc(snd(x)))

dec = lambda n: fst(n(phi)(pair(zero)(zero)))

# RECURSION

fact = lambda n: isZero(one)(mul(n)(fact(dec(n)))) # note self-reference

Y = lambda f: (lambda x: f(x(x)))(lambda x: f(x(x))) # beware eager evaluation

lazyY = lambda f: (lambda x: f(lambda: x(x)))(lambda x: f(lambda: x(x))) # thunking

lazyFact = lambda cont: lambda n: 1 if n == 0 else n*cont()(n-1) # CPS
#lazyFact = lambda cont: lambda n: isZero(n)(one)(mul(n)(cont()(dec(n))))

# HELPER FUNCTIONS

churchToInt = lambda n: n(lambda x: x + 1)(0)

print(lazyY(lazyFact)(5))

