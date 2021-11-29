using DifferentialEquations, DiffEqJump, Plots, ForwardDiff
import ForwardDiff: Dual
function diffs_variable(p)
    function f(du,u,p,t)
        du[1] = u[1]*0.0000001
    end
    brith_rate(u,p,t) = p[1]*u[1]
    brith_affect!(integrator) = (integrator.u[1] = integrator.u[1]+1)
    brith_jump = VariableRateJump(brith_rate, brith_affect!)
    death_rate(u,p,t) = p[2]*u[1]
    death_affect!(integrator) = (integrator.u[1] = integrator.u[1]-1)
    death_jump = VariableRateJump(death_rate, death_affect!)
    prob = ODEProblem(f, convert.(eltype(p), [2.]), (0.0,10.0), p)
    jump_prob = JumpProblem(prob, Direct(), brith_jump, death_jump)
    sol = solve(jump_prob, Tsit5())
    return sol
end
p_1 = [1., 1.5]
sol_diffs = diffs_variable(p_1)
plot(sol_diffs)

p_2 = [Dual{Float64}(1.,(1.,0.)), Dual{Float64}(1.5,(0.,1.))]
a = diffs_variable(p_2)
vals = []
der_1 = []
der_2 = []
ts = []
for i in 1:length(a.u)
  push!(vals, a.u[i][1].value)
  push!(der_1, a.u[i][1].partials[1])
  push!(der_2, a.u[i][1].partials[2])
  push!(ts, a.t[i].value)
end
plot(ts, vals)


plt_vals1 = plot(grid = "off", xlab = "Time", legend = :outertop)
    plot!(ts, vals, label = "U", color = :blue)
ind = Array(range(1,length(ts), step = 2))
t_new = ts[ind]
vals_new = vals[ind]
der_1_new = der_1[ind]
der_2_new = der_2[ind]


plt_vals = plot(grid = "off", xlab = "Time", legend = :outertop)
    plot!(ts, vals, label = "U", color = :blue)
plt_deriv = plot(grid = "off", xlab = "Time", legend = :outertop)
    plot!(ts, der_1, linestyle = :dash, color = :green, label = "Partial birth")
    plot!(ts, der_2, linestyle = :dash, color = :red, label = "Partial death")

plot(plt_vals, plt_deriv, layout = (2,1))




a = Array(range(1,10, step = 1))
ind = Array(range(1,10,step=2))
a[ind]

col_purple = "#9673A6"
col_orange = "#D79B00"
col_green = "#82B366"


col_yellow = "#D6B656"
col_grey ="#666666"
col_red = "#B85450"
col_blue = "#6C8EBF"


plt = plot(grid = "off", xlab = "Time")
  plot!(ts, vals, label = "", color = col_blue, linewidth = 2) # label = "U"
plt2 = plot(grid = "off", xlab = "Time")
    plot!(ts, der_1, linestyle = :dash, color = col_green, linewidth = 2, label = "") # label = "Partial birth"
    plot!(ts, der_2, linestyle = :dash, color = col_red, linewidth = 2, label = "") # label = "Partial death"

plot(plt,plt2, layout = (2,1))
savefig("Doc_progress_birth_death/plots/jump_case.pdf")




savefig("Doc_progress_birth_death/plots/Jump_case.pdf")
