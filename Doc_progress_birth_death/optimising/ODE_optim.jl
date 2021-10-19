using DifferentialEquations, Optim, Plots

function f(du,u,p,t)
  du[1] = (p[1]-p[2])*u[1]
end

function diff_ode(p)
  prob = ODEProblem(f, [0.2], (0.0,10.0), p)
  sol = solve(prob, Tsit5(),saveat=0.4)
  return [sol.u[i][1] for i in 1:length(sol)]
end

p_1 = [1.,1.5]
data = diff_ode(p_1)

function loss(p)
  return sum(abs2, diff_ode(p) .- data)
end

opt_out = optimize(loss, [1.3, 1.4])
res = Optim.minimizer(opt_out)

prob = ODEProblem(f, [0.2], (0.0,10.0), res)
sol = solve(prob, Tsit5(),saveat=0.4)
d = [sol.u[i][1] for i in 1:length(sol)]
scatter(data)
plot!(d)

savefig("Doc_progress/plots/ODE_optim.pdf")
