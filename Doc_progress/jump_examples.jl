using DifferentialEquations, DiffEqJump, Plots

function f(du,u,p,t)
  du[1] = u[1]
end

prob = ODEProblem(f,[0.2],(0.0,100.0))

affect!(integrator) = (integrator.u[1] = integrator.u[1]/2)

rate1(u,p,t) = 2 + u[1]
jump1 = ConstantRateJump(rate1,affect!)
jump_prob1 = JumpProblem(prob,Direct(),jump1)
sol1 = solve(jump_prob1,Tsit5())
p1 = plot(sol1)

rate2(u,p,t) = 2 + u[1]
jump2 = VariableRateJump(rate2,affect!)
jump_prob2 = JumpProblem(prob,Direct(),jump2)
sol2 = solve(jump_prob2,Tsit5())
p2 = plot(sol2)

plot(p1,p2)
