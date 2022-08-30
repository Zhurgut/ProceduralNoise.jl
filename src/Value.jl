
value_noise(coords...) = value_noise(Float64.(coords)...)

function value_noise(x::Float64)
    l::Int = floor(x)
    h::Int = l+1
    d = x - floor(x)
    vl = rand30_from(l ⊻ SEED)
    vh = rand30_from(h ⊻ SEED)
    return interpolate(d, vl, vh)
end

function value_noise(x::Float64, y::Float64)
    l::Int = floor(x)
    r::Int = l+1
    dx = x - floor(x)
    t::Int = floor(y)
    b::Int = t+1
    dy = y - floor(y)
    tl = rand30_from(l ⊻ SEED, t ⊻ SEED)
    tr = rand30_from(r ⊻ SEED, t ⊻ SEED)
    bl = rand30_from(l ⊻ SEED, b ⊻ SEED)
    br = rand30_from(r ⊻ SEED, b ⊻ SEED)
    return interpolate(dx, dy, tl, tr, bl, br)
end

function value_noise(x::Float64, y::Float64, z::Float64)
    l::Int = floor(x)
    r::Int = l+1
    dx = x - floor(x)
    t::Int = floor(y)
    b::Int = t+1
    dy = y - floor(y)
    a::Int = floor(z)
    o::Int = a+1
    dz = z - floor(z)
    atl = rand30_from(l ⊻ SEED, t ⊻ SEED, a ⊻ SEED)
    atr = rand30_from(r ⊻ SEED, t ⊻ SEED, a ⊻ SEED)
    abl = rand30_from(l ⊻ SEED, b ⊻ SEED, a ⊻ SEED)
    abr = rand30_from(r ⊻ SEED, b ⊻ SEED, a ⊻ SEED)
    otl = rand30_from(l ⊻ SEED, t ⊻ SEED, o ⊻ SEED)
    otr = rand30_from(r ⊻ SEED, t ⊻ SEED, o ⊻ SEED)
    obl = rand30_from(l ⊻ SEED, b ⊻ SEED, o ⊻ SEED)
    obr = rand30_from(r ⊻ SEED, b ⊻ SEED, o ⊻ SEED)
    return interpolate(dx, dy, dz, atl, atr, abl, abr, otl, otr, obl, obr)
end

function value_noise(x::Float64, y::Float64, z::Float64, w::Float64)
    l::Int = floor(x)
    r::Int = l+1
    dx = x - floor(x)
    t::Int = floor(y)
    b::Int = t+1
    dy = y - floor(y)
    a::Int = floor(z)
    o::Int = a+1
    dz = z - floor(z)
    w1::Int = floor(w)
    w2::Int = w1+1
    dw = w - floor(w)
    atl1 = rand30_from(l ⊻ SEED, t ⊻ SEED, a ⊻ SEED, w1 ⊻ SEED)
    atr1 = rand30_from(r ⊻ SEED, t ⊻ SEED, a ⊻ SEED, w1 ⊻ SEED)
    abl1 = rand30_from(l ⊻ SEED, b ⊻ SEED, a ⊻ SEED, w1 ⊻ SEED)
    abr1 = rand30_from(r ⊻ SEED, b ⊻ SEED, a ⊻ SEED, w1 ⊻ SEED)
    otl1 = rand30_from(l ⊻ SEED, t ⊻ SEED, o ⊻ SEED, w1 ⊻ SEED)
    otr1 = rand30_from(r ⊻ SEED, t ⊻ SEED, o ⊻ SEED, w1 ⊻ SEED)
    obl1 = rand30_from(l ⊻ SEED, b ⊻ SEED, o ⊻ SEED, w1 ⊻ SEED)
    obr1 = rand30_from(r ⊻ SEED, b ⊻ SEED, o ⊻ SEED, w1 ⊻ SEED)
    atl2 = rand30_from(l ⊻ SEED, t ⊻ SEED, a ⊻ SEED, w2 ⊻ SEED)
    atr2 = rand30_from(r ⊻ SEED, t ⊻ SEED, a ⊻ SEED, w2 ⊻ SEED)
    abl2 = rand30_from(l ⊻ SEED, b ⊻ SEED, a ⊻ SEED, w2 ⊻ SEED)
    abr2 = rand30_from(r ⊻ SEED, b ⊻ SEED, a ⊻ SEED, w2 ⊻ SEED)
    otl2 = rand30_from(l ⊻ SEED, t ⊻ SEED, o ⊻ SEED, w2 ⊻ SEED)
    otr2 = rand30_from(r ⊻ SEED, t ⊻ SEED, o ⊻ SEED, w2 ⊻ SEED)
    obl2 = rand30_from(l ⊻ SEED, b ⊻ SEED, o ⊻ SEED, w2 ⊻ SEED)
    obr2 = rand30_from(r ⊻ SEED, b ⊻ SEED, o ⊻ SEED, w2 ⊻ SEED)
    return interpolate(dx, dy, dz, dw, atl1, atr1, abl1, abr1, otl1, otr1, obl1, obr1, atl2, atr2, abl2, abr2, otl2, otr2, obl2, obr2)
end