
# range is [-√(N/4), √(N/4)]

using LinearAlgebra: dot

function perlin_noise(x; cache_index=nothing, gradient=false)
    l, r, d = bounds(x)
    vl, _ = unit_vector_from(l)
    vr, _ = unit_vector_from(r)
    if gradient
        return  ∇interpolate(d, vl*d, vr*(d-1)) + interpolate(d, vl, vr)
    else
        return 0.5 + interpolate(d, vl*d, vr*(d-1))
    end
end



let index::Vector{pad(Tuple{Int, Int})} = zeros(pad(Tuple{Int, Int}), NR_CACHES),
    cache::Vector{pad(NTuple{4, Tuple{Float64, Float64}})} = zeros(pad(NTuple{4, Tuple{Float64, Float64}}), NR_CACHES)

    function store!(b, l, t, r, i)
        v_bl = unit_vector_from(b, l)
        v_br = unit_vector_from(b, r)
        v_tl = unit_vector_from(t, l)
        v_tr = unit_vector_from(t, r)

        index[i] = Padding((b, l), index[i].padding)
        cache[i] = Padding((v_bl, v_br, v_tl, v_tr), cache[i].padding)
        cache[i].value
    end

    function load(i)
        cache[i].value
    end

    store!(0, 0, 1, 1, 1)

    function perlin2d(v_bl, v_br, v_tl, v_tr, dx, dy, gradient)
        bl = dot(v_bl, (dx,   dy))
        br = dot(v_br, (dx-1, dy))
        tl = dot(v_tl, (dx,   dy-1))
        tr = dot(v_tr, (dx-1, dy-1))

        if gradient
            Dx = interpolate(dx, dy, v_bl[1], v_br[1], v_tl[1], v_tr[1])
            Dy = interpolate(dx, dy, v_bl[2], v_br[2], v_tl[2], v_tr[2])
            return sqrt(0.5) .* (∇interpolate(dx, dy, bl, br, tl, tr) .+ (Dx, Dy))
        else
            return fma(sqrt(0.5), interpolate(dx, dy, bl, br, tl, tr), 0.5)
        end
    end

    global function perlin_noise(x, y; cache_index=1, gradient=false)
        ti = check_cache_index(cache_index)
        l, r, dx = bounds(x)
        b, t, dy = bounds(y)

        v_bl, v_br, v_tl, v_tr = if index[ti].value == (b, l)
            load(ti)
        else
            store!(b, l, t, r, ti)
        end

        return perlin2d(v_bl, v_br, v_tl, v_tr, dx, dy, gradient)
    end

    
end


let index::Vector{pad(Tuple{Int, Int, Int})} = zeros(pad(Tuple{Int, Int, Int}), NR_CACHES),
    cache::Vector{pad(NTuple{8, Tuple{Float64, Float64, Float64}})} = zeros(pad(NTuple{8, Tuple{Float64, Float64, Float64}}), NR_CACHES)

    function store!(b, l, t, r, a, o, i)
        v_bla = unit_vector_from(b, l, a)
        v_bra = unit_vector_from(b, r, a)
        v_tla = unit_vector_from(t, l, a)
        v_tra = unit_vector_from(t, r, a)
        v_blo = unit_vector_from(b, l, o)
        v_bro = unit_vector_from(b, r, o)
        v_tlo = unit_vector_from(t, l, o)
        v_tro = unit_vector_from(t, r, o)

        index[i] = Padding((b, l, a), index[i].padding)
        cache[i] = Padding((v_bla, v_bra, v_tla, v_tra, v_blo, v_bro, v_tlo, v_tro), cache[i].padding)
        cache[i].value
    end

    function load(i)
        cache[i].value
    end

    store!(0, 0, 1, 1, 0, 1, 1)

    function perlin3d(v_bla, v_bra, v_tla, v_tra, v_blo, v_bro, v_tlo, v_tro, dx, dy, dz, gradient)
        bla = dot(v_bla, (dx,   dy,   dz))
        bra = dot(v_bra, (dx-1, dy,   dz))
        tla = dot(v_tla, (dx,   dy-1, dz))
        tra = dot(v_tra, (dx-1, dy-1, dz))
        blo = dot(v_blo, (dx,   dy  , dz-1))
        bro = dot(v_bro, (dx-1, dy  , dz-1))
        tlo = dot(v_tlo, (dx,   dy-1, dz-1))
        tro = dot(v_tro, (dx-1, dy-1, dz-1))

        if gradient
            Dx = interpolate(dx, dy, dz, v_bla[1], v_bra[1], v_tla[1], v_tra[1], v_blo[1], v_bro[1], v_tlo[1], v_tro[1])
            Dy = interpolate(dx, dy, dz, v_bla[2], v_bra[2], v_tla[2], v_tra[2], v_blo[2], v_bro[2], v_tlo[2], v_tro[2])
            Dz = interpolate(dx, dy, dz, v_bla[3], v_bra[3], v_tla[3], v_tra[3], v_blo[3], v_bro[3], v_tlo[3], v_tro[3])
            return sqrt(1/3) .* (∇interpolate(dx, dy, dz, bla, bra, tla, tra, blo, bro, tlo, tro) .+ (Dx, Dy, Dz))
        else
            return fma(sqrt(1 / 3), interpolate(dx, dy, dz, bla, bra, tla, tra, blo, bro, tlo, tro), 0.5)
        end
    end

    global function perlin_noise(x, y, z; cache_index=1, gradient=false)
        ti = check_cache_index(cache_index)
        l, r, dx = bounds(x)
        b, t, dy = bounds(y)
        a, o, dz = bounds(z)

        v_bla, v_bra, v_tla, v_tra, v_blo, v_bro, v_tlo, v_tro = if index[ti].value == (b, l, a)
            load(ti)
        else
            store!(b, l, t, r, a, o, ti)
        end

        return perlin3d(v_bla, v_bra, v_tla, v_tra, v_blo, v_bro, v_tlo, v_tro, dx, dy, dz, gradient)
    end

    
