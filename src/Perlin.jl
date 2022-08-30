
# range is [-√(N/4), √(N/4)]

perlin_noise(coords...) = perlin_noise(Float64.(coords)...)

function perlin_noise(x::Float64)
    l::Int = floor(x)
    h::Int = l+1
    d = x - floor(x)
    vl = 2*rand30_from(l ⊻ SEED)-1
    vh = 2*rand30_from(h ⊻ SEED)-1
    return 0.5 + interpolate(d, vl*d, vh*(1-d))
end

function unit(x, y)
    a = randn30_from(x, y)
    b = more_randn30_from()
    idst = 1/sqrt(a*a + b*b)
    return idst .* (a, b)
end

function unit(x, y, z)
    a = randn30_from(x, y, z)
    b = more_randn30_from()
    c = more_randn30_from()
    idst = 1/sqrt(a*a + b*b + c*c)
    return idst .* (a, b, c)
end

function unit(x, y, z, w)
    a = randn30_from(x, y, z, w)
    b = more_randn30_from()
    c = more_randn30_from()
    d = more_randn30_from()
    idst = 1/sqrt(a*a + b*b + (c*c + d*d))
    return idst .* (a, b, c, d)
end

d2(t, p) = t[1]*p[1] + t[2]*p[2]
d3(t, p) = t[1]*p[1] + t[2]*p[2] + t[3]*p[3]
d4(t, p) = t[1]*p[1] + t[2]*p[2] + t[3]*p[3] + t[4]*p[4]

let coords::Vector{Int} = Int[-9223372036854775808,-9223372036854775808],
    vectors::Vector{Tuple{Float64, Float64}} = Vector{Tuple{Float64, Float64}}(undef, 4)

    global function perlin_noise(x::Float64, y::Float64)
        l::Int = floor(x)
        r::Int = l+1
        dx = x - floor(x)
        t::Int = floor(y)
        b::Int = t+1
        dy = y - floor(y)

        @inbounds begin
            if !(coords[1] == l && coords[2] == t)
                ls = l ⊻ SEED
                rs = r ⊻ SEED
                ts = t ⊻ SEED
                bs = b ⊻ SEED
                vectors[1] = unit(ls, ts)
                vectors[2] = unit(rs, ts)
                vectors[3] = unit(ls, bs)
                vectors[4] = unit(rs, bs)
                coords[1] = l
                coords[2] = t
            end
            return 0.5 + 0.7071067811865475interpolate(dx, dy,
                d2(vectors[1], (dx,   dy)),
                d2(vectors[2], (dx-1, dy)),
                d2(vectors[3], (dx,   dy-1)),
                d2(vectors[4], (dx-1, dy-1)),
            )
        end
    end
end

let coords::Vector{Int} = Int[-9223372036854775808,-9223372036854775808, -9223372036854775808],
    vectors::Vector{Tuple{Float64, Float64, Float64}} = Vector{Tuple{Float64, Float64, Float64}}(undef, 8)

    global function perlin_noise(x::Float64, y::Float64, z::Float64)
        l::Int = floor(x)
        r::Int = l+1
        dx = x - floor(x)
        t::Int = floor(y)
        b::Int = t+1
        dy = y - floor(y)
        a::Int = floor(z)
        o::Int = a+1
        dz = z - floor(z)

        @inbounds begin
            if !(coords[1] == l && coords[2] == t && coords[3] == a)
                ls = l ⊻ SEED
                rs = r ⊻ SEED
                ts = t ⊻ SEED
                bs = b ⊻ SEED
                as = a ⊻ SEED
                os = o ⊻ SEED
                vectors[1] = unit(ls, ts, as)
                vectors[2] = unit(rs, ts, as)
                vectors[3] = unit(ls, bs, as)
                vectors[4] = unit(rs, bs, as)
                vectors[5] = unit(ls, ts, os)
                vectors[6] = unit(rs, ts, os)
                vectors[7] = unit(ls, bs, os)
                vectors[8] = unit(rs, bs, os)
                coords[1] = l
                coords[2] = t
                coords[3] = a
            end
            return 0.5 + 0.5773502691896258interpolate(dx, dy, dz,
                d3(vectors[1], (dx,   dy,   dz)),
                d3(vectors[2], (dx-1, dy,   dz)),
                d3(vectors[3], (dx,   dy-1, dz)),
                d3(vectors[4], (dx-1, dy-1, dz)),
                d3(vectors[5], (dx,   dy,   dz-1)),
                d3(vectors[6], (dx-1, dy,   dz-1)),
                d3(vectors[7], (dx,   dy-1, dz-1)),
                d3(vectors[8], (dx-1, dy-1, dz-1))
            )
        end
    end
