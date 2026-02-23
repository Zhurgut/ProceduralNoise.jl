# https://en.wikipedia.org/wiki/Simulation_noise

# divergence free flow fields

function sim_noise2d(x, y; tm=nothing)
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


function sim_noise2d(x, y, tm)
    t1, t2, dt = bounds(tm)
    v1 = sim_noise2d(x, y; tm=t1)
    v2 = sim_noise2d(x, y; tm=t2)
    (interpolate(dt, v1[1], v2[1]), interpolate(dt, v1[2], v2[2]))
end



function sim_noise3d(x, y, z; tm=nothing)
    l, r, dx = bounds(x)
    b, t, dy = bounds(y)
    a, o, dz = bounds(z)

    e_ba, e_ta, e_la, e_ra, e_bl, e_br, e_tl, e_tr, e_bo, e_to, e_lo, e_ro = if isnothing(tm)
        (fma(2, random_noise(l, b, a), -1),
         fma(2, random_noise(l, t, a), -1),
         fma(2, random_noise(l, b, a), -1),
         fma(2, random_noise(r, b, a), -1),
         fma(2, random_noise(l, b, a), -1),
         fma(2, random_noise(r, b, a), -1),
         fma(2, random_noise(l, t, a), -1),
         fma(2, random_noise(r, t, a), -1),
         fma(2, random_noise(l, b, o), -1),
         fma(2, random_noise(l, t, o), -1),
         fma(2, random_noise(l, b, o), -1),
         fma(2, random_noise(r, b, o), -1)
        )
    else
        (fma(2, random_noise(l, b, a, tm), -1),
         fma(2, random_noise(l, t, a, tm), -1),
         fma(2, random_noise(l, b, a, tm), -1),
         fma(2, random_noise(r, b, a, tm), -1),
         fma(2, random_noise(l, b, a, tm), -1),
         fma(2, random_noise(r, b, a, tm), -1),
         fma(2, random_noise(l, t, a, tm), -1),
         fma(2, random_noise(r, t, a, tm), -1),
         fma(2, random_noise(l, b, o, tm), -1),
         fma(2, random_noise(l, t, o, tm), -1),
         fma(2, random_noise(l, b, o, tm), -1),
         fma(2, random_noise(r, b, o, tm), -1)
        )
    end

    fl, fr, fb, ft, fa, fo = (
        (e_la - e_lo) + (e_bl - e_tl),
        (e_ra - e_ro) + (e_br - e_tr),
        (e_ba - e_bo) + (e_bl - e_br),
        (e_ta - e_to) + (e_tl - e_tr),
        (e_ba - e_ta) + (e_la - e_ra),
        (e_bo - e_to) + (e_lo - e_ro)
    )

    Vx = bell(dy) * bell(dz) * interpolate(dx, fl, fr)
    Vy = bell(dx) * bell(dz) * interpolate(dy, fb, ft)
    Vz = bell(dx) * bell(dy) * interpolate(dz, fa, fo)

    return (Vx, Vy, Vz)
end


function sim_noise3d(x, y, z, tm)
    t1, t2, dt = bounds(tm)
    v1 = sim_noise3d(x, y, z; tm=t1)
    v2 = sim_noise3d(x, y, z; tm=t2)
    (interpolate(dt, v1[1], v2[1]), interpolate(dt, v1[2], v2[2]), interpolate(dt, v1[3], v2[3]))
end

