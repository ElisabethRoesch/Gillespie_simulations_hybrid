using DifferentialEquations, DiffEqJump, Plots, ForwardDiff
import ForwardDiff: Dual


function f(du,u,p,t)
  du[1] = (p[1]-p[2])*u[1]+p[3]
end
prob = ODEProblem(f, [0.2], (0.0,10.0), [1.,0.1,0.1])

function diffs(x)
  rate(u,p,t) = x[1]+u[1]
  affect!(integrator) = (integrator.u[1] = integrator.u[1]/2)
  jump = VariableRateJump(rate, affect!)
  jump_prob = JumpProblem(prob, Direct(), jump)
  sol = solve(jump_prob, Tsit5())
  return sol
end

x_1 = [1.]
diffs(x_1)
g = xx -> ForwardDiff.gradient(diffs, x_1); # g = ∇f
g(x_1)


x_2 = Dual{Float64}(1.,1.)
diffs(x_2)
