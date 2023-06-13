manylines = ["Eq. \\ref{Eq_Pst_b} theoretically shows that the distribution of slip velocities during a steady-state friction process is a double-sided exponential function.",
    "As an example, Fig. \\ref{Fig_Pst_slices} demonstrates comparisons between the analytically obtained steady-state solutions \$P_\\text{st}(v)\$ of the FPE (Eq. \\ref{Eq_Pst_a} or Eq. \\ref{Eq_Pst_b}), shown as the red curves, and the ensemble-predicted distributions as histograms, with \$D=10\$, \$F_C=1\$, and \$F\\text{ext}=0.9\$.",
    "Each histogram subplot comprises values sampled from \$10^{4}\$ sample paths of \$v(t)\$ at \$t = 713,\\ 1571,\\ 2428,\\ 3285,\\ 4143,\$ and \$5000\$, with each sample path being obtained by numerically solving the Langevin equation (Eq. \\ref{Eq_mainLE} or Eq. \\ref{Eq_SDE_C}).",
    "The red curves in the figure are the theoretical probability distributions of \$v\$ at \$t\\rightarrow \\infty\$; as a matter of course, the histograms of the ensemble-predicted values at larger \$t\$ approximate the red curves better than those at smaller \$t\$.",
    "\\begin{figure}",
    "    \\includegraphics[width=0.5\\textwidth]{Fig_ThingbaijamMai2016.eps}",
    "    \\caption{The empirical TEX law for earthquake rupture slips proposed by Thingbaijam and Mai (2016). (a) [modified from Figure 1 (a) in Thingbaijam and Mai (2016)] The slip distribution from the finite source inversion for the 2011 Tohoku earthquake. (b) [Figure 1 (b) in Thingbaijam and Mai (2016)] The CCDF of the slip distribution of (a). In this subplot, orange circles denotes the empirical CCDF computed from the source model that is trimmed to the effective source dimensions; colored-solid or -dashed lines denotes the best fitting models of various distribution functions. (c) [the upper-left panel in the Figure 4 of Thingbaijam and Mai (2016)] The averaged CCDF of the slip distributions of subduction zone earthquakes worldwide.",
    "        For the EXP and TEX distribution function, see Eq. \\ref{Eq_EXP_ccdf} and Eq. \\ref{Eq_TEX_ccdf} in this study; for the Weibull (WBL), Gamma (GAM) and lognormal (LGN) distributions, please refer to the Table 1 in the study of Thingbaijam and Mai (2016).",
    "    }",
    "    \\label{Fig_ThingbaijamMai2016}",
    "\\end{figure}",
    "For real large earthquakes (\$M_w \\geq 5\$), Thingbaijam and Mai demonstrated that the TEX distribution best characterizes the empirical distribution of rupture slips in either an individual or an average sense, as demonstrated in Fig. \\ref{Fig_ThingbaijamMai2016}.",
    "The authors examined the goodness of fit rigorously over the TEX distribution in addition to other well-known distributions, including the exponential (EXP), Weibull, Gamma, and lognormal distributions, by analyzing 190 source models of events worldwide.",
    "They concluded that the TEX distribution generally exhibits the best fit to the slips along fault planes, especially at larger slip values.",
    "In their study, the fitting function was expressed in the form of the complementary cumulative distribution function (CCDF) to avoid arbitrarily choosing the data bin size and to better distinguish the fitting results at large slips.",
    "In addition, the CCDF for a non-truncated EXP distribution function \$f_\\text{EXP}(v) = (1/v_c)\\exp(-v/v_c)\$",
    "is also an EXP distribution:",
    "\\begin{equation}",
    "    1-F_\\text{EXP}(v) = \\exp{\\left( -\\frac{v}{v_c} \\right)},  \\label{Eq_EXP_ccdf}",
    "\\end{equation}",
    "where \$F_\\text{EXP}(v) = 1 - \\exp{(-{v}/{v_c})}\$ is the cumulative distribution function (CDF) of \$f_\\text{EXP}(v)\$.",
    "For the TEX distribution \$f_\\text{TEX}(v) \\equiv f_\\text{EXP}(v)/F_\\text{EXP}(v_\\text{max})\$, its CCDF form is",
    "\\begin{equation}",
    "    1-F_\\text{TEX}(v) = \\frac{\\exp(-v/v_c)-\\exp(-v_\\text{max}/v_c)}{1-\\exp(-v_\\text{max}/v_c)}, \\label{Eq_TEX_ccdf}",
    "\\end{equation}",
    "where \$F_\\text{TEX}(v)\$ is the CDF of \$f_\\text{TEX}(v)\$.",
    "The TEX distribution function is a conditional distribution obtained by restricting the domain of the original function.",
    "When calculating the distribution of either a simulated or an empirically observed physical quantity, the largest value in the dataset must be finite.",
    "Thus, empirically calculated statistics can more often fit the TEX distribution better than the original form can.",
    "\\begin{figure*}",
    "    \\includegraphics[width=\\textwidth]{TEX_EXP_ccdf_fit.eps}",
    "    \\caption{The CCDF of synthetic slip velocities of different durations (\$T = 10\$, \$100\$, and \$1000\$), and their best fitting TEX and EXP model (red solid and orange dashed curve, respectively).",
    "        The slip velocities are sampled evenly spaced in time from the particular solutions of Eq. \\ref{Eq_SDE_C}, where \$D=5,\\ F_C = 1,\\ F_\\text{ext}=0.9\$.",
    "        In (a), (b), and (c), velocities for each distribution are collected from a single realization;",
    "        in (d), (e), and (f), velocities for each distribution are collected from \$1000\$ realization.",
    "    }",
    "    \\label{Fig_TEXccdfFit}",
    "\\end{figure*}",
    "To demonstrates how local slips (\$(t_{k+1}-t_k)V_k\$ or \$v_p(t)\\mathrm{d}t\$) in an individual realization of the Langevin friction process fit the TEX and EXP functions, we generate three sample paths of different durations with the parameters \$D=5\$, \$F_C = 1\$, and \$F_\\text{ext}=0.9\$.",
]

