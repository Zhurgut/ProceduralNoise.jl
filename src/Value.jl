
value_noise(coords...) = value_noise(Float64.(coords)...)

function value_noise(x::Float64)
    l::Int = floor(x)
    h::Int = ceil(x)
    d = x - floor(x)
    vl = rand30_from(l ⊻ SEED)
    vh = rand30_from(h ⊻ SEED)
    return interpolate(d, vl, vh)
end

function value_noise(x::Float64, y::Float64)
    l::Int = floor(x)
    r::Int = ceil(x)
    dx = x - floor(x)
    t::Int = floor(y)
    b::Int = ceil(y)
    dy = y - floor(y)
    tl = rand30_from(l ⊻ SEED, t ⊻ SEED)
    tr = rand30_from(r ⊻ SEED, t ⊻ SEED)
    bl = rand30_from(l ⊻ SEED, b ⊻ SEED)
    br = rand30_from(r ⊻ SEED, b ⊻ SEED)
    return interpolate(dx, dy, tl, tr, bl, br)
end