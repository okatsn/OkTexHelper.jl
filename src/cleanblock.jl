const blocklist = (
    "figure",
    "figure*",
    "table",
    "table*",
    "equation",
    "equation*",
    "acknowledgments"
)


function cleanblock(fpath)
    ext = splitext(fpath) |> last
    whattype = typedict[ext]
    lines = readlines(fpath)
    df = blocktable(lines)
end

repstar(str) = replace(str, "*" => "\\*")

matchbegin(tag, str) = occursin(Regex("\\A\\s*\\\\begin\\{$(repstar(tag))\\}"), str)
matchend(tag, str) = occursin(Regex("\\A\\s*\\\\end\\{$(repstar(tag))\\}"), str)


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


function blocktable(lines)
    df = DataFrame()
    for blocktag in blocklist
        insertcols!(df, blocktag => isblock(lines, blocktag))
    end
    return df
end
