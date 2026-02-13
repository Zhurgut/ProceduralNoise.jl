module PNoise

include("Interpolate.jl")
using .Interpolate

SEED::UInt64 = 0 # one seed to rule them all

function set_seed(x)
    global SEED = hash(x)
end

include("hash4d.jl")

include("Random.jl")
export random_noise

function bounds(x)
    f = floor(x)
    l = Int(f)
    return l, l+1, x-f
end

include("Value.jl")
export value_noise

# include("Perlin.jl")
# export perlin_noise

# include("Voronoi.jl")
# export voronoi_noise



end
