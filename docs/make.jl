using Documenter
using NPFinancial

makedocs(
    modules = [NPFinancial],
    sitename="NPFinancial"
)

run(`python -V`)

deploydocs(
    repo = "github.com/tk3369/NPFinancial.jl.git",
    versions = ["stable" => "v^"],
    deps = Deps.pip("pygments", "mkdocs", "mkdocs-material"),
    make   = () -> run(`mkdocs build`),
    target = "site"
)
