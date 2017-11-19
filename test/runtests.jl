using NPFinancial
using Base.Test
using MicroLogging

@test NPFinancial._convert_when(:begin) == 1
@test NPFinancial._convert_when(:end) == 0

@info "Custom tests"
@test fv(0.01, 1, 0, -100, :end) == 101.0
@test map(x -> fv(x, 10*12, -100, -100), [0.05, 0.06, 0.07]/12) ≈ [15692.92889434,  16569.87435405,  17509.44688102]
@test pmt(0.075/12, 12*15, 200000) ≈ -1854.0247200054619
@test nper(0.07/12, -150, 8000) ≈ 64.07334877066185
@test ipmt(0.01, 4, 10, -100.0) ≈ 0.7103767498422946

# unit tests borrowed from numpy

@info "Testing irr"
v = [-150000, 15000, 25000, 35000, 45000, 60000]
@test round(irr(v), 4) == 0.0524

v = [-100, 0, 0, 74]
@test round(irr(v), 4) == -0.0955

v = [-100, 39, 59, 55, 20]
@test round(irr(v), 5) == 0.28095

v = [-100, 100, 0, -7]
@test round(irr(v), 4) == -0.0833

v = [-100, 100, 0, 7]
@test round(irr(v), 5) == 0.06206

v = [-5, 10.5, 1, -8, 1]
@test round(irr(v), 4) == 0.0886

v = [-1, -2, -3]
@test isnan(irr(v))    # in Julia, we cannot compare NaN with NaN

@info "Testing pv"
@test round(pv(0.07, 20, 12000, 0), 2) == -127128.17

@info "Testing pmt"
res = pmt(0.08 / 12, 5 * 12, 15000)
tgt = -304.145914
@test round(res,6) == round(tgt,6)

# Test the edge case where rate == 0.0
res = pmt(0.0, 5 * 12, 15000)
tgt = -250.0
@test round(res,6) == round(tgt,6)

# julia broadcast
res = pmt.([0.3, 0.8], [12, 3], [2000, 20000])
tgt = [-626.90814, -19311.258]
# @info "res=$res"
# @info "tgt=$tgt"
# @info "result=$(round.(res,3) .== round.(tgt,3))"
@test all(round.(res,3) .== round.(tgt,3)) == true

@info "Testing ppmt"
@test round(ppmt(0.1 / 12, 1, 60, 55000), 2) == -710.25
@test round(ppmt(0.23 / 12, 1, 60, 10000000000), 8) == -90238044.232277036

@info "Testing ipmt"
@test round(ipmt(0.1 / 12, 1, 24, 2000), 2) == -16.67

@info "Testing nper"
@test round(nper(0.075, -2000, 0, 100000.), 2) == 21.54
@test round(nper(0.0, -2000, 0, 100000.), 1) == 50.0

@info "Testing npv"
@test round(npv(0.05, [-15000, 1500, 2500, 3500, 4500, 6000]),2) == 122.89

@info "Testing mirr"
val = [-4500, -800, 800, 800, 600, 600, 800, 800, 700, 3000]
@test round(mirr(val, 0.08, 0.055), 4) == 0.0666

val = [-120000, 39000, 30000, 21000, 37000, 46000]
@test round(mirr(val, 0.10, 0.12), 6) == 0.126094

val = [100, 200, -50, 300, -200]
@test round(mirr(val, 0.05, 0.06), 4) == 0.3428

val = [39000, 30000, 21000, 37000, 46000]
@test isnan(mirr(val, 0.10, 0.12))

@info "All tests completed"
