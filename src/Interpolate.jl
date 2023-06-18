module Interpolate
export interpolate


@inline function interpolate(x, l, r)
    return @fastmath begin
        x² = x*x
        fma(fma(fma(6.0, x, -15), x², 10x), x²*(r-l), l)
    end
end

@inline function interpolate(x, l, r)
    x² = x*x
    a1 = fma(6.0, x, -15)
    a2 = 10x
    a3 = (r-l)
    a4 = x²*a3
    a5 = fma(a1, x², a2)
    return fma(a5, a4, l)
end

function interpolate(x, y, tl, tr, bl, br)
    fx = fma(6, x, -15)
    y² = y * y
    y10 = 10y
    x² = x * x
    b = br - bl
    l = bl - tl
    t = tr - tl
    F = y² * l
    fy = fma(6, y, -15)
    x10 = 10x
    my = fma(fy, y², y10)
    mx = fma(fx, x², x10)
    A = x² * mx
    G = fma(my, F, tl)
    C = fma(my, y² * (b - t), t)
    return fma(A, C, G)
end

@inline function interpolate(x, y, tl, tr, bl, br)
    y² = y*y
    x² = x*x
    my = fma(fma(6.0, y, -15), y², 10y) # 11
    mx = fma(fma(6.0, x, -15), x², 10x) # 11
    C = y²*((br-bl)-(tr-tl)) # 12
    F = y²*(bl-tl)
    return fma(x²*mx, fma(my, C, tr-tl), fma(my, F, tl))
end

function interpolate(x, y, z, tl1, tr1, bl1, br1, tl2, tr2, bl2, br2)
    return @fastmath begin
        w1 = interpolate(x, y, tl1, tr1, bl1, br1)
        w2 = interpolate(x, y, tl2, tr2, bl2, br2)
        interpolate(z, w1, w2)
    end
end


@inline function interpolate(x, y, z, w, atl1, atr1, abl1, abr1, atl2, atr2, abl2, abr2, otl1, otr1, obl1, obr1, otl2, otr2, obl2, obr2)
    return @fastmath begin
        a = interpolate(x, y, z, atl1, atr1, abl1, abr1, atl2, atr2, abl2, abr2)
        o = interpolate(x, y, z, otl1, otr1, obl1, obr1, otl2, otr2, obl2, obr2)
        interpolate(w, a, o)
    end
end



end