end

let coords::Vector{Int} = Int[-9223372036854775808,-9223372036854775808, -9223372036854775808,-9223372036854775808],
    vectors::Vector{Tuple{Float64, Float64, Float64, Float64}} = Vector{Tuple{Float64, Float64, Float64, Float64}}(undef, 16)

    global function perlin_noise(x::Float64, y::Float64, z::Float64, w::Float64)
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

        @inbounds begin
            if !(coords[1] == l && coords[2] == t && coords[3] == a && coords[4] == w1)
                ls = l ⊻ SEED
                rs = r ⊻ SEED
                ts = t ⊻ SEED
                bs = b ⊻ SEED
                as = a ⊻ SEED
                os = o ⊻ SEED
                w1s = w1 ⊻ SEED
                w2s = w2 ⊻ SEED
                vectors[1] = unit(ls, ts, as, w1s)
                vectors[2] = unit(rs, ts, as, w1s)
                vectors[3] = unit(ls, bs, as, w1s)
                vectors[4] = unit(rs, bs, as, w1s)
                vectors[5] = unit(ls, ts, os, w1s)
                vectors[6] = unit(rs, ts, os, w1s)
                vectors[7] = unit(ls, bs, os, w1s)
                vectors[8] = unit(rs, bs, os, w1s)
                vectors[9] =  unit(ls, ts, as, w2s)
                vectors[10] = unit(rs, ts, as, w2s)
                vectors[11] = unit(ls, bs, as, w2s)
                vectors[12] = unit(rs, bs, as, w2s)
                vectors[13] = unit(ls, ts, os, w2s)
                vectors[14] = unit(rs, ts, os, w2s)
                vectors[15] = unit(ls, bs, os, w2s)
                vectors[16] = unit(rs, bs, os, w2s)
                coords[1] = l
                coords[2] = t
                coords[3] = a
                coords[4] = w1
            end
            return 0.5 + 0.5interpolate(dx, dy, dz, dw,
                d4(vectors[1] , (dx,   dy,   dz   ,dw)),
                d4(vectors[2] , (dx-1, dy,   dz   ,dw)),
                d4(vectors[3] , (dx,   dy-1, dz   ,dw)),
                d4(vectors[4] , (dx-1, dy-1, dz   ,dw)),
                d4(vectors[5] , (dx,   dy,   dz-1 ,dw)),
                d4(vectors[6] , (dx-1, dy,   dz-1 ,dw)),
                d4(vectors[7] , (dx,   dy-1, dz-1 ,dw)),
                d4(vectors[8] , (dx-1, dy-1, dz-1 ,dw)),
                d4(vectors[9] , (dx,   dy,   dz   ,dw-1)),
                d4(vectors[10], (dx-1, dy,   dz   ,dw-1)),
                d4(vectors[11], (dx,   dy-1, dz   ,dw-1)),
                d4(vectors[12], (dx-1, dy-1, dz   ,dw-1)),
                d4(vectors[13], (dx,   dy,   dz-1 ,dw-1)),
                d4(vectors[14], (dx-1, dy,   dz-1 ,dw-1)),
                d4(vectors[15], (dx,   dy-1, dz-1 ,dw-1)),
                d4(vectors[16], (dx-1, dy-1, dz-1 ,dw-1))
            )
        end
    end
end

