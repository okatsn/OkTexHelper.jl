using OkTexHelper
using Documenter

DocMeta.setdocmeta!(OkTexHelper, :DocTestSetup, :(using OkTexHelper); recursive=true)

makedocs(;
    modules=[OkTexHelper],
    authors="okatsn <okatsn@gmail.com> and contributors",
    repo="https://github.com/okatsn/OkTexHelper.jl/blob/{commit}{path}#{line}",
    sitename="OkTexHelper.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://okatsn.github.io/OkTexHelper.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/okatsn/OkTexHelper.jl",
    devbranch="main",
)
