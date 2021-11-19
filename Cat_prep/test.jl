
using Catalyst, DifferentialEquations
using DifferentialEquations, ForwardDiff, Plots
using ForwardDiff:Dual
rs = @reaction_network begin
  c1, S + E --> SE
  c2, SE --> S + E
  c3, SE --> P + E
end c1 c2 c3
p = (0.00166,0.0001,0.1)   # [c1,c2,c3]
tspan = (0., 100.)
u0 = [301., 100., 0., 0.]  # [S,E,SE,P]

# solve JumpProblem
dprob = DiscreteProblem(rs, species(rs) .=> u0, tspan, parameters(rs) .=> p)
jprob = JumpProblem(rs, dprob, Direct())
jsol = solve(jprob, SSAStepper())
plot(jsol,lw=2,title="Gillespie: Michaelis-Menten Enzyme Kinetics")



using Catalyst, Plots, StochasticDiffEq, DiffEqJump
rs = @reaction_network begin
  c2, X --> 0
  c3, 0 --> X
end  c2 c3
p = (1.0,1.5) # [c1,c2,c3]
p_2 = [Dual{Float64}(1.,(1., 0.)), Dual{Float64}(1.5,(0., 1.))]
tspan = (0.,10.)
u0 = [0.2]         # [X]
sprob = SDEProblem(rs, species(rs) .=> u0, tspan, parameters(rs) .=> p_2)
ssol  = solve(sprob, LambaEM(), reltol=1e-3)
plot(ssol,lw=2,title="Adaptive SDE: Birth-Death Process")
