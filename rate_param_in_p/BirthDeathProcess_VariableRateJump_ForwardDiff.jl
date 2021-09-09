using DifferentialEquations, DiffEqJump, Plots, ForwardDiff
import ForwardDiff: Dual


function f(du,u,p,t)
  du[1] = 0
end
IC = [5.]


function diffs_variable(p)
  brith_rate(u,p,t) = p[1]
  brith_affect!(integrator) = (integrator.u[1] = integrator.u[1]+1)
  brith_jump = VariableRateJump(brith_rate, brith_affect!)
  death_rate(u,p,t) = p[2]
  death_affect!(integrator) = (integrator.u[1] = integrator.u[1]-1)
  death_jump = VariableRateJump(death_rate, death_affect!)
  prob = ODEProblem(f, IC, (0.0,100.0), p)
  jump_prob = JumpProblem(prob, Direct(), brith_jump, death_jump)
  sol = solve(jump_prob, Tsit5())
  return sol
end

p_1 = [1., 1.]
sol_diffs = diffs_variable(p_1)
plot(sol_diffs)


p_2 = [Dual{Float64}(1.,1.), Dual{Float64}(1.,1.)]
sol_diffs = diffs_variable(p_2)


g = ForwardDiff.gradient(diffs_variable, p_1)
g = ForwardDiff.gradient(diffs_variable, p_2)

using Statistics
means = []
ends = []
for i in 1:10000
  x_1 = [1.,1.]
  sol = diffs_variable(x_1)
  push!(means, mean(sol.u)[1])
  push!(ends, sol.u[end][1])
end

plt = plot(grid="off", legend = :outerright)
  mean_of_means = round(mean(means))
  mean_of_ends = round(mean(ends))
  histogram!(ends, linecolor = :orange, label = "End points of simulations", alpha = 0.4, color = :orange)
  vline!([mean_of_ends], linewidth = 6, color = :orange, label = "Mean of ends: $mean_of_ends")
  histogram!(means,linecolor = :purple,  color = :purple, alpha = 0.4, label = "Means of simulations")
  vline!([mean_of_means], linewidth = 6, color = :purple, label = "Mean of means: $mean_of_means")
  vline!(IC, linewidth = 6, color = :green, label = "Starting point")
