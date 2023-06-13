const blocklist = (
    "figure",
    "figure*",
    "table",
    "table*",
    "equation",
    "equation*",
)


function cleanblock(fpath)
    ext = splitext(fpath) |> last
    whattype = typedict[ext]
    lines = readlines(fpath)

end


function isblock(lines, tag::String)
    lenl = length(lines)
    v = fill(false, lenl)
    expr0 = Regex("\\A\\s*\\\\begin\\{$tag\\}")
    expr1 = Regex("\\A\\s*\\\\end\\{$tag\\}")
    begins = occursin.(expr0, lines)
    ends = occursin.(expr1, lines)
    @assert isequal(sum(begins), sum(ends))
    for (blockbegin, blockend) in zip(findall(begins), findall(ends))
        v[blockbegin:blockend] .= true
    end
    return v
end
