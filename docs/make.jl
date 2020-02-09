using Documenter
using NPFinancial

makedocs(
    modules = [NPFinancial],
    sitename="NPFinancial"
)

deploydocs(
    repo = "github.com/tk3369/NPFinancial.jl.git",
    deps = Deps.pip("pygments", "mkdocs", "mkdocs-material", "python-markdown-math"),
    make   = () -> run(`mkdocs build`),
    target = "site"
)
