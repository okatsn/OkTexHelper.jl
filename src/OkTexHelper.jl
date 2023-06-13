module OkTexHelper

include("codetype.jl")

include("cleancomment.jl")
export cleancomment, Tex, writelines

using DataFrames
include("cleanblock.jl")
export cleanblock

end
