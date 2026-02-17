
using LinearAlgebra: norm

SEED::UInt64 = 0

function set_seed(x)
    global SEED = bitrotate(hash(x), 17)
end

set_seed(0)


hash1D(x) = hash(x)
hash2D(x, y) = begin h = hash(x); hash(y, bitrotate(h, hash(y) & 0xff)) end
hash3D(x, y, z) = hash(hash1D(x) ⊻ ~hash2D(y, z))
hash4D(x, y, z, w) = hash(hash2D(x, y) ⊻ ~hash2D(z, w))

function random_from_hash(x::UInt64)
    global SEED
    exp = reinterpret(UInt64, Float64(1.5)) & Base.exponent_mask(Float64)
    mantissa = (x ⊻ SEED) & Base.significand_mask(Float64)
    return (reinterpret(Float64, exp | mantissa) - 1, x)
end

random_from(x)          = random_from_hash(hash1D(x))
random_from(x, y)       = random_from_hash(hash2D(x, y))
random_from(x, y, z)    = random_from_hash(hash3D(x, y, z))
random_from(x, y, z, w) = random_from_hash(hash4D(x, y, z, w))

more_random_from(h::UInt64) = random_from_hash(hash(h))

#not really a unit vector, but uniform on the interval [-1, 1]
unit_vector_from(x) = begin
    v, h = random_from(x)
    return fma(2, v, -1), h
end

# only very roughly distributed uniformly
function unit_vector_from(x, y)
    v, h = random_from(x, y)
    v2, h = more_random_from(h)
    v = fma(2, v, -1)
    v2 = fma(2, v2, -1)
    l1_dist = abs(v) + abs(v2)
    while l1_dist > 1.5
        v, (v2, h) = v2, more_random_from(h)
        v2 = fma(2, v2, -1)
        l1_dist = abs(v) + abs(v2)
    end

    vec = (v, v2)
    return (1 / norm(vec)) .* vec
end

function unit_vector_from(x, y, z)
    v, h = random_from(x, y, z)
    v2, h = more_random_from(h)
    v3, h = more_random_from(h)
    v = fma(2, v, -1)
    v2 = fma(2, v2, -1)
    v3 = fma(2, v3, -1)
    l1_dist = abs(v) + abs(v2) + abs(v3)
    while l1_dist > 2.3
        v, v2, (v3, h) = v2, v3, more_random_from(h)
        v3 = fma(2, v3, -1)
        l1_dist = abs(v) + abs(v2) + abs(v3)
    end
    
    vec = (v, v2, v3)
    return (1 / norm(vec)) .* vec
end

function unit_vector_from(x, y, z, w)
    v, h = random_from(x, y, z, w)
    v2, h = more_random_from(h)
    v3, h = more_random_from(h)
    v4, h = more_random_from(h)
    v = fma(2, v, -1)
    v2 = fma(2, v2, -1)
    v3 = fma(2, v3, -1)
    v4 = fma(2, v4, -1)
    l1_dist = abs(v) + abs(v2) + (abs(v3) + abs(v4))
    while l1_dist > 3.1
        v, v2, v3, (v4, h) = v2, v3, v4, more_random_from(h)
        v4 = fma(2, v4, -1)
        l1_dist = abs(v) + abs(v2) + (abs(v3) + abs(v4))
    end
    
    vec = (v, v2, v3, v4)
    return (1 / norm(vec)) .* vec
end