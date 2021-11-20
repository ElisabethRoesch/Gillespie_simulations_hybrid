using DifferentialEquations, ForwardDiff, Plots
using ForwardDiff:Dual

function f(du,u,p,t)
  k₃, k₄, k₆, k₇, k₈, k₉, k′₃, k′₄, k′₆, k′₇, k′₈, k′₉ = p
  M, E, pE, ppE, Pt,  E_M, pE_M, pE_Pt, ppE_Pt = u
  du[1] = k₄*E_M + k₇*E_M + k₆*pE_M + k₉*pE_M - k₃*E*M - k₈*M*pE
  du[2] = k′₆*pE_Pt + k₄*E_M - k₃*E*M
  du[3] = k₇*E_M + k₉*pE_M + k′₉*pE_Pt + k′₇*ppE_Pt - k₈*M*pE - k′₈*Pt*pE
  du[4] = k′₄*ppE_Pt + k₆*pE_M - k′₃*Pt*ppE
  du[5] = k′₄*ppE_Pt + k′₆*pE_Pt + k′₉*pE_Pt + k′₇*ppE_Pt - k′₃*Pt*ppE - k′₈*Pt*pE
  du[6] = k₃*E*M - k₄*E_M - k₇*E_M
  du[7] = k₈*M*pE - k₆*pE_M - k₉*pE_M
  du[8] = k′₈*Pt*pE - k′₆*pE_Pt - k′₉*pE_Pt
  du[9] = k′₃*Pt*ppE - k′₄*ppE_Pt - k′₇*ppE_Pt
  return du
end

p = [0.5, 0.5, 900/2, 499/2, 0.5, 5, 999/2, (10^5-1)/2, 50, 5, 500, 10^5/2]
inits  = [0.1, 5., 0.1, 5., 0.1, 0.1, 0.1, 0.1, 0.1]
p_2 = [ Dual{Float64}(p[1], (1., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.)),
        Dual{Float64}(p[2], (0., 1., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.)),
        Dual{Float64}(p[3], (0., 0., 1., 0., 0., 0., 0., 0., 0., 0., 0., 0.)),
        Dual{Float64}(p[4], (0., 0., 0., 1., 0., 0., 0., 0., 0., 0., 0., 0.)),
        Dual{Float64}(p[5], (0., 0., 0., 0., 1., 0., 0., 0., 0., 0., 0., 0.)),
        Dual{Float64}(p[6], (0., 0., 0., 0., 0., 1., 0., 0., 0., 0., 0., 0.)),
        Dual{Float64}(p[7], (0., 0., 0., 0., 0., 0., 1., 0., 0., 0., 0., 0.)),
        Dual{Float64}(p[8], (0., 0., 0., 0., 0., 0., 0., 1., 0., 0., 0., 0.)),
        Dual{Float64}(p[9], (0., 0., 0., 0., 0., 0., 0., 0., 1., 0., 0., 0.)),
        Dual{Float64}(p[10], (0., 0., 0., 0., 0., 0., 0., 0., 0., 1., 0., 0.)),
        Dual{Float64}(p[11], (0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 1., 0.)),
        Dual{Float64}(p[12], (0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 1.))]



function diff_ode(p)
  prob = ODEProblem(f, inits, (0.0,10.0), p)
  solve(prob, Tsit5(), saveat = 0.0:0.01:10.0)
end



a = diff_ode(p_2)




