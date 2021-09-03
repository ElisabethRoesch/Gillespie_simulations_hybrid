using  DiffEqBiological, Plots

rs = @reaction_network begin
  c1, X --> 2X
  c2, X --> 0
  c3, 0 --> X
end c1 c2 c3
params = (1.0, 2.0, 50.)
tspan = (0., 4.)
u0 = [5.]


# solve JumpProblem using Gillespie's Direct Method
u0 = [5]
dprob = DiscreteProblem(rs, u0, tspan, params)
jprob = JumpProblem(dprob, Direct(), rs)
jsol = solve(jprob, SSAStepper())

plot(jsol)
