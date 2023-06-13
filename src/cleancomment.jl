"""
# Example
`cleancomment("temp/temp.tex") |> lines -> writelines(lines, "tempxxx.tex"; keep_empty = false, do_rstrip=true)`
"""
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

"""
`writelines(lines::Vector{String}, targetpath; keep_empty=true, do_rstrip=false)` write a Vector of string to  `targetpath`.

`cleancomment` may result in empty lines or lines with only white spaces, and sometimes these empty lines results in complie error of latex (e.g., an blank line in a table block).
To avoid this, set `keep_empty` to `false` and `do_rstrip` to `true` to discard all empty lines.
"""
function writelines(lines::Vector{String}, targetpath; keep_empty=true, do_rstrip=false)
    if do_rstrip
        lines = rstrip.(lines)
    end

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
