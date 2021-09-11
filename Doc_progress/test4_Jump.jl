
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
