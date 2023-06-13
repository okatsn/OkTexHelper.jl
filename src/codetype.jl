abstract type CodeType end
struct Tex <: CodeType end

const typedict = Dict(
    ".tex" => Tex,
)
