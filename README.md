# NPFinancial

[![Build Status](https://travis-ci.org/tk3369/NPFinancial.jl.svg)](https://travis-ci.org/tk3369/NPFinancial.jl)
[![codecov.io](http://codecov.io/github/tk3369/NPFinancial.jl/coverage.svg?branch=master)](http://codecov.io/github/tk3369/NPFinancial.jl?branch=master)
[![Latest](https://img.shields.io/badge/docs-latest-blue.svg)](https://tk3369.github.io/NPFinancial.jl/latest/index.html)

NPFinancial.jl is a port of the NumPy's 
[financial](https://docs.scipy.org/doc/numpy/reference/routines.financial.html) module.

Documentation of NPFinancial can be found at
https://tk3369.github.io/NPFinancial.jl/latest/index.html

### Notes

This library does not implement any array broacasting feature as in 
NumPy's implementation. Instead, Julia has its own broadcasting feature 
so users of this library are encouraged to _do it the right way_.
