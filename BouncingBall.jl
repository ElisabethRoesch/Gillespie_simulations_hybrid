### simulate forward

using ForwardDiff, Zygote, OrdinaryDiffEq, DiffEqSensitivity
using Plots, LaTeXStrings

# dynamics
function f(du,u,p,t)
  du[1] = u[2]
  du[2] = -p[1]
end

# parameters and solve
z0 = 5.0
v0 = -0.1
t0 = 0.0
tend = 1.9
g = 10
γ = 0.8

u0 = [z0,v0]
tspan = (t0,tend)
p = [g, γ]
prob = ODEProblem(f,u0,tspan,p)

# plot forward trajectory
sol = solve(prob,Tsit5(),saveat=0.1)
pl = plot(sol, label = ["z(t)" "v(t)"], labelfontsize=20, legendfontsize=20, lw = 2, xlabel = "t", legend=:bottomleft)
hline!(pl, [0.0], label=false, color="black")
savefig(pl,"BB_forward_no_bounce.png")
