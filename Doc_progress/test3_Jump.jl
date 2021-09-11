using DifferentialEquations, DiffEqJump, Plots, ForwardDiff
import ForwardDiff: Dual

function diffs_variable(p)
  function f(du,u,p,t)
    du[1] = u[1]*0.0000001
  end
  brith_rate(u,p,t) = p[1]
  brith_affect!(integrator) = (integrator.u[1] = integrator.u[1]+1)
  brith_jump = VariableRateJump(brith_rate, brith_affect!)
  death_rate(u,p,t) = p[2]
  death_affect!(integrator) = (integrator.u[1] = integrator.u[1]-1)
  death_jump = VariableRateJump(death_rate, death_affect!)
  prob = ODEProblem(f, [0.2], (0.0,10.0), p)
  jump_prob = JumpProblem(prob, Direct(), brith_jump, death_jump)
  sol = solve(jump_prob, Tsit5())
  return sol
end

p_1 = [1., 1.5]
sol_diffs = diffs_variable(p_1)
plot(sol_diffs)

p_2 = [Dual{Float64}(1.,(1.,0.)), Dual{Float64}(1.5,(0.,1.))]
a = diffs_variable(p_2)
