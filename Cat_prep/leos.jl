using HyperGraphs, Symbolics, Simulacrum
using Simulacrum.Wip: make_equations, rn_assumptions
const ChE = ChemicalHyperEdge
const ChX = ChemicalHyperGraph
@variables t
spx = @variables M(t) E(t) pE(t) ppE(t) Pt(t)
cpx = @variables E_M(t) pE_M(t) pE_Pt(t) ppE_Pt(t)
ps = @variables k₃ k₄ k₆ k₇ k₈ k₉ k′₃ k′₄ k′₆ k′₇ k′₈ k′₉
x = ChX{Num}()
add_vertices!(x, vcat(spx, cpx))
rxs =   [
        # phosphorylation
        ChE([E, M], [E_M], k₃),         # binding
        ChE([E_M], [E, M], k₄),         # unbinding
        ChE([E_M], [pE, M], k₇),        # phosphorylation #1
        ChE([pE, M], [pE_M], k₈),       # binding
        ChE([pE_M], [pE, M], k₉),       # unbinding
        ChE([pE_M], [ppE, M], k₆),      # phosphorylation #2

        # dephosphorylation
        ChE([ppE, Pt], [ppE_Pt], k′₃),  # binding
        ChE([ppE_Pt], [ppE, Pt], k′₄),  # unbinding
        ChE([ppE_Pt], [pE, Pt], k′₇),   # dephosphorylation #1
        ChE([pE, Pt], [pE_Pt], k′₈),    # binding
        ChE([pE_Pt], [pE, Pt], k′₉),    # unbinding
        ChE([pE_Pt], [E, Pt], k′₆)      # dephosphorylation #2
        ]
add_hyperedges!(x, rxs)
a = make_equations(x, rn_assumptions)




Differential(t)(M(t)) ~ k₄*E_M(t) + k₇*E_M(t) + k₆*pE_M(t) + k₉*pE_M(t) - k₃*E(t)*M(t) - k₈*M(t)*pE(t)
 Differential(t)(E(t)) ~ k′₆*pE_Pt(t) + k₄*E_M(t) - k₃*E(t)*M(t)
 Differential(t)(pE(t)) ~ k₇*E_M(t) + k₉*pE_M(t) + k′₉*pE_Pt(t) + k′₇*ppE_Pt(t) - k₈*M(t)*pE(t) - k′₈*Pt(t)*pE(t)
 Differential(t)(ppE(t)) ~ k′₄*ppE_Pt(t) + k₆*pE_M(t) - k′₃*Pt(t)*ppE(t)
 Differential(t)(Pt(t)) ~ k′₄*ppE_Pt(t) + k′₆*pE_Pt(t) + k′₉*pE_Pt(t) + k′₇*ppE_Pt(t) - k′₃*Pt(t)*ppE(t) - k′₈*Pt(t)*pE(t)
 Differential(t)(E_M(t)) ~ k₃*E(t)*M(t) - k₄*E_M(t) - k₇*E_M(t)
 Differential(t)(pE_M(t)) ~ k₈*M(t)*pE(t) - k₆*pE_M(t) - k₉*pE_M(t)
 Differential(t)(pE_Pt(t)) ~ k′₈*Pt(t)*pE(t) - k′₆*pE_Pt(t) - k′₉*pE_Pt(t)
 Differential(t)(ppE_Pt(t)) ~ k′₃*Pt(t)*ppE(t) - k′₄*ppE_Pt(t) - k′₇*ppE_Pt(t)







incidence_matrix(ChX(rxs))
