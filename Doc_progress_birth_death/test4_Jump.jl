using DifferentialEquations, DiffEqJump, Plots, ForwardDiff
import ForwardDiff: Dual
function diffs_variable(p) # 3d u sol for ode, jump1 and jump2
    function f(du,u,p,t)
        du[1] = u[1]*0.0000001
    end
    brith_rate(u,p,t) = p[1]*u[1]
    brith_affect!(integrator) = (integrator.u[1] = integrator.u[1]+1)
    brith_jump = VariableRateJump(brith_rate, brith_affect!)
    death_rate(u,p,t) = p[2]*u[1]
    death_affect!(integrator) = (integrator.u[1] = integrator.u[1]-1)
    death_jump = VariableRateJump(death_rate, death_affect!)
    prob = ODEProblem(f, convert.(eltype(p), [0.2]), (0.0,10.0), p)
    jump_prob = JumpProblem(prob, Direct(), brith_jump, death_jump)
    sol = solve(jump_prob, Tsit5())
    return sol
end


data = ones(44)
L2_loss_fct(p) = sum(abs2, diffs_variable(p) .- data)
ForwardDiff.gradient(L2_loss_fct, [1.,1.5])

vals = []
der_1 = []
der_2 = []
ts = []

p_1 = [1.,1.5]
p_2 = [Dual{Float64}(1.,(1.,0.)), Dual{Float64}(1.5,(0.,1.))]

a = diffs_variable(p_1)
a.u[:][1]
a = diffs_variable(p_2)


for i in 1:length(a.u)
  push!(vals, a.u[i][1].value)
  push!(der_1, a.u[i][1].partials[1])
  push!(der_2, a.u[i][1].partials[2])
  push!(ts, a.t[i].value)
end
plt = plot(grid = "off", xlab = "Time")
  plot!(ts, vals, label = "U", color = :blue)
  plot!(ts, der_1, linestyle = :dash, color = :green, label = "Partial birth")
  plot!(ts, der_2, linestyle = :dash, color = :red, label = "Partial death")

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
