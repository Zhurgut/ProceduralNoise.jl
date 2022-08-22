module Noise

using Random30

SEED::UInt64 = 0 # one seed to rule them all


include("Random.jl")
export random_noise

include("Value.jl")
export value_noise




@inline function interpolate(x, l, r)
    return @fastmath begin
        lw = (1-x)*(1-x)
        rw = x*x
        n = lw + rw
        (lw*l + rw*r) / n
    end
end

@inline function interpolate(x, y, tl, tr, bl, br)
    return @fastmath begin
        lw = (1-x)*(1-x)
        rw = x*x
        tw = (1-y)*(1-y)
        bw = y*y
        xn = lw + rw
        yn = tw + bw
        (tw*(lw*tl + rw*tr) + bw*(lw*bl + rw*br)) / (xn*yn)
    end
end

@inline function interpolate(x, y, z, tl1, tr1, bl1, br1, tl2, tr2, bl2, br2)
    return @fastmath begin
        lw = (1-x)*(1-x)
        rw = x*x
        tw = (1-y)*(1-y)
        bw = y*y
        w1 = (1-z)*(1-z)
        w2 = z*z
        xn = lw + rw
        yn = tw + bw
        zn = w1 + w2
        (w1*(tw*(lw*tl1 + rw*tr1) + bw*(lw*bl1 + rw*br1)) + w2*(tw*(lw*tl2 + rw*tr2) + bw*(lw*bl2 + rw*br2))) / (xn*yn*zn)
    end
end

# 12 ns
@inline function interpolate(x, y, z, w, atl1, atr1, abl1, abr1, atl2, atr2, abl2, abr2, otl1, otr1, obl1, obr1, otl2, otr2, obl2, obr2)
    return interpolate(w,
        interpolate(x, y, z, atl1, atr1, abl1, abr1, atl2, atr2, abl2, abr2),
        interpolate(x, y, z, otl1, otr1, obl1, obr1, otl2, otr2, obl2, obr2)
    )
end


end
