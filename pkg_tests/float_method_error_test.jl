# See: https://discourse.julialang.org/t/error-with-forwarddiff-no-method-matching-float64/41905

using DifferentialEquations
using ForwardDiff: Dual
function SpringEqu!(du, u, x, t)
       du[1] = u[2]
       du[2] = -(x[1] / x[3]) * u[2] - (x[2] / x[3]) * u[1] + 50 / x[3]
end
xin = [2000.0 + Dual(0, (1,0,0)), 20000.0 + Dual(0, (0,1,0)), 80.0]
T = eltype(xin) # Dual{Nothing,Float64,3}
u0 = T[2.0, 0.0]
tspan = (0.0, 1.0)
prob = ODEProblem(SpringEqu!, u0, tspan, xin)
sol = solve(prob)
