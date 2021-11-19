using DifferentialEquations, ForwardDiff, Plots
using ForwardDiff:Dual
# (m_1 ,p_1 ,m_2 ,p_2, m_3, p_3) = (0, 2, 0, 1, 0, 3)
function f(du,u,p,t)
  alpha_0, n, beta, alpha = p
  m_1, p_1, m_2, p_2, m_3, p_3 = u
  du[1] = -m_1 + alpha/(1+p_3^n)+alpha_0 #dm_1
  du[2] = -beta*(p_1-m_1) #dp1_1
  du[3] = -m_2+alpha/(1+p_1^n)+alpha_0 #d_m2
  du[4] = -beta*(p_2-m_2) # dp_2
  du[5] = -m_3+alpha/(1+p_2^n)+alpha_0 # dm_3
  du[6] = -beta*(p_3-m_3) # dp_3
  return du
end

function diff_ode(p)
  prob = ODEProblem(f, [0.,2,0,1,0,3], (0.0,10.0), p)
  solve(prob, Tsit5())
end

p_2 = [ Dual{Float64}(1. ,(1., 0., 0., 0.)),
        Dual{Float64}(2. ,(0., 1., 0., 0.)),
        Dual{Float64}(5. ,(0., 0., 1., 0.)),
        Dual{Float64}(1000. ,(0., 0., 0., 1.))]

a = diff_ode(p_2)
vals_1 = []
  vals_2 = []
  vals_3 = []
  vals_4 = []
  vals_5 = []
  vals_6 = []

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

for i in 1:length(a.u)
  push!(vals_1, a.u[i][1].value)
  push!(vals_2, a.u[i][2].value)
  push!(vals_3, a.u[i][3].value)
  push!(vals_4, a.u[i][4].value)
  push!(vals_5, a.u[i][5].value)
  push!(vals_6, a.u[i][6].value)


  push!(der_1, a.u[i][1].partials[1])
  push!(der_2, a.u[i][1].partials[2])
  push!(der_3, a.u[i][1].partials[3])
  push!(der_4, a.u[i][1].partials[4])

  push!(der_5, a.u[i][2].partials[1])
  push!(der_6, a.u[i][2].partials[2])
  push!(der_7, a.u[i][2].partials[3])
  push!(der_8, a.u[i][2].partials[4])

  push!(der_9, a.u[i][3].partials[1])
  push!(der_10, a.u[i][3].partials[2])
  push!(der_11, a.u[i][3].partials[3])
  push!(der_12, a.u[i][3].partials[4])

  push!(der_13, a.u[i][4].partials[1])
  push!(der_14, a.u[i][4].partials[2])
  push!(der_15, a.u[i][4].partials[3])
  push!(der_16, a.u[i][4].partials[4])

  push!(der_17, a.u[i][5].partials[1])
  push!(der_18, a.u[i][5].partials[2])
  push!(der_19, a.u[i][5].partials[3])
  push!(der_20, a.u[i][5].partials[4])

  push!(der_21, a.u[i][6].partials[1])
  push!(der_22, a.u[i][6].partials[2])
  push!(der_23, a.u[i][6].partials[3])
  push!(der_24, a.u[i][6].partials[4])

end

plt = plot(grid = "off", xlab = "Time")
  scatter!(a.t, vals_1, label = "m_1")
  plot!(a.t, vals_2, label = "p_1",linestyle = :dash)
  scatter!(a.t, vals_3, label = "m_2")
  plot!(a.t, vals_4, label = "p_2")
  scatter!(a.t, vals_5, label = "m_3")
  plot!(a.t, vals_6, label = "p_3",linestyle = :dash)


plt1 = plot(grid = "off", xlab = "Time")
  plot!(a.t, der_1, linestyle = :dash, color = :green, label = "")
  plot!(a.t, der_2, linestyle = :dash, color = :red, label = "")
  plot!(a.t, der_3, linestyle = :dash, color = :blue, label = "")
  plot!(a.t, der_4, linestyle = :dash, color = :orange, label = "")


plt2 = plot(grid = "off", xlab = "Time")
  plot!(a.t, der_5, linestyle = :dash, color = :green, label = "")
  plot!(a.t, der_6, linestyle = :dash, color = :red, label = "")
  plot!(a.t, der_7, linestyle = :dash, color = :blue, label = "")
  plot!(a.t, der_8, linestyle = :dash, color = :orange, label = "")


plt3 = plot(grid = "off", xlab = "Time")
  plot!(a.t, der_9, linestyle = :dash, color = :green, label = "")
  plot!(a.t, der_10, linestyle = :dash, color = :red, label = "")
  plot!(a.t, der_11, linestyle = :dash, color = :blue, label = "")
  plot!(a.t, der_12, linestyle = :dash, color = :orange, label = "")


plt4 = plot(grid = "off", xlab = "Time")
  plot!(a.t, der_13, linestyle = :dash, color = :green, label = "")
  plot!(a.t, der_14, linestyle = :dash, color = :red, label = "")
  plot!(a.t, der_15, linestyle = :dash, color = :blue, label = "")
  plot!(a.t, der_16, linestyle = :dash, color = :orange, label = "")


plt5 = plot(grid = "off", xlab = "Time")
  plot!(a.t, der_17, linestyle = :dash, color = :green, label = "")
  plot!(a.t, der_18, linestyle = :dash, color = :red, label = "")
  plot!(a.t, der_19, linestyle = :dash, color = :blue, label = "")
  plot!(a.t, der_20, linestyle = :dash, color = :orange, label = "")


plt6 = plot(grid = "off", xlab = "Time")
  plot!(a.t, der_21, linestyle = :dash, color = :green, label = "")
  plot!(a.t, der_22, linestyle = :dash, color = :red, label = "")
  plot!(a.t, der_23, linestyle = :dash, color = :blue, label = "")
  plot!(a.t, der_24, linestyle = :dash, color = :orange, label = "")

plot(plt1, plt2, plt3, plt4, plt5, plt6)
savefig("Doc_progress_Repressilator/plots/ODE_case_partials_10.pdf")

plot(plt)
savefig("Doc_progress_Repressilator/plots/ODE_case_value_10.pdf")
