using DifferentialEquations, DiffEqJump, Plots, Optim
function diffs_variable(p)
    function f(du,u,p,t)
        du[1] = u[1]*0.0000001
    end
    brith_rate(u,p,t) = p[1]*u[1]
    brith_affect!(integrator) = (integrator.u[1] = integrator.u[1]+1)
    brith_jump = VariableRateJump(brith_rate, brith_affect!)
    death_rate(u,p,t) = p[2]*u[1]
    death_affect!(integrator) = (integrator.u[1] = integrator.u[1]-1)
    death_jump = VariableRateJump(death_rate, death_affect!)
    prob = ODEProblem(f, convert.(eltype(p), [0.2]), (0.0,10.0), p)
    jump_prob = JumpProblem(prob, Direct(), brith_jump, death_jump)
    sol = solve(jump_prob, Tsit5())(Array(range(0., stop = 10, step = 0.1))
)
    return sol
end
p_1 = [1., 1.5]
sol_diffs = diffs_variable(p_1)
plot(sol_diffs)

ts = Array(range(0., stop = 10, step = 0.1))
data_raw = diffs_variable(p_1)
data_vals = []
for i in 1:101
    v = data_raw.u[i][1]
    push!(data_vals, v)
end
function loss(p)
    sol_j = diffs_variable(p)
    vals = []
    for i in 1:101
        v = sol_j.u[i][1]
        push!(vals, v)
    end
  return sum(abs2, vals .- data_vals)
end

opt_out = optimize(loss, [1.3, 1.4], iterations = 100000)
res = Optim.minimizer(opt_out)
sol_res = diffs_variable(res)

vals = []
for i in 1:101
    v = sol_res.u[i][1]
    push!(vals, v)
end

scatter(data_vals, label = "Data")
    plot!(vals, label = "Learnt")


savefig("Doc_progress_birth_death/plots/optim_gradient_free/Jump_case.pdf")

a = [1,2,3]
b = [1,2,3]

a.-b
