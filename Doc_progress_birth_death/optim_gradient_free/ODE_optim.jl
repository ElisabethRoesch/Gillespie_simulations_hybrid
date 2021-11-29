using DifferentialEquations, Optim, Plots

function f(du,u,p,t)
  du[1] = (p[1]-p[2])*u[1]
end

function diff_ode(p)
  prob = ODEProblem(f, [2.], (0.0,10.0), p)
  sol = solve(prob, Tsit5(), saveat=0.1)
  return [sol.u[i][1] for i in 1:length(sol)]
end

p_1 = [1.,1.5]
data = diff_ode(p_1)

function loss(p)
  return sum(abs2, diff_ode(p) .- data)
end

opt_out = Optim.optimize(loss, [0., 0.])
res = Optim.minimizer(opt_out)

opt_out.minimum

prob = ODEProblem(f, [2], (0.0,10.0), res)
sol = solve(prob, Tsit5(),saveat=0.1)
d = [sol.u[i][1] for i in 1:length(sol)]

scatter(data[Array(range(1, stop = 100, step = 2))], label = "", grid = "off", xlabel = "Time", color ="grey", size = (400,300))
  plot!(d[Array(range(1, stop = 100, step = 2))], label = "", color = "#82B366", linewidth=3)
  scatter!(data[Array(range(1, stop = 100, step = 2))], label = "", color ="grey")

savefig("Doc_progress_birth_death/plots/optim_gradient_free/ODE_optim.pdf")
