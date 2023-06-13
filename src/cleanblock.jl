"""
Tags of blocks to be detected in `Tex` (.tex) file.
"""
const blocklist = (
    "figure",
    "figure*",
    "table",
    "table*",
    "equation",
    "equation*",
    "acknowledgments"
)


elwiseor(a, b) = a .| b
"""
Given file path `fpath` and column selector `colselector`, `cleanblock(fpath, colselector)` returns a vector of strings `lines` that blocks matching `colselector` were removed.

Use `writelines` to save your result as file.

# Example
`cleanblock("temp/temp.tex") |> lines -> writelines(lines, "tempxxx.tex"; keep_empty = false, do_rstrip=true)`
"""
function cleanblock(fpath, colselector)
    ext = splitext(fpath) |> last
    whattype = typedict[ext]
    lines = readlines(fpath)
    df = blocktable(lines)
    select!(df, colselector)
    targetblocks = reducelines(df)
    return lines[.!targetblocks]
end

function cleanblock(fpath)
    cleanblock(fpath, All())
end

function reducelines(df)
    targetblocks = reduce(elwiseor, eachcol(df))
end

"""
`repstar(str)` add "\\" in front of every asterisk.
"""
repstar(str) = replace(str, "*" => "\\*")

"""
`matchbegin(tag, str)` returns true if `str` is started with `\\begin{\$tag}`
"""
matchbegin(tag, str) = occursin(Regex("\\A\\s*\\\\begin\\{$(repstar(tag))\\}"), str)

"""
`matchend(tag, str)` returns true if `str` is started with `\\end{\$tag}`
"""
matchend(tag, str) = occursin(Regex("\\A\\s*\\\\end\\{$(repstar(tag))\\}"), str)

"""
Given `lines` a vector of strings, `isblock(lines, tag::String)` returns a `Bool` vector indicating the location of blocks matched by `matchbegin` and `matchend`.
"""
function isblock(lines, tag::String)
    lenl = length(lines)
    v = fill(false, lenl)
    begins = matchbegin.(tag, lines)
    ends = matchend.(tag, lines)
    @assert isequal(sum(begins), sum(ends))
    for (blockbegin, blockend) in zip(findall(begins), findall(ends))
        v[blockbegin:blockend] .= true
    end
    return v
end

"""
Given `lines` a vector of strings, `blocktable(lines)` returns vectors of `isblock(lines, tag)` for all `tag` in `blocktag`.
"""
function blocktable(lines)
    df = DataFrame()
    for blocktag in blocklist
        insertcols!(df, blocktag => isblock(lines, blocktag))
    end
    return df
end
