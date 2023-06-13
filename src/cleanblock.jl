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

"""

"""
function cleanblock(fpath)
    ext = splitext(fpath) |> last
    whattype = typedict[ext]
    lines = readlines(fpath)
    df = blocktable(lines)
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
