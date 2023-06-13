@testset "cleancomment.jl" begin
    @test cleancomment("\\usepackage{amsmath} % for latex math", Tex) == "\\usepackage{amsmath} "

    exs = [ # strings with no comment
        "Overall, the trained models perform well, with MAE in general of less than 4\\% (v/v) except for the 3rd and 8th fold, as demonstrated in Fig.~\\ref{fig_loss_eachfold_alldepths}.",
        "                \\text{humidity\\_CWB}       & 77.8678     & 25.0       & 79.0          & 98.0946    & \\text{\\% RH}\\(^*\\)     \\\\"
    ]
    for ex in exs
        @test cleancomment(ex, Tex) == ex
    end

    @test cleancomment("            \\multicolumn{1}{c|}{}                                        & \\multicolumn{2}{c|}{\\multirow{2}{*}{Group tag/Feature name}} & \\multicolumn{1}{c}{\\multirow{2}{*}{Time shift (lag) of input features}}                                \\\\ %\\cline{4} % % horizontal line at col 3-5 (between Time shift ... and baseline &...)", Tex) == "            \\multicolumn{1}{c|}{}                                        & \\multicolumn{2}{c|}{\\multirow{2}{*}{Group tag/Feature name}} & \\multicolumn{1}{c}{\\multirow{2}{*}{Time shift (lag) of input features}}                                \\\\ "

    @test cleancomment("\\usepackage{rotating} % for rotate row (\\begin{turn}...)", Tex) == "\\usepackage{rotating} "

    @test cleancomment("\\usepackage{listings} % for '\\lstset' and '\\lstinline' macros", Tex) == "\\usepackage{listings} "

end
