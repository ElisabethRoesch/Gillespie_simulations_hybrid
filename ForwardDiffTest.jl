using ForwardDiff
import ForwardDiff: Dual

# Doc example
f(x::Vector) = sum(sin, x) + prod(tan, x) * sum(sqrt, x);
x = rand(5) # small size for example's sake
g = x -> ForwardDiff.gradient(f, x); # g = ∇f
g(x)



# My test
function test(x)
  x[1]^2
end
x_1 = [1.]
test(x_1)
g = xx -> ForwardDiff.gradient(test, x_1); # g = ∇f
g(x_1)

x_2 = Dual{Float64}(1.,1.)
test(x_2)


# ODE test: Dual + ForwardDiff
using DifferentialEquations
function f(du,u,p,t)
  du[1] = (p[1]-p[2])*u[1]+p[3]
end
function diff_ode(p)
  prob = ODEProblem(f, [0.2], (0.0,10.0), p)
  solve(prob, Tsit5())
end


p_2 = [Dual{Float64}(1.,(1.,0.,0.)), Dual{Float64}(1.,(0.,1.,0.)), Dual{Float64}(1.,(0.,0.,1.))]
a = diff_ode(p_2)

vals = []
for i in 1:length(a.u)
  push!(vals, a.u[i][1].value)
end
plot(a.t, vals)




# My test 2D dual for easy f
function test2din(p)
  p[1]*p[1]*p[2] + p[1] + p[2]
end
a = Dual{Float64}(1., (1.,0.))
b = Dual{Float64}(2., (0.,1.))
p1 = [a,b]
r = test2din(p1)

# My test 2D dual for easy f
function test2dout(p)
  return p[1]^2, p[2]
end
p_test2d1 = [Dual{Float64}(1.,(1.)), Dual{Float64}(1.,(1.))]
test2dout(p_test2d1)
