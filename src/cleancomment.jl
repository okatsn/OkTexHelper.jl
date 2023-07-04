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







"""
```
mutable struct CleanComment
    text::AbstractString
    pbreak::Bool
end
```
where `pbreak` denotes whether this line of `text` is originally line break in the document.
"""
mutable struct CleanComment
    text::AbstractString
    pbreak::Bool
end

"""
`CleanComment(str::AbstractString, tp)` do `cleancomment(str, tp)`, with whether this `str` is line break in the original text denoted in the `pbreak` field.
"""
function CleanComment(str::AbstractString, tp)
    str = rstrip(str) # remove trailing white space
    pbreak = ifelse(isempty(str), true, false) # check if this is a break for paragraph; you have to check it first before `cleancomment`
    text = cleancomment(str, tp)
    CleanComment(text, pbreak)
end

"""
Given the `fpath` to the text file, `CleanComments(fpath)` returns a `Vector` of `CleanComment`.

# Example
```julia
CleanComments("temp/temp.tex") |> lines -> writelines(lines, "tempxxx.tex")
```
"""
function CleanComments(fpath)
    ext = splitext(fpath) |> last
    whattype = typedict[ext]
    lines = readlines(fpath)
    CleanComment.(lines, Ref(whattype))
end


"""
`writelines(lines::Vector{CleanComment}, targetpath)` write non-empty or non-line break lines of `CleanComment` to `targetpath`.

See also `CleanComment`, `CleanComments`.

# Example
```
CleanComments("LATEX_gji2020/main.tex") |> lines -> writelines(lines, "temp/temp.tex")

```
"""
function writelines(lines::Vector{CleanComment}, targetpath)
    open(targetpath, "w") do io
        for CC in lines
            if CC.pbreak || !isempty(rstrip(CC.text)) # only when it is not a blank line or it is a paragraph break, we should write.
                write(io, CC.text)
                write(io, "\n")
            end
        end
    end
end
