using Documenter
using NPFinancial

makedocs(
    sitename="NPFinancial"
)

deploydocs(
    repo = "github.com/tk3369/NPFinancial.jl.git",
    deps = Deps.pip("pygments", "mkdocs")
)
