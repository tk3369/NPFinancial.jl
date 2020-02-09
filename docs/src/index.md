# Functions

```@contents
```

## Present/Future Value
```@docs
pv(rate, nper, pmt, fv = 0.0, when = :end)
fv(rate, nper, pmt, pv, when = :end)
npv(rate, values)
```

## Payments

```@docs
ipmt(rate, per, nper, pv, fv = 0.0, when = :end)
ppmt(rate, per, nper, pv, fv = 0.0, when = :end)
```

## Rates

```@docs
rate(nper, pmt, pv, fv, when=:end, guess=0.1, tol=1e-6, maxiter=100)
irr(values)
mirr(values, finance_rate, reinvest_rate)
```

## Miscellaneous

```@docs
nper(rate, pmt, pv, fv = 0.0, when = :end)
```
