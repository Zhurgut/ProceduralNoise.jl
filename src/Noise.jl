module Noise

using Random30

include("Interpolate.jl")
using .Interpolate

SEED::UInt64 = 0 # one seed to rule them all

set_seed(u) = global SEED = hash30(u)

include("Random.jl")
export random_noise

include("Value.jl")
export value_noise

include("Perlin.jl")
export perlin_noise

include("Voronoi.jl")
export voronoi_noise



end
