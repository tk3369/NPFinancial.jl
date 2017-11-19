var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#NPFinancial.jl-Documentation-1",
    "page": "Home",
    "title": "NPFinancial.jl Documentation",
    "category": "section",
    "text": "NPFinancial.jl is a port of the NumPy's financial module Edit"
},

{
    "location": "index.html#NPFinancial.pv",
    "page": "Home",
    "title": "NPFinancial.pv",
    "category": "Function",
    "text": "Compute the present value given the future value fv, an interest rate rate and a fixed periodic payment pmt over a number of periods nper.  The payment is expected to be paid at the beginning of each period (:begin) or :end of the period,  as specified in the when argument.\n\n\n\n"
},

{
    "location": "index.html#NPFinancial.fv",
    "page": "Home",
    "title": "NPFinancial.fv",
    "category": "Function",
    "text": "Compute the future value given the present value pv, an interest rate rate that  is compounded once per period, over nper number of periods. A fixed payment pmt may be specified in the when argument, which is paid either at the beginning of  each period (:begin) or :end of the period.\n\nExamples\n\njulia> fv(0.05, 1, 0, -100)\n105.0\n\njulia> fv(0.05, 2, 0, -100)\n110.25\n\n\n\n"
},

{
    "location": "index.html#NPFinancial.pmt",
    "page": "Home",
    "title": "NPFinancial.pmt",
    "category": "Function",
    "text": "Compute the payment given the present value pv, an interest rate rate that  is compounded once per period, over nper number of periods, such that at the end of the last period the value becomes fv. The payment is expected to be paid at the beginning of each period (:begin) or :end of the period, as specified in the when argument.\n\nExamples\n\nLet's say I have need to repay a mortage loan with amount 300000 (present value) with monthly interst rate of 4.25% over the next 30 years.  What would be my monthly payment?\n\njulia> pmt(0.0425/12, 30*12, 300000)\n-1475.8196732384283\n\n\n\n"
},

{
    "location": "index.html#NPFinancial.nper",
    "page": "Home",
    "title": "NPFinancial.nper",
    "category": "Function",
    "text": "Compute how many periods the present value pv may accrue/repaid till the future value fv given a specific interest rate rate and a fixed payment pmt. The payment is expected to be paid at the beginning of each period (:begin) or :end of the period, as specified in the when argument.\n\n\n\n"
},

{
    "location": "index.html#NPFinancial.ipmt",
    "page": "Home",
    "title": "NPFinancial.ipmt",
    "category": "Function",
    "text": "Compute the interest component of the periodic payment.  This useful for any  loan that has a repayment schedule.\n\nExamples\n\nLet's say I have need to repay a mortage loan with amount 300000 (present value) with monthly interst rate of 4.25% over the next 30 years.  What would be the interest component of my monthly payment?  Initially, the interest component is  a large part of the payment but towards the end, it would be a smaller portion as illustrated below for periods 1, 2, 3, 358, 359, and 360:\n\njulia> pmt(0.0425/12, 30*12, 300000)\n-1475.8196732384283\n\njulia> ipmt.(0.0425/12, [1,2,3,358,359,360], 30*12, 300000)\n6-element Array{Float64,1}:\n -1062.5    \n -1061.04   \n -1059.57   \n   -15.5702 \n   -10.3984 \n    -5.20841\n\n\n\n"
},

{
    "location": "index.html#NPFinancial.ppmt",
    "page": "Home",
    "title": "NPFinancial.ppmt",
    "category": "Function",
    "text": "Compute the principal component of the periodic payment.  This useful for any  loan that has a repayment schedule.\n\nExamples\n\njulia> pmt(0.0425/12, 30*12, 300000)\n-1475.8196732384283\n\njulia> ppmt.(0.0425/12, [1,2,3,358,359,360], 30*12, 300000)\n6-element Array{Float64,1}:\n  -413.32 \n  -414.784\n  -416.253\n -1460.25 \n -1465.42 \n -1470.61 \n\n\n\n"
},

{
    "location": "index.html#NPFinancial.rate",
    "page": "Home",
    "title": "NPFinancial.rate",
    "category": "Function",
    "text": "Compute interest rate given present value pv, future value fv, and fixed periodic  payment pmt over a number of periods nper.\n\nThis implementation uses Newton's iteration until the change is less than 1e-6. Newton's rule is\n\nr_{n+1} = r_{n} - g(r_n)/g'(r_n)\n\nwhere\n\ng(r) is the formula\ng'(r) is the derivative with respect to r.\n\nExamples\n\njulia> rate(1, 0, -100, 101)\n0.010000000000000155\n\n\n\n"
},

{
    "location": "index.html#NPFinancial.npv-Tuple{Any,Any}",
    "page": "Home",
    "title": "NPFinancial.npv",
    "category": "Method",
    "text": "Compute the Net Present Value (NPV) of a cash flow series values given  an internal rate of return rate.\n\nThe (fixed) time interval between cash flow \"events\" must be the same as that for which rate is given (i.e., if rate is per year, then precisely a year is understood to elapse between each cash flow event).  By convention, investments or \"deposits\" are negative, income or \"withdrawals\" are positive; values must begin with the initial investment, thus values[1] will typically be negative.\n\nExamples\n\njulia> npv(0.281,[-100, 39, 59, 55, 20])\n-0.00847859163845488    \n\nReference\n\nL. J. Gitman, \"Principles of Managerial Finance, Brief,\" 3rd ed.,   Addison-Wesley, 2003, pg. 346.\n\n\n\n"
},

{
    "location": "index.html#NPFinancial.irr-Tuple{Any}",
    "page": "Home",
    "title": "NPFinancial.irr",
    "category": "Method",
    "text": "Calculate internal rate of return given an array of cash flow values  (nearest one first)\n\nExamples\n\njulia> irr([-100, 101])\n0.010000000000000009\n\n\n\n"
},

{
    "location": "index.html#NPFinancial.mirr-Tuple{Any,Any,Any}",
    "page": "Home",
    "title": "NPFinancial.mirr",
    "category": "Method",
    "text": "Compute the modified internal rate of return (MIRR) given a series of cash flows, a finance_rate (interest rate paid on the cash flows) and reinvest_rate (interest rate received on the cash flows upon reinvestment).\n\n\n\n"
},

{
    "location": "index.html#Functions-1",
    "page": "Home",
    "title": "Functions",
    "category": "section",
    "text": "pv(rate, nper, pmt, fv = 0.0, when = :end)\nfv(rate, nper, pmt, pv, when = :end)\npmt(rate, nper, pv, fv = 0.0, when = :end)\nnper(rate, pmt, pv, fv = 0.0, when = :end)\nipmt(rate, per, nper, pv, fv = 0.0, when = :end)\nppmt(rate, per, nper, pv, fv = 0.0, when = :end)\nrate(nper, pmt, pv, fv, when=:end, guess=0.1, tol=1e-6, maxiter=100)\nnpv(rate, values)\nirr(values)\nmirr(values, finance_rate, reinvest_rate)"
},

{
    "location": "index.html#Index-1",
    "page": "Home",
    "title": "Index",
    "category": "section",
    "text": ""
},

]}
