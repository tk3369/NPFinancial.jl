using Documenter, NPFinancial

makedocs(
    modules = [NPFinancial],
    clean = false,
    format = :html,
    sitename = "NPFinancial.jl",
    authors = "Tom Kwong",
    linkcheck = !("skiplinks" in ARGS),
    pages = Any[
        "Home" => "index.md"
    ]
)

deploydocs(
    repo = "github.com/tk3369/NPFinancial.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
    julia  = "0.6",
    osname = "linux"
)
