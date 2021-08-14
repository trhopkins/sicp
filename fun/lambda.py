#!/usr/bin/env python3

# CHURCH NUMERALS

zero   = lambda f: lambda x: x
once   = lambda f: lambda x: f(x)
twice  = lambda f: lambda x: f(f(x))
thrice = lambda f: lambda x: f(f(f(x))) # ...you get the idea

inc = lambda n: lambda f: lambda x: f(n(f)(x))
add = lambda m: lambda n: lambda f: lambda x: m(f)(n(f)(x))
mul = lambda m: lambda n: lambda f: m(n(f))
pow = lambda m: lambda n: n(m)
dec = lambda n: lambda f: lambda x: n(lambda g: lambda h: h(g(f)))(lambda u: x)(lambda u: u)
sub = lambda m: lambda n: m(prd)(n)
#add = lambda m: lambda n: n(inc)(m)
#mul = lambda m: lambda n: n(add(m))(zero)
#pow = lambda m: lambda n: n(mul(m))(once)

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
false = lambda x: lambda y: y # zero

l_and = lambda p: lambda q: p(q)(p)
l_or  = lambda p: lambda q: p(p)(q)
l_not = lambda p: p(false)(true)

ifthenelse = lambda p: lambda c: lambda a: p(a)(c)
iszero = lambda n: n(lambda x:false)(true)
leq = lambda m: lambda n: iszero(sub(m)(n))

# PAIRS

pair = lambda x: lambda y: lambda f: f(x)(y)
fst = lambda p: p(true)
snd = lambda p: p(false)
nil = lambda x: true
isnull = lambda p: p(lambda x: lambda y: false)

phi = lambda x: pair(snd(x))(inc(snd(x))) # pred helper function

dec = lambda n: fst(n(phi)(pair(zero)(zero))) # transparent predecessor

# RECURSION

fact = lambda n: iszero(one)(mul(n)(fact(dec(n))))

Y = lambda g: (lambda x: g(x(x)))(lambda x: g(x(x)))

# HELPER FUNCTIONS

churchToInt = lambda n: n(lambda x: x + 1)(0)

