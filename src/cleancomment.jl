
abstract type CodeType end
struct Tex <: CodeType end



function cleancomment(fpath)
    ext = splitext(fpath) |> last
    readlines(fpath)
end


function cleancomment(str::AbstractString, ::Type{Tex})
    replace(str, r"(?<!\\)%.*" => "")
end
