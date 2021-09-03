using DifferentialEquations, DiffEqJump, Plots

function f(du,u,p,t)
  du[1] = u[1]
end

prob = ODEProblem(f,[0.2],(0.0,10.0))

rate(u,p,t) = 2

affect!(integrator) = (integrator.u[1] = integrator.u[1]/2)

jump = ConstantRateJump(rate,affect!)

jump_prob = JumpProblem(prob,Direct(),jump)

sol = solve(jump_prob,Tsit5())
plot(sol)