@testset "isblock" begin
    lines = ["\\begin{figure}", "\\begin{figure} % Hello Comment", "   \\begin{figure}"]
    for possibleline in lines
        @test OkTexHelper.matchbegin("figure", possibleline)
    end

    for possibleline in replace.(lines, "begin" => "end")
        @test OkTexHelper.matchend("figure", possibleline)
    end

    # commented lines should not be matched
    @test !OkTexHelper.matchbegin("figure", "% \\begin{figure}")
    @test !OkTexHelper.matchend("figure", "% \\end{figure}")

    # Test asterisk matching
    @test !OkTexHelper.matchbegin("figure", "\\begin{figure*}")
    @test !OkTexHelper.matchend("figure", "\\end{figure*}")
    @test !OkTexHelper.matchend("table", "\\end{figure}")

    @test !OkTexHelper.matchbegin("figure*", "\\begin{figure}")
    @test !OkTexHelper.matchend("figure*", "\\end{figure}")


    # test isblock range
    @test isequal(findall(OkTexHelper.isblock(manylines, "figure")), collect(5:11))
    @test isequal(findall(OkTexHelper.isblock(manylines, "equation")), [18, 19, 20, 23, 24, 25])
    @test isequal(findall(OkTexHelper.isblock(manylines, "figure*")), collect(30:38))

    OkTexHelper.repstar("\\begin\\{figure*\\}")
end


noblocklines = ["Eq. \\ref{Eq_Pst_b} theoretically shows that the distribution of slip velocities during a steady-state friction process is a double-sided exponential function.",
    "As an example, Fig. \\ref{Fig_Pst_slices} demonstrates comparisons between the analytically obtained steady-state solutions \$P_\\text{st}(v)\$ of the FPE (Eq. \\ref{Eq_Pst_a} or Eq. \\ref{Eq_Pst_b}), shown as the red curves, and the ensemble-predicted distributions as histograms, with \$D=10\$, \$F_C=1\$, and \$F\\text{ext}=0.9\$.",
    "Each histogram subplot comprises values sampled from \$10^{4}\$ sample paths of \$v(t)\$ at \$t = 713,\\ 1571,\\ 2428,\\ 3285,\\ 4143,\$ and \$5000\$, with each sample path being obtained by numerically solving the Langevin equation (Eq. \\ref{Eq_mainLE} or Eq. \\ref{Eq_SDE_C}).",
    "The red curves in the figure are the theoretical probability distributions of \$v\$ at \$t\\rightarrow \\infty\$; as a matter of course, the histograms of the ensemble-predicted values at larger \$t\$ approximate the red curves better than those at smaller \$t\$.",
    "For real large earthquakes (\$M_w \\geq 5\$), Thingbaijam and Mai demonstrated that the TEX distribution best characterizes the empirical distribution of rupture slips in either an individual or an average sense, as demonstrated in Fig. \\ref{Fig_ThingbaijamMai2016}.",
    "The authors examined the goodness of fit rigorously over the TEX distribution in addition to other well-known distributions, including the exponential (EXP), Weibull, Gamma, and lognormal distributions, by analyzing 190 source models of events worldwide.",
    "They concluded that the TEX distribution generally exhibits the best fit to the slips along fault planes, especially at larger slip values.",
    "In their study, the fitting function was expressed in the form of the complementary cumulative distribution function (CCDF) to avoid arbitrarily choosing the data bin size and to better distinguish the fitting results at large slips.",
    "In addition, the CCDF for a non-truncated EXP distribution function \$f_\\text{EXP}(v) = (1/v_c)\\exp(-v/v_c)\$",
    "is also an EXP distribution:",
    "where \$F_\\text{EXP}(v) = 1 - \\exp{(-{v}/{v_c})}\$ is the cumulative distribution function (CDF) of \$f_\\text{EXP}(v)\$.",
    "For the TEX distribution \$f_\\text{TEX}(v) \\equiv f_\\text{EXP}(v)/F_\\text{EXP}(v_\\text{max})\$, its CCDF form is",
    "where \$F_\\text{TEX}(v)\$ is the CDF of \$f_\\text{TEX}(v)\$.",
    "The TEX distribution function is a conditional distribution obtained by restricting the domain of the original function.",
    "When calculating the distribution of either a simulated or an empirically observed physical quantity, the largest value in the dataset must be finite.",
    "Thus, empirically calculated statistics can more often fit the TEX distribution better than the original form can.",
    "To demonstrates how local slips (\$(t_{k+1}-t_k)V_k\$ or \$v_p(t)\\mathrm{d}t\$) in an individual realization of the Langevin friction process fit the TEX and EXP functions, we generate three sample paths of different durations with the parameters \$D=5\$, \$F_C = 1\$, and \$F_\\text{ext}=0.9\$.",
]

@testset "cleanblock" begin
    df = OkTexHelper.blocktable(manylines)
    targetblocks = OkTexHelper.reducelines(df)
    @test isequal(manylines[.!targetblocks], noblocklines)
end