vals_1 = []
  vals_2 = []
  vals_3 = []
  vals_4 = []
  vals_5 = []
  vals_6 = []
  vals_7 = []
  vals_8 = []
  vals_9 = []

  der_1 = []
  der_2 = []
  der_3 = []
  der_4 = []
  der_5 = []
  der_6 = []
  der_7 = []
  der_8 = []
  der_9 = []
  der_10 = []
  der_11 = []
  der_12 = []

  der_13 = []
  der_14 = []
  der_15 = []
  der_16 = []
  der_17 = []
  der_18 = []
  der_19 = []
  der_20 = []
  der_21 = []
  der_22 = []
  der_23 = []
  der_24 = []

  der_25 = []
  der_26 = []
  der_27 = []
  der_28 = []
  der_29 = []
  der_30 = []
  der_31 = []
  der_32 = []
  der_33 = []
  der_34 = []
  der_35 = []
  der_36 = []

  der_37 = []
  der_38 = []
  der_39 = []
  der_40 = []
  der_41 = []
  der_42 = []
  der_43 = []
  der_44 = []
  der_45 = []
  der_46 = []
  der_47 = []
  der_48 = []

  der_49 = []
  der_50 = []
  der_51 = []
  der_52 = []
  der_53 = []
  der_54 = []
  der_55 = []
  der_56 = []
  der_57 = []
  der_58 = []
  der_59 = []
  der_60 = []

  der_61 = []
  der_62 = []
  der_63 = []
  der_64 = []
  der_65 = []
  der_66 = []
  der_67 = []
  der_68 = []
  der_69 = []
  der_70 = []
  der_71 = []
  der_72 = []

  der_73 = []
  der_74 = []
  der_75 = []
  der_76 = []
  der_77 = []
  der_78 = []
  der_79 = []
  der_80 = []
  der_81 = []
  der_82 = []
  der_83 = []
  der_84 = []

  der_85 = []
  der_86 = []
  der_87 = []
  der_88 = []
  der_89 = []
  der_90 = []
  der_91 = []
  der_92 = []
  der_93 = []
  der_94 = []
  der_95 = []
  der_96 = []

  der_97 = []
  der_98 = []
  der_99 = []
  der_100 = []
  der_101 = []
  der_102 = []
  der_103 = []
  der_104 = []
  der_105 = []
  der_106 = []
  der_107 = []
  der_108 = []


  for i in 1:length(a.u)
    push!(vals_1, a.u[i][1].value)
    push!(vals_2, a.u[i][2].value)
    push!(vals_3, a.u[i][3].value)
    push!(vals_4, a.u[i][4].value)
    push!(vals_5, a.u[i][5].value)
    push!(vals_6, a.u[i][6].value)
    push!(vals_7, a.u[i][7].value)
    push!(vals_8, a.u[i][8].value)
    push!(vals_9, a.u[i][9].value)

    push!(der_1, a.u[i][1].partials[1])
    push!(der_2, a.u[i][1].partials[2])
    push!(der_3, a.u[i][1].partials[3])
    push!(der_4, a.u[i][1].partials[4])
    push!(der_5, a.u[i][1].partials[5])
    push!(der_6, a.u[i][1].partials[6])
    push!(der_7, a.u[i][1].partials[7])
    push!(der_8, a.u[i][1].partials[8])
    push!(der_9, a.u[i][1].partials[9])
    push!(der_10, a.u[i][1].partials[10])
    push!(der_11, a.u[i][1].partials[11])
    push!(der_12, a.u[i][1].partials[12])


    push!(der_13, a.u[i][2].partials[1])
    push!(der_14, a.u[i][2].partials[2])
    push!(der_15, a.u[i][2].partials[3])
    push!(der_16, a.u[i][2].partials[4])
    push!(der_17, a.u[i][2].partials[5])
    push!(der_18, a.u[i][2].partials[6])
    push!(der_19, a.u[i][2].partials[7])
    push!(der_20, a.u[i][2].partials[8])
    push!(der_21, a.u[i][2].partials[9])
    push!(der_22, a.u[i][2].partials[10])
    push!(der_23, a.u[i][2].partials[11])
    push!(der_24, a.u[i][2].partials[12])

    push!(der_25, a.u[i][3].partials[1])
    push!(der_26, a.u[i][3].partials[2])
    push!(der_27, a.u[i][3].partials[3])
    push!(der_28, a.u[i][3].partials[4])
    push!(der_29, a.u[i][3].partials[5])
    push!(der_30, a.u[i][3].partials[6])
    push!(der_31, a.u[i][3].partials[7])
    push!(der_32, a.u[i][3].partials[8])
    push!(der_33, a.u[i][3].partials[9])
    push!(der_34, a.u[i][3].partials[10])
    push!(der_35, a.u[i][3].partials[11])
    push!(der_36, a.u[i][3].partials[12])

    push!(der_37, a.u[i][4].partials[1])
    push!(der_38, a.u[i][4].partials[2])
    push!(der_39, a.u[i][4].partials[3])
    push!(der_40, a.u[i][4].partials[4])
    push!(der_41, a.u[i][4].partials[5])
    push!(der_42, a.u[i][4].partials[6])
    push!(der_43, a.u[i][4].partials[7])
    push!(der_44, a.u[i][4].partials[8])
    push!(der_45, a.u[i][4].partials[9])
    push!(der_46, a.u[i][4].partials[10])
    push!(der_47, a.u[i][4].partials[11])
    push!(der_48, a.u[i][4].partials[12])

    push!(der_49, a.u[i][5].partials[1])
    push!(der_50, a.u[i][5].partials[2])
    push!(der_51, a.u[i][5].partials[3])
    push!(der_52, a.u[i][5].partials[4])
    push!(der_53, a.u[i][5].partials[5])
    push!(der_54, a.u[i][5].partials[6])
    push!(der_55, a.u[i][5].partials[7])
    push!(der_56, a.u[i][5].partials[8])
    push!(der_57, a.u[i][5].partials[9])
    push!(der_58, a.u[i][5].partials[10])
    push!(der_59, a.u[i][5].partials[11])
    push!(der_60, a.u[i][5].partials[12])

    push!(der_61, a.u[i][6].partials[1])
    push!(der_62, a.u[i][6].partials[2])
    push!(der_63, a.u[i][6].partials[3])
    push!(der_64, a.u[i][6].partials[4])
    push!(der_65, a.u[i][6].partials[5])
    push!(der_66, a.u[i][6].partials[6])
    push!(der_67, a.u[i][6].partials[7])
    push!(der_68, a.u[i][6].partials[8])
    push!(der_69, a.u[i][6].partials[9])
    push!(der_70, a.u[i][6].partials[10])
    push!(der_71, a.u[i][6].partials[11])
    push!(der_72, a.u[i][6].partials[12])

    push!(der_73, a.u[i][7].partials[1])
    push!(der_74, a.u[i][7].partials[2])
    push!(der_75, a.u[i][7].partials[3])
    push!(der_76, a.u[i][7].partials[4])
    push!(der_77, a.u[i][7].partials[5])
    push!(der_78, a.u[i][7].partials[6])
    push!(der_79, a.u[i][7].partials[7])
    push!(der_80, a.u[i][7].partials[8])
    push!(der_81, a.u[i][7].partials[9])
    push!(der_82, a.u[i][7].partials[10])
    push!(der_83, a.u[i][7].partials[11])
    push!(der_84, a.u[i][7].partials[12])

    push!(der_85, a.u[i][8].partials[1])
    push!(der_86, a.u[i][8].partials[2])
    push!(der_87, a.u[i][8].partials[3])
    push!(der_88, a.u[i][8].partials[4])
    push!(der_89, a.u[i][8].partials[5])
    push!(der_90, a.u[i][8].partials[6])
    push!(der_91, a.u[i][8].partials[7])
    push!(der_92, a.u[i][8].partials[8])
    push!(der_93, a.u[i][8].partials[9])
    push!(der_94, a.u[i][8].partials[10])
    push!(der_95, a.u[i][8].partials[11])
    push!(der_96, a.u[i][8].partials[12])

    push!(der_97, a.u[i][9].partials[1])
    push!(der_98, a.u[i][9].partials[2])
    push!(der_99, a.u[i][9].partials[3])
    push!(der_100, a.u[i][9].partials[4])
    push!(der_101, a.u[i][9].partials[5])
    push!(der_102, a.u[i][9].partials[6])
    push!(der_103, a.u[i][9].partials[7])
    push!(der_104, a.u[i][9].partials[8])
    push!(der_105, a.u[i][9].partials[9])
    push!(der_106, a.u[i][9].partials[10])
    push!(der_107, a.u[i][9].partials[11])
    push!(der_108, a.u[i][9].partials[12])

