using DifferentialEquations, ForwardDiff, Plots
using ForwardDiff:Dual

function f(du,u,p,t)
  du[1] = (p[1]-p[2])*u[1]
end

function g(du,u,p,t)
  du[1] = 0.1*u[1]
end

function diff_sde(p)
  prob = SDEProblem(f, g, [0.2], (0.0,10.0), p)
  solve(prob, Tsit5())
end

p_2 = [Dual{Float64}(1.,(1., 0.)), Dual{Float64}(1.5,(0., 1.))]
a = diff_sde(p_2)

vals = []
der_1 = []
der_2 = []
for i in 1:length(a.u)
  push!(vals, a.u[i][1].value)
  push!(der_1, a.u[i][1].partials[1])
  push!(der_2, a.u[i][1].partials[2])
end
plt = plot(grid = "off", xlab = "Time")
  plot!(a.t, vals, label = "U", color = :blue)
  plot!(a.t, der_1, linestyle = :dash, color = :green, label = "Partial birth")
  plot!(a.t, der_2, linestyle = :dash, color = :red, label = "Partial death")
savefig("Doc_progress/plots/SDE_case.pdf")
