using DifferentialEquations, Optim, Plots, Statistics

function f(du,u,p,t)
  du[1] = (p[1]-p[2])*u[1]
end

function g(du,u,p,t)
  du[1] = 0.3*u[1]
end

function diff_sde(p)
  prob = SDEProblem(f, g, [0.2], (0.0,10.0), p)
  sol = solve(prob, Tsit5(),saveat=0.4)
  return [sol.u[i][1] for i in 1:length(sol)]
end
function diffs_sde(p)
  n_sols = 10
  sols = []
  for i in 1:n_sols
    push!(sols, diff_sde(p))
  end
  ms = []
  for time_point_i in 1:length(sols[1])
      sols_time_point_i = [sols[sol_iteration_j][time_point_i] for sol_iteration_j in 1:length(sols)]
      push!(ms, mean(sols_time_point_i))
  end
  return ms
end

p_1 = [1,1.5]
data = diff_sde(p_1)
scatter(data)

function loss(p)
  if length(diffs_sde(p)) == length(data)
      return sum(abs2, diffs_sde(p) .- data)
  else
      return 100000
  end
end

opt_out = optimize(loss, [0.3, 0.4])
res = Optim.minimizer(opt_out)

sol = diffs_sde(res)
scatter(data, label = "Data")
plot!(sol, label = "Learnt")
savefig("Doc_progress/plots/optim_gradient_free/SDE_optim.pdf")