end

labels =[   "M", "E", "pE", "ppE", "Pt",  "E_M", "pE_M", "pE_Pt", "ppE_Pt" ]
plt = plot(grid = "off", xlab = "Time", legend = :outerright)
    plot!(a.t, vals_1, label = labels[1])
    plot!(a.t, vals_2, label = labels[2])
    plot!(a.t, vals_3, label = labels[3])
    plot!(a.t, vals_4, label = labels[4])
    plot!(a.t, vals_5, label = labels[5])
    plot!(a.t, vals_6, label = labels[6])
    plot!(a.t, vals_7, label = labels[7])
    plot!(a.t, vals_8, label = labels[8])
    plot!(a.t, vals_9, label = labels[9])


plt1 = plot(grid = "off", xlab = "Time")
    plot!(a.t, der_1, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_2, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_3, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_4, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_5, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_6, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_7, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_8, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_9, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_10, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_11, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_12, linestyle = :dash, color = :blue, label = "")

plt2 = plot(grid = "off", xlab = "Time")
    plot!(a.t, der_13, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_14, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_15, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_16, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_17, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_18, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_19, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_20, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_21, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_22, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_23, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_24, linestyle = :dash, color = :blue, label = "")


plt3 = plot(grid = "off", xlab = "Time")
    plot!(a.t, der_25, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_26, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_27, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_28, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_29, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_30, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_31, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_32, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_33, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_34, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_35, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_36, linestyle = :dash, color = :blue, label = "")


