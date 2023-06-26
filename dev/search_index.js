var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = OkTexHelper","category":"page"},{"location":"#OkTexHelper","page":"Home","title":"OkTexHelper","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for OkTexHelper.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [OkTexHelper]","category":"page"},{"location":"#OkTexHelper.blocklist","page":"Home","title":"OkTexHelper.blocklist","text":"Tags of blocks to be detected in Tex (.tex) file.\n\n\n\n\n\n","category":"constant"},{"location":"#OkTexHelper.CleanComment","page":"Home","title":"OkTexHelper.CleanComment","text":"mutable struct CleanComment\n    text::AbstractString\n    pbreak::Bool\nend\n\nwhere pbreak denotes whether this line of text is originally line break in the document.\n\n\n\n\n\n","category":"type"},{"location":"#OkTexHelper.CleanComment-Tuple{AbstractString, Any}","page":"Home","title":"OkTexHelper.CleanComment","text":"CleanComment(str::AbstractString, tp) do cleancomment(str, tp), with whether this str is line break in the original text denoted in the pbreak field.\n\n\n\n\n\n","category":"method"},{"location":"#OkTexHelper.CleanComments-Tuple{Any}","page":"Home","title":"OkTexHelper.CleanComments","text":"Given the fpath to the text file, CleanComments(fpath) returns a Vector of CleanComment.\n\n\n\n\n\n","category":"method"},{"location":"#OkTexHelper.blocktable-Tuple{Any}","page":"Home","title":"OkTexHelper.blocktable","text":"Given lines a vector of strings, blocktable(lines) returns vectors of isblock(lines, tag) for all tag in blocktag.\n\n\n\n\n\n","category":"method"},{"location":"#OkTexHelper.cleanblock-Tuple{Any, Any}","page":"Home","title":"OkTexHelper.cleanblock","text":"Given file path fpath and column selector colselector, cleanblock(fpath, colselector) returns a vector of strings lines that blocks matching colselector were removed.\n\nUse writelines to save your result as file.\n\nExample\n\ncleanblock(\"temp/temp.tex\") |> lines -> writelines(lines, \"tempxxx.tex\"; keep_empty = false, do_rstrip=true)\n\n\n\n\n\n","category":"method"},{"location":"#OkTexHelper.cleancomment-Tuple{Any}","page":"Home","title":"OkTexHelper.cleancomment","text":"Example\n\ncleancomment(\"temp/temp.tex\") |> lines -> writelines(lines, \"tempxxx.tex\"; keep_empty = false, do_rstrip=true)\n\n\n\n\n\n","category":"method"},{"location":"#OkTexHelper.isblock-Tuple{Any, String}","page":"Home","title":"OkTexHelper.isblock","text":"Given lines a vector of strings, isblock(lines, tag::String) returns a Bool vector indicating the location of blocks matched by matchbegin and matchend.\n\n\n\n\n\n","category":"method"},{"location":"#OkTexHelper.matchbegin-Tuple{Any, Any}","page":"Home","title":"OkTexHelper.matchbegin","text":"matchbegin(tag, str) returns true if str is started with \\begin{$tag}\n\n\n\n\n\n","category":"method"},{"location":"#OkTexHelper.matchend-Tuple{Any, Any}","page":"Home","title":"OkTexHelper.matchend","text":"matchend(tag, str) returns true if str is started with \\end{$tag}\n\n\n\n\n\n","category":"method"},{"location":"#OkTexHelper.repstar-Tuple{Any}","page":"Home","title":"OkTexHelper.repstar","text":"repstar(str) add \"\\\" in front of every asterisk.\n\n\n\n\n\n","category":"method"},{"location":"#OkTexHelper.writelines-Tuple{Vector{CleanComment}, Any}","page":"Home","title":"OkTexHelper.writelines","text":"writelines(lines::Vector{CleanComment}, targetpath) write non-empty or non-line break lines of CleanComment to targetpath.\n\nSee also CleanComment, CleanComments.\n\nExample\n\nCleanComments(\"LATEX_gji2020/main.tex\") |> lines -> writelines(lines, \"temp/temp.tex\")\n\n\n\n\n\n\n","category":"method"},{"location":"#OkTexHelper.writelines-Tuple{Vector{String}, Any}","page":"Home","title":"OkTexHelper.writelines","text":"writelines(lines::Vector{String}, targetpath; keep_empty=true, do_rstrip=false) write a Vector of string to  targetpath.\n\ncleancomment may result in empty lines or lines with only white spaces, and sometimes these empty lines results in complie error of latex (e.g., an blank line in a table block). To avoid this, set keep_empty to false and do_rstrip to true to discard all empty lines.\n\n\n\n\n\n","category":"method"}]
}
