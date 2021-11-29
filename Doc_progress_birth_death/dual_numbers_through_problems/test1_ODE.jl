using DifferentialEquations, ForwardDiff, Plots
using ForwardDiff:Dual

function f(du,u,p,t)
  du[1] = (p[1]-p[2])*u[1]
end

function diff_ode(p)
  prob = ODEProblem(f, [2.], (0.0,10.0), p)
  solve(prob, Tsit5(), saveat=0.1)
end

p_2 = [Dual{Float64}(1.,(1., 0.)), Dual{Float64}(1.5,(0., 1.))]
a = diff_ode(p_2)

vals = []
der_1 = []
der_2 = []
for i in 1:length(a.u)
  push!(vals, a.u[i][1].value)
  push!(der_1, a.u[i][1].partials[1])
  push!(der_2, a.u[i][1].partials[2])
end




col_purple = "#9673A6"
col_orange = "#D79B00"
col_green = "#82B366"


col_yellow = "#D6B656"
col_grey ="#666666"
col_red = "#B85450"
col_blue = "#6C8EBF"


plt = plot(grid = "off", xlab = "Time")
  plot!(a.t[Array(range(1, stop = 100, step = 2))], vals[Array(range(1, stop = 100, step = 2))], label = "", color = col_blue, linewidth = 2) # label = "U"
  plot!(a.t[Array(range(1, stop = 100, step = 2))], der_1[Array(range(1, stop = 100, step = 2))], linestyle = :dash, color = col_green, label = "") # label = "Partial birth"
  plot!(a.t[Array(range(1, stop = 100, step = 2))], der_2[Array(range(1, stop = 100, step = 2))], linestyle = :dash, color = col_red, label = "") # label = "Partial death"

savefig("Doc_progress_birth_death/plots/ODE_case.pdf")
