pushfirst!(LOAD_PATH, "../src")

using Documenter
using NPFinancial

makedocs(
    modules = [NPFinancial],
    sitename="NPFinancial"
)
