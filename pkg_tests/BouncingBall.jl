### simulate forward

using ForwardDiff, Zygote, OrdinaryDiffEq, DiffEqSensitivity
using Plots#, LaTeXStrings

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
# savefig(pl,"BB_forward_no_bounce.png")



# solve with DiscreteCallback (explicit event)
tstar = (v0 + sqrt(v0^2+2*z0*g))/g
condition1(u,t,integrator) = (t == tstar)
affect!(integrator) = integrator.u[2] = -integrator.p[2]*integrator.u[2]
cb1 = DiscreteCallback(condition1,affect!,save_positions=(true,true))

sol1 = solve(prob,Tsit5(),callback=cb1, saveat=0.1, tstops=[tstar])

# solve with ContinuousCallback (implicit event)
condition2(u,t,integrator) = u[1] # Event happens when condition2(u,t,integrator) == 0
cb2 = ContinuousCallback(condition2,affect!,save_positions=(true,true))
sol2 = solve(prob,Tsit5(),callback=cb2,saveat=0.1)

# plot forward trajectory
pl1 = plot(sol1, label = ["z(t)" "v(t)"], title="explicit event", labelfontsize=20, legendfontsize=20, lw = 2, xlabel = "t", legend=:bottomright)
pl2 = plot(sol2, label = ["z(t)" "v(t)"], title="implicit event", labelfontsize=20, legendfontsize=20, lw = 2, xlabel = "t", legend=:bottomright)
hline!(pl1, [0.0], label=false, color="black")
hline!(pl2, [0.0], label=false, color="black")
pl = plot(pl1,pl2)
# savefig(pl,"BB_forward.png")


# animate forward trajectory
sol3 = solve(remake(prob,u0=[u0[1]+0.5,u0[2]]),Tsit5(),callback=cb2,saveat=0.01)

plt2 = plot(sol2, label = false, labelfontsize=20, legendfontsize=20, lw = 1, xlabel = "t", legend=:bottomright, color="black", xlims=(t0,tend))
hline!(plt2, [0.0], label=false, color="black")
plot!(plt2, sol3, tspan=(t0,tend), color=[1 2], label = ["z(t)" "v(t)"], labelfontsize=20, legendfontsize=20, lw = 2, xlabel = "t", legend=:bottomright, denseplot=true, xlims=(t0,tend), ylims=(-11,9))
# scatter!(plt2, [t2,t2], sol3(t2), color=[1, 2], label=false)

list_plots = []
for t in sol3.t
  tstart = 0.0

  plt1 = plot(sol2, label = false, labelfontsize=20, legendfontsize=20, lw = 1, xlabel = "t", legend=:bottomright, color="black")
  hline!(plt1, [0.0], label=false, color="black")
  plot!(plt1, sol3, tspan=(t0,t), color=[1 2], label = ["z(t)" "v(t)"], labelfontsize=20, legendfontsize=20, lw = 2, xlabel = "t", legend=:bottomright, denseplot=true, xlims=(t0,tend), ylims=(-11,9))
  scatter!(plt1,[t,t], sol3(t), color=[1, 2], label=false)
  plt = plot(plt1,plt2)
  push!(list_plots, plt)
end

plot(list_plots[100])

anim = animate(list_plots,every=1)
