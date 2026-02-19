module PNoise

include("Interpolate.jl")
using .Interpolate

include("hash4d.jl")
export set_seed

include("Random.jl")
export random_noise

function bounds(x)
    f = floor(x)
    l = Int(f)
    return l, l+1, x-f
end

include("Value.jl")
export value_noise

include("Perlin.jl")
export perlin_noise

# include("Voronoi.jl")
# export voronoi_noise

# https://en.wikipedia.org/wiki/Simulation_noise
# https://en.wikipedia.org/wiki/Wavelet_noise
end
