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
    return l, l+1, Float64(x-f)
end

include("Value.jl")
export value_noise


const NR_CACHES::Int = 64

# pad to the next cacheline
struct Padding{T, P}
    value::T
    padding::P
end
Padding{T, NTuple{V, UInt8}}(v::T) where {T, V} = Padding{T, NTuple{V, UInt8}}(v, ntuple(i->UInt8(0), Val(V)))
pad(::Type{T}) where T = Padding{T, NTuple{(64 - (sizeof(T) % 64)) % 64, UInt8}} 
Base.zero(::Type{Padding{T, NTuple{V, UInt8}}}) where {T, V} = Padding(zero(T), ntuple(i->UInt8(0), Val(V)))
Base.zero(::Type{NTuple{V, T}}) where {V, T} = ntuple(i->zero(T), Val(V))


include("Perlin.jl")
export perlin_noise

include("Voronoi.jl")
include("Worley.jl")
export worley_noise1, worley_noise2, worley_noise3, worley_noise4
export worley_noise5, worley_noise6, worley_noise7, worley_noise8

include("Simulation.jl")
export sim_noise2d, sim_noise3d

include("Fractal.jl")
export fractal

end
