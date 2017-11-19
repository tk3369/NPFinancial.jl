# NPFinancial.jl Documentation

## Functions

```@docs
pv(rate, nper, pmt, fv = 0.0, when = :end)
fv(rate, nper, pmt, pv, when = :end)
pmt(rate, nper, pv, fv = 0.0, when = :end)
nper(rate, pmt, pv, fv = 0.0, when = :end)
ipmt(rate, per, nper, pv, fv = 0.0, when = :end)
ppmt(rate, per, nper, pv, fv = 0.0, when = :end)
rate(nper, pmt, pv, fv, when=:end, guess=0.1, tol=1e-6, maxiter=100)
npv(rate, values)
irr(values)
mirr(values, finance_rate, reinvest_rate)
```

## Index

```@index
```