end


let index::Vector{pad(Tuple{Int, Int, Int, Int})} = zeros(pad(Tuple{Int, Int, Int, Int}), NR_CACHES),
    cache::Vector{pad(NTuple{16, Tuple{Float64, Float64, Float64, Float64}})} = zeros(pad(NTuple{16, Tuple{Float64, Float64, Float64, Float64}}), NR_CACHES)

    function store!(b, l, t, r, a, o, w1, w2, i)
        v_bla1 = unit_vector_from(b, l, a, w1)
        v_bra1 = unit_vector_from(b, r, a, w1)
        v_tla1 = unit_vector_from(t, l, a, w1)
        v_tra1 = unit_vector_from(t, r, a, w1)
        v_blo1 = unit_vector_from(b, l, o, w1)
        v_bro1 = unit_vector_from(b, r, o, w1)
        v_tlo1 = unit_vector_from(t, l, o, w1)
        v_tro1 = unit_vector_from(t, r, o, w1)
        v_bla2 = unit_vector_from(b, l, a, w2)
        v_bra2 = unit_vector_from(b, r, a, w2)
        v_tla2 = unit_vector_from(t, l, a, w2)
        v_tra2 = unit_vector_from(t, r, a, w2)
        v_blo2 = unit_vector_from(b, l, o, w2)
        v_bro2 = unit_vector_from(b, r, o, w2)
        v_tlo2 = unit_vector_from(t, l, o, w2)
        v_tro2 = unit_vector_from(t, r, o, w2)

        index[i] = Padding((b, l, a, w1), index[i].padding)
        cache[i] = Padding(
            (v_bla1, v_bra1, v_tla1, v_tra1, v_blo1, v_bro1, v_tlo1, v_tro1, v_bla2, v_bra2, v_tla2, v_tra2, v_blo2, v_bro2, v_tlo2, v_tro2),
            cache[i].padding)
        cache[i].value
    end

    function load(i)
        cache[i].value
    end

    store!(0, 0, 1, 1, 0, 1, 0, 1, 1)

    function perlin4d(
            v_bla1, v_bra1, v_tla1, v_tra1, v_blo1, v_bro1, v_tlo1, v_tro1, 
            v_bla2, v_bra2, v_tla2, v_tra2, v_blo2, v_bro2, v_tlo2, v_tro2, 
            dx, dy, dz, dw, gradient)
        bla1 = dot(v_bla1, (dx,   dy,   dz,   dw))
        bra1 = dot(v_bra1, (dx-1, dy,   dz,   dw))
        tla1 = dot(v_tla1, (dx,   dy-1, dz,   dw))
        tra1 = dot(v_tra1, (dx-1, dy-1, dz,   dw))
        blo1 = dot(v_blo1, (dx,   dy  , dz-1, dw))
        bro1 = dot(v_bro1, (dx-1, dy  , dz-1, dw))
        tlo1 = dot(v_tlo1, (dx,   dy-1, dz-1, dw))
        tro1 = dot(v_tro1, (dx-1, dy-1, dz-1, dw))
        bla2 = dot(v_bla2, (dx,   dy,   dz,   dw-1))
        bra2 = dot(v_bra2, (dx-1, dy,   dz,   dw-1))
        tla2 = dot(v_tla2, (dx,   dy-1, dz,   dw-1))
        tra2 = dot(v_tra2, (dx-1, dy-1, dz,   dw-1))
        blo2 = dot(v_blo2, (dx,   dy  , dz-1, dw-1))
        bro2 = dot(v_bro2, (dx-1, dy  , dz-1, dw-1))
        tlo2 = dot(v_tlo2, (dx,   dy-1, dz-1, dw-1))
        tro2 = dot(v_tro2, (dx-1, dy-1, dz-1, dw-1))

        if gradient
            Dx = interpolate(
                dx, dy, dz, dw, 
                v_bla1[1], v_bra1[1], v_tla1[1], v_tra1[1], v_blo1[1], v_bro1[1], v_tlo1[1], v_tro1[1], 
                v_bla2[1], v_bra2[1], v_tla2[1], v_tra2[1], v_blo2[1], v_bro2[1], v_tlo2[1], v_tro2[1])
            Dy = interpolate(
                dx, dy, dz, dw, 
                v_bla1[2], v_bra1[2], v_tla1[2], v_tra1[2], v_blo1[2], v_bro1[2], v_tlo1[2], v_tro1[2], 
                v_bla2[2], v_bra2[2], v_tla2[2], v_tra2[2], v_blo2[2], v_bro2[2], v_tlo2[2], v_tro2[2])
            Dz = interpolate(
                dx, dy, dz, dw, 
                v_bla1[3], v_bra1[3], v_tla1[3], v_tra1[3], v_blo1[3], v_bro1[3], v_tlo1[3], v_tro1[3], 
                v_bla2[3], v_bra2[3], v_tla2[3], v_tra2[3], v_blo2[3], v_bro2[3], v_tlo2[3], v_tro2[3])
            Dw = interpolate(
                dx, dy, dz, dw, 
                v_bla1[4], v_bra1[4], v_tla1[4], v_tra1[4], v_blo1[4], v_bro1[4], v_tlo1[4], v_tro1[4], 
                v_bla2[4], v_bra2[4], v_tla2[4], v_tra2[4], v_blo2[4], v_bro2[4], v_tlo2[4], v_tro2[4])
            G = ∇interpolate(
                dx, dy, dz, dw, 
                bla1, bra1, tla1, tra1, blo1, bro1, tlo1, tro1, 
                bla2, bra2, tla2, tra2, blo2, bro2, tlo2, tro2)
            return 0.5 .* (G .+ (Dx, Dy, Dz, Dw))
        else
            return fma(0.5, interpolate(
                dx, dy, dz, dw, 
                bla1, bra1, tla1, tra1, blo1, bro1, tlo1, tro1, 
                bla2, bra2, tla2, tra2, blo2, bro2, tlo2, tro2), 0.5)
        end
    end

    global function perlin_noise(x, y, z, w; cache_index=1, gradient=false)
        ti = check_cache_index(cache_index)
        l, r, dx = bounds(x)
        b, t, dy = bounds(y)
        a, o, dz = bounds(z)
        w1, w2, dw = bounds(w)

        v_bla1, v_bra1, v_tla1, v_tra1, v_blo1, v_bro1, v_tlo1, v_tro1, v_bla2, v_bra2, v_tla2, v_tra2, v_blo2, v_bro2, v_tlo2, v_tro2 = if index[ti].value == (b, l, a, w1)
            load(ti)
        else
            store!(b, l, t, r, a, o, w1, w2, ti)
        end

        return perlin4d(
            v_bla1, v_bra1, v_tla1, v_tra1, v_blo1, v_bro1, v_tlo1, v_tro1, 
            v_bla2, v_bra2, v_tla2, v_tra2, v_blo2, v_bro2, v_tlo2, v_tro2, 
            dx, dy, dz, dw, gradient)
    end

    
end



