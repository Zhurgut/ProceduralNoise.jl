
function value_noise(x)
    l, r, dx = bounds(x)
    vl = random_from(l)[1]
    vr = random_from(r)[1]
    return interpolate(dx, vl, vr)
end

function value_noise(x, y)
    l, r, dx = bounds(x)
    b, t, dy = bounds(y)
    bl = random_from(b, l)[1]
    br = random_from(b, r)[1]
    tl = random_from(t, l)[1]
    tr = random_from(t, r)[1]
    return interpolate(dx, dy, bl, br, tl, tr)
end

function value_noise(x, y, z)
    l, r, dx = bounds(x)
    b, t, dy = bounds(y)
    a, o, dz = bounds(z)
    abl = random_from(a, b, l)[1]
    abr = random_from(a, b, r)[1]
    atl = random_from(a, t, l)[1]
    atr = random_from(a, t, r)[1]
    obl = random_from(o, b, l)[1]
    obr = random_from(o, b, r)[1]
    otl = random_from(o, t, l)[1]
    otr = random_from(o, t, r)[1]
    return interpolate(dx, dy, dz, abl, abr, atl, atr, obl, obr, otl, otr)
end

function value_noise(x, y, z, w)
    l, r, dx = bounds(x)
    b, t, dy = bounds(y)
    a, o, dz = bounds(z)
    w1, w2, dw = bounds(w)
    abl1 = random_from(a, b, l, w1)[1]
    abr1 = random_from(a, b, r, w1)[1]
    atl1 = random_from(a, t, l, w1)[1]
    atr1 = random_from(a, t, r, w1)[1]
    obl1 = random_from(o, b, l, w1)[1]
    obr1 = random_from(o, b, r, w1)[1]
    otl1 = random_from(o, t, l, w1)[1]
    otr1 = random_from(o, t, r, w1)[1]
    abl2 = random_from(a, b, l, w2)[1]
    abr2 = random_from(a, b, r, w2)[1]
    atl2 = random_from(a, t, l, w2)[1]
    atr2 = random_from(a, t, r, w2)[1]
    obl2 = random_from(o, b, l, w2)[1]
    obr2 = random_from(o, b, r, w2)[1]
    otl2 = random_from(o, t, l, w2)[1]
    otr2 = random_from(o, t, r, w2)[1]
    return interpolate(dx, dy, dz, dw, abl1, abr1, atl1, atr1, obl1, obr1, otl1, otr1, abl2, abr2, atl2, atr2, obl2, obr2, otl2, otr2)
end

