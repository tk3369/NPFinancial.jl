using Documenter
using NPFinancial

makedocs(
    modules = [NPFinancial],
    sitename="NPFinancial"
)

deploydocs(
    repo = "github.com/tk3369/NPFinancial.jl.git",
    devbranch = "master",
    devurl = "dev",
    versions = ["stable" => "v^", "v#.#", devurl => devurl]
)
