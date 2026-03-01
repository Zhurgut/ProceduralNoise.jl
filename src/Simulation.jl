# https://en.wikipedia.org/wiki/Simulation_noise

# divergence free flow fields

function sim_noise2d(x, y; tm=nothing, cache_index=nothing, gradient=nothing)
    l, r, dx = bounds(x)
    b, t, dy = bounds(y)

    e_bl, e_tl, e_br, e_tr = if isnothing(tm)
        (fma(2, random_noise(l, b), -1),
         fma(2, random_noise(l, t), -1),
         fma(2, random_noise(r, b), -1),
         fma(2, random_noise(r, t), -1))
    else
        (fma(2, random_noise(l, b, tm), -1),
         fma(2, random_noise(l, t, tm), -1),
         fma(2, random_noise(r, b, tm), -1),
         fma(2, random_noise(r, t, tm), -1))
    end

    fl, fr, fb, ft = e_tl - e_bl, e_tr - e_br, e_bl - e_br, e_tl - e_tr
    Vx = bell(dy) * interpolate(dx, fl, fr)
    Vy = bell(dx) * interpolate(dy, fb, ft)

    return (Vx, Vy)
end


function sim_noise2d(x, y, tm; cache_index=nothing, gradient=nothing)
    t1, t2, dt = bounds(tm)
    v1 = sim_noise2d(x, y; tm=t1)
    v2 = sim_noise2d(x, y; tm=t2)
    (mix(dt, v1[1], v2[1]), mix(dt, v1[2], v2[2]))
end



function sim_noise3d(x, y, z; tm=nothing, cache_index=nothing, gradient=nothing)
    l, r, dx = bounds(x)
    b, t, dy = bounds(y)
    a, o, dz = bounds(z)

    e_ba, e_ta, e_la, e_ra, e_bl, e_br, e_tl, e_tr, e_bo, e_to, e_lo, e_ro = if isnothing(tm)
        (fma(2, random_noise(l, b, a), -1), # ba
         fma(2, random_noise(r, t, a), -1), # ta
         fma(2, random_noise(l, t, a), -1), # la
         fma(2, random_noise(r, b, a), -1), # ra

         fma(2, random_noise(l, a, b), -1), # bl
         fma(2, random_noise(r, a, b), -1), # br
         fma(2, random_noise(l, a, t), -1), # tl
         fma(2, random_noise(r, a, t), -1), # tr

         fma(2, random_noise(l, b, o), -1), # bo
         fma(2, random_noise(r, t, o), -1), # to
         fma(2, random_noise(l, t, o), -1), # lo
         fma(2, random_noise(r, b, o), -1)  # ro
        )
    else
        (fma(2, random_noise(l, b, a, tm), -1), # ba
         fma(2, random_noise(r, t, a, tm), -1), # ta
         fma(2, random_noise(l, t, a, tm), -1), # la
         fma(2, random_noise(r, b, a, tm), -1), # ra

         fma(2, random_noise(l, a, b, tm), -1), # bl
         fma(2, random_noise(r, a, b, tm), -1), # br
         fma(2, random_noise(l, a, t, tm), -1), # tl
         fma(2, random_noise(r, a, t, tm), -1), # tr

         fma(2, random_noise(l, b, o, tm), -1), # bo
         fma(2, random_noise(r, t, o, tm), -1), # to
         fma(2, random_noise(l, t, o, tm), -1), # lo
         fma(2, random_noise(r, b, o, tm), -1)  # ro
        )
    end

    fl, fr, fb, ft, fa, fo = (
        (e_la - e_lo) - (e_bl - e_tl),
        (e_ra - e_ro) - (e_br - e_tr),
        (e_bl - e_br) - (e_ba - e_bo),
        (e_tl - e_tr) - (e_ta - e_to),
        (e_ba - e_ta) - (e_la - e_ra),
        (e_bo - e_to) - (e_lo - e_ro)
    )

    Vx = bell(dy) * bell(dz) * interpolate(dx, fl, fr)
    Vy = bell(dx) * bell(dz) * interpolate(dy, fb, ft)
    Vz = bell(dx) * bell(dy) * interpolate(dz, fa, fo)

    return (Vx, Vy, Vz)
end


function sim_noise3d(x, y, z, tm; cache_index=nothing, gradient=nothing)
    t1, t2, dt = bounds(tm)
    v1 = sim_noise3d(x, y, z; tm=t1)
    v2 = sim_noise3d(x, y, z; tm=t2)
    (mix(dt, v1[1], v2[1]), mix(dt, v1[2], v2[2]), mix(dt, v1[3], v2[3]))
end


function curl_noise(x, y, z; f::F=perlin_noise, cache_index=1, gradient=nothing) where F
    ti = 3*cache_index-2
    x2 = x+100.5
    y2 = y+100.5
    z2 = z+100.5
    ∇Gx = f(x2, y, z, cache_index=ti, gradient=true)
    ∇Gy = f(x, y2, z, cache_index=ti+1, gradient=true)
    ∇Gz = f(x, y, z2, cache_index=ti+2, gradient=true)
    return (∇Gz[2] - ∇Gy[3], ∇Gx[3] - ∇Gz[1], ∇Gy[1] - ∇Gx[2])
end

function curl_noise(x, y, z, t; f::F=perlin_noise, cache_index=1, gradient=nothing) where F
    ti = 3*cache_index-2
    x2 = x+100.5
    y2 = y+100.5
    z2 = z+100.5
    ∇Gx = f(x2, y, z, t, cache_index=ti, gradient=true)
    ∇Gy = f(x, y2, z, t, cache_index=ti+1, gradient=true)
    ∇Gz = f(x, y, z2, t, cache_index=ti+2, gradient=true)
    return (∇Gz[2] - ∇Gy[3], ∇Gx[3] - ∇Gz[1], ∇Gy[1] - ∇Gx[2])
end

function bitangent_noise(x, y, z; f1::F1=perlin_noise, f2::F2=perlin_noise, cache_index=1, gradient=nothing) where {F1, F2}
    ti = 2*cache_index-1
    A = f1(x+100.5, 0.5-y, z+10.5, gradient=true, cache_index=ti)
    B = f2(x, y, z, gradient=true, cache_index=ti+1)
    return (
        A[2]*B[3] - A[3]*B[2],
        A[3]*B[1] - A[1]*B[3],
        A[1]*B[2] - A[2]*B[1],
    )
end

function bitangent_noise(x, y, z, t; f1::F1=perlin_noise, f2::F2=perlin_noise, cache_index=1, gradient=nothing) where {F1, F2}
    ti = 2*cache_index-1
    A = f1(x+100.5, 0.5-y, z+10.5, t, gradient=true, cache_index=ti)
    B = f2(x, y, z, t, gradient=true, cache_index=ti+1)
    return (
        A[2]*B[3] - A[3]*B[2],
        A[3]*B[1] - A[1]*B[3],
        A[1]*B[2] - A[2]*B[1],
    )
end