using Documenter, NPFinancial

makedocs(
)

deploydocs(
    repo = "github.com/tk3369/NPFinancial.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)
