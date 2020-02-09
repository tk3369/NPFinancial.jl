module NPFinancial

export fv, pmt, nper, ipmt, ppmt, pv, rate, irr, npv, mirr

using Polynomials: Poly, roots

# Internal functions

const _when_to_num = Dict(:begin => 1, :end => 0)

function _convert_when(when)
    return _when_to_num[when]
end

function _rbl(rate, per, pmt, pv, when)
    return fv(rate, (per - 1), pmt, pv, when)
end

"""
    fv(rate::Real, nper::Integer, pmt::Real, pv::Real, when = :end)

Compute the future value given the present value `pv`, an interest rate `rate` that
is compounded once per period, over `nper` number of periods. A fixed payment `pmt`
may be specified in the `when` argument, which is paid either at the beginning of
each period (`:begin`) or `:end` of the period.

# Examples
```
julia> fv(0.05, 1, 0, -100)
105.0

julia> fv(0.05, 2, 0, -100)
110.25
```
"""
function fv(rate::Real, nper::Integer, pmt::Real, pv::Real, when = :end)
    when = _convert_when(when)
    temp = (1+rate)^nper
    fact = rate == 0 ? nper : (1 + rate*when)*(temp - 1)/rate
    return -(pv * temp + pmt * fact)
end

"""
    pmt(rate::Real, nper::Integer, pv::Real, fv = 0.0, when = :end)

Compute the payment given the present value `pv`, an interest rate `rate` that
is compounded once per period, over `nper` number of periods, such that at the
end of the last period the value becomes `fv`. The payment is expected to be paid
at the beginning of each period (`:begin`) or `:end` of the period, as specified
in the `when` argument.

# Examples

Let's say I have need to repay a mortage loan with amount 300000 (present value)
with monthly interst rate of 4.25% over the next 30 years.  What would be my
monthly payment?
```
julia> pmt(0.0425/12, 30*12, 300000)
-1475.8196732384283
```
"""
function pmt(rate::Real, nper::Integer, pv::Real, fv = 0.0, when = :end)
    when = _convert_when(when)
    temp = (1 + rate).^nper
    mask = (rate == 0)
    masked_rate = mask ? 1 : rate
    fact = mask != 0 ? nper : (1 + masked_rate * when) * (temp - 1)/masked_rate
    return -(fv + pv * temp) / fact
end

"""
    nper(rate::Real, pmt::Real, pv::Real, fv = 0.0, when = :end)

Compute how many periods the present value `pv` may accrue/repaid till the future
value `fv` given a specific interest rate `rate` and a fixed payment `pmt`.
The payment is expected to be paid
at the beginning of each period (`:begin`) or `:end` of the period, as specified
in the `when` argument.
"""
function nper(rate::Real, pmt::Real, pv::Real, fv = 0.0, when = :end)
    when = _convert_when(when)
    if rate == 0
        return -(fv + pv) / pmt
    else
        z = pmt * (1 + rate * when) / rate
        return log((-fv+z) / (pv+z))/log(1+rate)
    end
end

"""
    ipmt(rate::Real, per::Integer, nper::Integer, pv::Real, fv = 0.0, when = :end)

Compute the interest component of the periodic payment.  This useful for any
loan that has a repayment schedule.

# Examples

Let's say I have need to repay a mortage loan with amount 300000 (present value)
with monthly interst rate of 4.25% over the next 30 years.  What would be the
interest component of my monthly payment?  Initially, the interest component is
a large part of the payment but towards the end, it would be a smaller portion
as illustrated below for periods 1, 2, 3, 358, 359, and 360:

```
julia> pmt(0.0425/12, 30*12, 300000)
-1475.8196732384283

julia> ipmt.(0.0425/12, [1,2,3,358,359,360], 30*12, 300000)
6-element Array{Float64,1}:
 -1062.5
 -1061.04
 -1059.57
   -15.5702
   -10.3984
    -5.20841
```
"""
function ipmt(rate::Real, per::Integer, nper::Integer, pv::Real, fv = 0.0, when = :end)
    #when = _convert_when(when)
    #rate, per, nper, pv, fv, when = np.broadcast_arrays(rate, per, nper, pv, fv, when)
    total_pmt = pmt(rate, nper, pv, fv, when)
    ipmt = _rbl(rate, per, total_pmt, pv, when)*rate
    ipmt = when == 1 ? ipmt/(1 + rate) : ipmt
    ipmt = (when == 1) && (per == 1) ? 0 : ipmt
    return ipmt
end

"""
    ppmt(rate, per, nper, pv, fv = 0.0, when = :end)

Compute the principal component of the periodic payment.  This useful for any
loan that has a repayment schedule.

# Examples

```
julia> pmt(0.0425/12, 30*12, 300000)
-1475.8196732384283

julia> ppmt.(0.0425/12, [1,2,3,358,359,360], 30*12, 300000)
6-element Array{Float64,1}:
  -413.32
  -414.784
  -416.253
 -1460.25
 -1465.42
 -1470.61
```
"""
function ppmt(rate::Real, per::Integer, nper::Integer, pv::Real, fv = 0.0, when = :end)
    total = pmt(rate, nper, pv, fv, when)
    return total - ipmt(rate, per, nper, pv, fv, when)
