module Interpolate
export interpolate, ∇interpolate, bell


bell(x) = (x*x) * fma(fma(16, x, -32), x, 16)


function interpolate(x, l, r)
    x² = x*x
    fx = fma(fma(6, x, -15), x², 10x)
    fma(fx, x²*(r-l), l)
end

function interpolate(x, y, tl, tr, bl, br)
    x² = x*x
    y² = y*y
    fx = fma(fma(6, x, -15), x², 10x)
    fy = fma(fma(6, y, -15), y², 10y) 
    t = fma(fx, x²*(tr-tl), tl)
    b = fma(fx, x²*(br-bl), bl)
    return fma(fy*y², b-t, t)
end

function interpolate(x, y, z, tl1, tr1, bl1, br1, tl2, tr2, bl2, br2)
    x² = x*x
    y² = y*y
    z² = z*z
    fx = fma(fma(6, x, -15), x², 10x)
    fy = fma(fma(6, y, -15), y², 10y)
    fz = fma(fma(6, z, -15), z², 10z) 
    t1 = fma(fx, x²*(tr1-tl1), tl1)
    b1 = fma(fx, x²*(br1-bl1), bl1)
    t2 = fma(fx, x²*(tr2-tl2), tl2)
    b2 = fma(fx, x²*(br2-bl2), bl2)
    v1 = fma(fy*y², b1-t1, t1)
    v2 = fma(fy*y², b2-t2, t2)
    return fma(fz*z², v2-v1, v1)
end

function interpolate(x, y, z, w, atl1, atr1, abl1, abr1, atl2, atr2, abl2, abr2, otl1, otr1, obl1, obr1, otl2, otr2, obl2, obr2)
    x² = x*x
    y² = y*y
    z² = z*z
    w² = w*w
    fx = fma(fma(6, x, -15), x², 10x)
    fy = fma(fma(6, y, -15), y², 10y)
    fz = fma(fma(6, z, -15), z², 10z)
    fw = fma(fma(6, w, -15), w², 10w) 
    at1 = fma(fx, x²*(atr1-atl1), atl1) 
    ab1 = fma(fx, x²*(abr1-abl1), abl1)
    at2 = fma(fx, x²*(atr2-atl2), atl2)
    ab2 = fma(fx, x²*(abr2-abl2), abl2)
    ot1 = fma(fx, x²*(otr1-otl1), otl1) 
    ob1 = fma(fx, x²*(obr1-obl1), obl1)
    ot2 = fma(fx, x²*(otr2-otl2), otl2)
    ob2 = fma(fx, x²*(obr2-obl2), obl2)
    a1 = fma(fy*y², ab1-at1, at1)
    a2 = fma(fy*y², ab2-at2, at2)
    o1 = fma(fy*y², ob1-ot1, ot1)
    o2 = fma(fy*y², ob2-ot2, ot2)
    a = fma(fz*z², a2-a1, a1)
    o = fma(fz*z², o2-o1, o1)
    return fma(fw*w², o-a, a)
end

function ∇interpolate(x, l, r)
    fx = fma(fma(30, x, -60), x, 30)
    return fx*(x*x)*(r-l)
end

function ∇interpolate(x, y, tl, tr, bl, br)
    l = interpolate(y, tl, bl)
    r = interpolate(y, tr, br)
    dx = ∇interpolate(x, l, r)

    t = interpolate(x, tl, tr)
    b = interpolate(x, bl, br)
    dy = ∇interpolate(y, t, b)
    return (dx, dy)
end

function ∇interpolate(x, y, z, tl1, tr1, bl1, br1, tl2, tr2, bl2, br2)
    l = interpolate(y, z, tl1, bl1, tl2, bl2)
    r = interpolate(y, z, tr1, br1, tr2, br2)
    dx = ∇interpolate(x, l, r)

    t = interpolate(x, z, tl1, tr1, tl2, tr2)
    b = interpolate(x, z, bl1, br1, bl2, br2)
    dy = ∇interpolate(y, t, b)

    v1 = interpolate(x, y, tl1, tr1, bl1, br1)
    v2 = interpolate(x, y, tl2, tr2, bl2, br2)
    dz = ∇interpolate(z, v1, v2)
    return (dx, dy, dz)
end

function ∇interpolate(x, y, z, w, atl1, atr1, abl1, abr1, atl2, atr2, abl2, abr2, otl1, otr1, obl1, obr1, otl2, otr2, obl2, obr2)
    l = interpolate(y, z, w, atl1, abl1, atl2, abl2, otl1, obl1, otl2, obl2)
    r = interpolate(y, z, w, atr1, abr1, atr2, abr2, otr1, obr1, otr2, obr2)
    dx = ∇interpolate(x, l, r)

    t = interpolate(x, z, w, atl1, atr1, atl2, atr2, otl1, otr1, otl2, otr2)
    b = interpolate(x, z, w, abl1, abr1, abl2, abr2, obl1, obr1, obl2, obr2)
    dy = ∇interpolate(y, t, b)

    v1 = interpolate(x, y, w, atl1, atr1, abl1, abr1, otl1, otr1, obl1, obr1)
    v2 = interpolate(x, y, w, atl2, atr2, abl2, abr2, otl2, otr2, obl2, obr2)
    dz = ∇interpolate(z, v1, v2)

    a = interpolate(x, y, z, atl1, atr1, abl1, abr1, atl2, atr2, abl2, abr2)
    o = interpolate(x, y, z, otl1, otr1, obl1, obr1, otl2, otr2, obl2, obr2)
    dw = ∇interpolate(w, a, o)
    return (dx, dy, dz, dw)
end


end