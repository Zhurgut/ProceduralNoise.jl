
# range is [-√(N/4), √(N/4)]

using LinearAlgebra: dot

perlin_noise(coords...) = perlin_noise(Float64.(coords)...)

function perlin_noise(x::Float64)
    l, r, d = bounds(x)
    vl, _ = unit_vector_from(l)
    vr, _ = unit_vector_from(r)
    return 0.5 + interpolate(d, vl*d, vr*(d-1))
end

let index::Vector{pad(Tuple{Int, Int})} = zeros(pad(Tuple{Int, Int}), Threads.nthreads()),
    cache::Vector{pad(NTuple{4, Tuple{Float64, Float64}})} = zeros(pad(NTuple{4, Tuple{Float64, Float64}}), Threads.nthreads())

    function store!(b, l, t, r)
        v_bl = unit_vector_from(b, l)
        v_br = unit_vector_from(b, r)
        v_tl = unit_vector_from(t, l)
        v_tr = unit_vector_from(t, r)

        i = Threads.threadid()
        index[i] = Padding((b, l), index[i].padding)
        cache[i] = Padding((v_bl, v_br, v_tl, v_tr), cache[i].padding)
        cache[i].value
    end

    function load()
        cache[Threads.threadid()].value
    end

    store!(0, 0, 1, 1)

    global function perlin_noise(x, y)
        l, r, dx = bounds(x)
        b, t, dy = bounds(y)

        v_bl, v_br, v_tl, v_tr = if index[Threads.threadid()].value == (b, l)
            load()
        else
            store!(b, l, t, r)
        end

        return perlin2d(v_bl, v_br, v_tl, v_tr, dx, dy)
    end

    function perlin2d(v_bl, v_br, v_tl, v_tr, dx, dy)
        bl = dot(v_bl, (dx,   dy))
        br = dot(v_br, (dx-1, dy))
        tl = dot(v_tl, (dx,   dy-1))
        tr = dot(v_tr, (dx-1, dy-1))

        return fma(sqrt(0.5), interpolate(dx, dy, bl, br, tl, tr), 0.5)
    end
end


let index::Vector{pad(Tuple{Int, Int, Int})} = zeros(pad(Tuple{Int, Int, Int}), Threads.nthreads()),
    cache::Vector{pad(NTuple{8, Tuple{Float64, Float64, Float64}})} = zeros(pad(NTuple{8, Tuple{Float64, Float64, Float64}}), Threads.nthreads())

    function store!(b, l, t, r, a, o)
        v_bla = unit_vector_from(b, l, a)
        v_bra = unit_vector_from(b, r, a)
        v_tla = unit_vector_from(t, l, a)
        v_tra = unit_vector_from(t, r, a)
        v_blo = unit_vector_from(b, l, o)
        v_bro = unit_vector_from(b, r, o)
        v_tlo = unit_vector_from(t, l, o)
        v_tro = unit_vector_from(t, r, o)

        i = Threads.threadid()
        index[i] = Padding((b, l, a), index[i].padding)
        cache[i] = Padding((v_bla, v_bra, v_tla, v_tra, v_blo, v_bro, v_tlo, v_tro), cache[i].padding)
        cache[i].value
    end

    function load()
        cache[Threads.threadid()].value
    end

    store!(0, 0, 1, 1, 0, 1)

    global function perlin_noise(x, y, z)
        l, r, dx = bounds(x)
        b, t, dy = bounds(y)
        a, o, dz = bounds(z)

        v_bla, v_bra, v_tla, v_tra, v_blo, v_bro, v_tlo, v_tro = if index[Threads.threadid()].value == (b, l, a)
            load()
        else
            store!(b, l, t, r, a, o)
        end

        return perlin3d(v_bla, v_bra, v_tla, v_tra, v_blo, v_bro, v_tlo, v_tro, dx, dy, dz)
    end

    function perlin3d(v_bla, v_bra, v_tla, v_tra, v_blo, v_bro, v_tlo, v_tro, dx, dy, dz)
        bla = dot(v_bla, (dx,   dy,   dz))
        bra = dot(v_bra, (dx-1, dy,   dz))
        tla = dot(v_tla, (dx,   dy-1, dz))
        tra = dot(v_tra, (dx-1, dy-1, dz))
        blo = dot(v_blo, (dx,   dy  , dz-1))
        bro = dot(v_bro, (dx-1, dy  , dz-1))
        tlo = dot(v_tlo, (dx,   dy-1, dz-1))
        tro = dot(v_tro, (dx-1, dy-1, dz-1))

        return fma(sqrt(1 / 3), interpolate(dx, dy, dz, bla, bra, tla, tra, blo, bro, tlo, tro), 0.5)
    end
end


let index::Vector{pad(Tuple{Int, Int, Int, Int})} = zeros(pad(Tuple{Int, Int, Int, Int}), Threads.nthreads()),
    cache::Vector{pad(NTuple{16, Tuple{Float64, Float64, Float64, Float64}})} = zeros(pad(NTuple{16, Tuple{Float64, Float64, Float64, Float64}}), Threads.nthreads())

    function store!(b, l, t, r, a, o, w1, w2)
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

        i = Threads.threadid()
        index[i] = Padding((b, l, a, w1), index[i].padding)
        cache[i] = Padding(
            (v_bla1, v_bra1, v_tla1, v_tra1, v_blo1, v_bro1, v_tlo1, v_tro1, v_bla2, v_bra2, v_tla2, v_tra2, v_blo2, v_bro2, v_tlo2, v_tro2),
            cache[i].padding)
        cache[i].value
    end

    function load()
        cache[Threads.threadid()].value
    end

    store!(0, 0, 1, 1, 0, 1, 0, 1)

    global function perlin_noise(x, y, z, w)
        l, r, dx = bounds(x)
        b, t, dy = bounds(y)
        a, o, dz = bounds(z)
        w1, w2, dw = bounds(w)

        v_bla1, v_bra1, v_tla1, v_tra1, v_blo1, v_bro1, v_tlo1, v_tro1, v_bla2, v_bra2, v_tla2, v_tra2, v_blo2, v_bro2, v_tlo2, v_tro2 = if index[Threads.threadid()].value == (b, l, a, w1)
            load()
        else
            store!(b, l, t, r, a, o, w1, w2)
        end

        return perlin4d(
            v_bla1, v_bra1, v_tla1, v_tra1, v_blo1, v_bro1, v_tlo1, v_tro1, 
            v_bla2, v_bra2, v_tla2, v_tra2, v_blo2, v_bro2, v_tlo2, v_tro2, 
            dx, dy, dz, dw)
    end

    function perlin4d(
            v_bla1, v_bra1, v_tla1, v_tra1, v_blo1, v_bro1, v_tlo1, v_tro1, 
            v_bla2, v_bra2, v_tla2, v_tra2, v_blo2, v_bro2, v_tlo2, v_tro2, 
            dx, dy, dz, dw)
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

        return fma(0.5, interpolate(
            dx, dy, dz, dw, 
            bla1, bra1, tla1, tra1, blo1, bro1, tlo1, tro1, 
            bla2, bra2, tla2, tra2, blo2, bro2, tlo2, tro2), 0.5)
    end
end