end

"""
    pv(rate::Real, nper::Integer, pmt::Real, fv = 0.0, when = :end)

Compute the present value given the future value `fv`, an interest rate `rate` and
a fixed periodic payment `pmt` over a number of periods `nper`.  The payment is
expected to be paid at the beginning of each period (`:begin`) or `:end` of the period,
as specified in the `when` argument.
"""
function pv(rate::Real, nper::Integer, pmt::Real, fv = 0.0, when = :end)
    when = _convert_when(when)
    temp = (1+rate)^nper
    fact = rate == 0 ? nper : (1+rate*when)*(temp-1)/rate
    return -(fv + pmt*fact)/temp
end

function _g_div_gp(r, n, p, x, y, w)
    t1 = (r+1)^n
    t2 = (r+1)^(n-1)
    return ((y + t1*x + p*(t1 - 1)*(r*w + 1)/r) /
                (n*t2*x - p*(t1 - 1)*(r*w + 1)/(r^2) + n*p*t2*(r*w + 1)/r +
                p*(t1 - 1)*w/r))
end

"""
    rate(nper::Integer, pmt::Real, pv::Real, fv::Real, when=:end, guess=0.1, tol=1e-6, maxiter=100)

Compute interest rate given present value `pv`, future value `fv`, and fixed periodic
payment `pmt` over a number of periods `nper`.

This implementation uses Newton's iteration until the change is less than 1e-6.
Newton's rule is

``r_{n+1} = r_{n} - \\frac{g(r_n)}{g'(r_n)}``

where
* g(r) is the formula
* g'(r) is the derivative with respect to r.

# Examples
```
julia> rate(1, 0, -100, 101)
0.010000000000000155
```
"""
function rate(nper::Integer, pmt::Real, pv::Real, fv::Real,
              when=:end, guess=0.1, tol=1e-6, maxiter=100)
    when = _convert_when(when)
    rn = guess
    iterator = 0
    close = false
    while (iterator < maxiter) && !close
        rnp1 = rn - _g_div_gp(rn, nper, pmt, pv, fv, when)
        diff = abs(rnp1-rn)
        close = diff < tol
        iterator += 1
        rn = rnp1
    end
    if !close
        # Return nan's in array of the same shape as rn
        return NaN + rn
    else
        return rn
    end
end

"""
     irr(values::Real)

Calculate internal rate of return given an array of cash flow `values`
(nearest one first)

# Examples
```
julia> irr([-100, 101])
0.010000000000000009
```
"""
function irr(values)
    res = roots(Poly(values))
    mask = map(x -> isa(x, Complex) ? x.im == 0 && x.re > 0 : x > 0, res)
    if !any(mask)
        return NaN
    end
    res = map(x -> isa(x, Complex) ? x.re : x, res[mask])
    rate = @. 1 / res - 1
    # TODO not sure why we can just do min(abs(rate))... seems convoluted
    rate = rate[findmin(abs.(rate))[2]]
    return rate
end

"""
    npv(rate::Real, values::AbstractVector{<:Real})

Compute the Net Present Value (NPV) of a cash flow series `values` given
an internal rate of return `rate`.

The (fixed) time interval between cash flow "events" must be the same as that for
which `rate` is given (i.e., if `rate` is per year, then precisely
a year is understood to elapse between each cash flow event).  By
convention, investments or "deposits" are negative, income or
"withdrawals" are positive; `values` must begin with the initial
investment, thus `values[1]` will typically be negative.

# Examples
```
julia> npv(0.281,[-100, 39, 59, 55, 20])
-0.00847859163845488
```

# Reference
* L. J. Gitman, "Principles of Managerial Finance, Brief," 3rd ed.,
    Addison-Wesley, 2003, pg. 346.
"""
function npv(rate::Real, values::AbstractVector{<:Real})
    return sum(values ./ (1+rate).^(0:length(values)-1))
end

"""
    mirr(values::AbstractVector{<:Real}, finance_rate::Real, reinvest_rate::Real)

Compute the modified internal rate of return (MIRR) given a series of cash flows,
a `finance_rate` (interest rate paid on the cash flows) and `reinvest_rate` (interest
rate received on the cash flows upon reinvestment).
"""
function mirr(values::AbstractVector{<:Real}, finance_rate::Real, reinvest_rate::Real)
    n = length(values)
    pos = values .> 0
    neg = values .< 0
    if !(any(pos) && any(neg))
        return NaN
    end
    numer = abs(npv(reinvest_rate, values .* pos))
    denom = abs(npv(finance_rate, values .* neg))
    return (numer/denom)^(1/(n - 1))*(1 + reinvest_rate) - 1
end

end

