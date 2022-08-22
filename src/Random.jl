
random_noise(coords...) = random_noise(Float64.(coords)...)

function random_noise(x::Float64)
    u = reinterpret(UInt64, x)
    return rand30_from(u ⊻ SEED)
end

function random_noise(x::Float64, y::Float64)
    u1 = reinterpret(UInt64, x)
    u2 = reinterpret(UInt64, y)
    return rand30_from(u1 ⊻ SEED, u2)
end

function random_noise(x::Float64, y::Float64, z::Float64)
    u1 = reinterpret(UInt64, x)
    u2 = reinterpret(UInt64, y)
    u3 = reinterpret(UInt64, z)
    return rand30_from(u1 ⊻ SEED, u2, u3)
end

function random_noise(x::Float64, y::Float64, z::Float64, w::Float64)
    u1 = reinterpret(UInt64, x)
    u2 = reinterpret(UInt64, y)
    u3 = reinterpret(UInt64, z)
    u4 = reinterpret(UInt64, w)
    return rand30_from(u1 ⊻ SEED, u2, u3, u4)
end
