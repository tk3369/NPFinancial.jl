# NPFinancial.jl

[![Build Status](https://github.com/tk3369/NPFinancial.jl/workflows/CI/badge.svg)](https://github.com/tk3369/NPFinancial.jl/actions?query=workflow%3ACI)
[![codecov.io](http://codecov.io/github/tk3369/NPFinancial.jl/coverage.svg?branch=master)](http://codecov.io/github/tk3369/NPFinancial.jl?branch=master)
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://tk3369.github.io/NPFinancial.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://tk3369.github.io/NPFinancial.jl/dev)


NPFinancial.jl is a port of the NumPy's
[financial](https://docs.scipy.org/doc/numpy/reference/routines.financial.html) module.

Documentation of NPFinancial can be found at
https://tk3369.github.io/NPFinancial.jl/latest/index.html

## Installation

```
] add https://github.com/tk3369/NPFinancial.jl
```

## Notes

This library does not implement any array broadcasting feature as in
NumPy's implementation. Instead, Julia has its own broadcasting feature
so users of this library are encouraged to _do it the right way_.
