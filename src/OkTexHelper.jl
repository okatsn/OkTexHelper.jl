module OkTexHelper

include("codetype.jl")

include("cleancomment.jl")
export cleancomment, Tex, writelines
export CleanComments, CleanComment # consider make cleancomment an implicit function, deprecate writelines for Vector of String and keep writelines for Vector of CleanComment.

using DataFrames
include("cleanblock.jl")
export cleanblock

end
