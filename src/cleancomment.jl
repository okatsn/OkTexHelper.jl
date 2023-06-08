
abstract type CodeType end
struct Tex <: CodeType end

typedict = Dict(
    ".tex" => Tex,
)


function cleancomment(fpath)
    ext = splitext(fpath) |> last
    # whattype = eval(Symbol(uppercasefirst(ext[2:end]))) # ext = ".tex", and ext[2:end] = "tex"
    whattype = typedict[ext]
    lines = readlines(fpath)
    cleancomment.(lines, whattype)
end


function cleancomment(str::AbstractString, ::Type{Tex})
    replace(str, r"(?<!\\)%.*" => "")
end



function writelines(lines::Vector{String}, targetpath; keep_empty=true)
    if !keep_empty
        keep_only = .!isempty.(lines)
    else
        keep_only = eachindex(lines)
    end

    lines = broadcast(*, lines, Ref("\n"))

    open(targetpath, "w") do io
        for str in lines[keep_only]
            write(io, str)
        end
    end
end
