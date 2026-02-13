

hash1D(x) = hash(x)
hash2D(x, y) = hash(x, hash(y))
hash3D(x, y, z) = hash1D(x) ⊻ ~hash2D(y, z)
hash4D(x, y, z, w) = hash2D(x, y) ⊻ ~hash2D(z, w)

function random_from(x::UInt64)
    global SEED
    exp = reinterpret(UInt64, Float64(1.5)) & Base.exponent_mask(Float64)
    mantissa = (x ⊻ SEED) & Base.significand_mask(Float64)
    return reinterpret(Float64, exp | mantissa) - 1
end

random_from(x) = random_from(hash1D(x))
random_from(x, y) = random_from(hash2D(x, y))
random_from(x, y, z) = random_from(hash3D(x, y, z))
random_from(x, y, z, w) = random_from(hash4D(x, y, z, w))