plt4 = plot(grid = "off", xlab = "Time")
    plot!(a.t, der_37, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_38, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_39, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_40, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_41, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_42, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_43, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_44, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_45, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_46, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_47, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_48, linestyle = :dash, color = :blue, label = "")


plt5 = plot(grid = "off", xlab = "Time")
    plot!(a.t, der_49, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_50, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_51, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_52, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_53, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_54, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_55, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_56, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_57, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_58, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_59, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_60, linestyle = :dash, color = :blue, label = "")


plt6 = plot(grid = "off", xlab = "Time")
    plot!(a.t, der_61, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_62, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_63, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_64, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_65, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_66, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_67, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_68, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_69, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_70, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_71, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_72, linestyle = :dash, color = :blue, label = "")


plt7 = plot(grid = "off", xlab = "Time")
    plot!(a.t, der_73, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_74, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_75, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_76, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_77, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_78, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_79, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_80, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_81, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_82, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_83, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_84, linestyle = :dash, color = :blue, label = "")

plt8 = plot(grid = "off", xlab = "Time")
    plot!(a.t, der_85, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_86, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_87, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_88, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_89, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_90, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_91, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_92, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_93, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_94, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_95, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_96, linestyle = :dash, color = :blue, label = "")

plt9 = plot(grid = "off", xlab = "Time")
    plot!(a.t, der_97, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_98, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_99, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_100, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_101, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_102, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_103, linestyle = :dash, color = :blue, label = "")
    plot!(a.t, der_104, linestyle = :dash, color = :orange, label = "")
    plot!(a.t, der_105, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_106, linestyle = :dash, color = :green, label = "")
    plot!(a.t, der_107, linestyle = :dash, color = :red, label = "")
    plot!(a.t, der_108, linestyle = :dash, color = :blue, label = "")


plot(plt1, plt2, plt3, plt4, plt5, plt6, plt7, plt8, plt9)
  savefig("Doc_progress_MAP_Kinase/ODE_case_partials.pdf")

plot(plt)
  savefig("Doc_progress_MAP_Kinase/ODE_case_value.pdf")
