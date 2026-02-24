

octaves::NTuple{4, Float64} = (1.0, cbrt(7), sqrt(15), sqrt(62))
weights::NTuple{4, Float64} = (7/14, 4/14, 2/14, 1/14)

Base.:(+)(x::NTuple{2, Float64}, y::NTuple{2, Float64}) = ntuple(i->(x[i] + y[i]), Val(2))
Base.:(+)(x::NTuple{3, Float64}, y::NTuple{3, Float64}) = ntuple(i->(x[i] + y[i]), Val(3))

function fractal(f, x)
    if f == worley_noise
        oct = octaves[1]
        out = f(oct * x; cache_index=1)
        out .*= weights[1]

        for i=2:4
            oct = octaves[i]
            out .+= weights[i] .* f(oct * x; cache_index=i)
        end

        return out
    end

    sum((weights[i] * f(octaves[i] * x; cache_index=i) for i=1:4))
end

function fractal(f, x, y)
    if f == worley_noise
        oct = octaves[1]
        out = f(oct * x, oct * y; cache_index=1)
        out .*= weights[1]

        for i=2:4
            oct = octaves[i]
            out .+= weights[i] .* f(oct * x, oct * y; cache_index=i)
        end

        return out
    end

    sum((weights[i] .* f(octaves[i] * x, octaves[i] * y; cache_index=i) for i=1:4))
end

function fractal(f, x, y, z)
    if f == worley_noise
        oct = octaves[1]
        out = f(oct * x, oct * y, oct * z; cache_index=1)
        out .*= weights[1]

        for i=2:4
            oct = octaves[i]
            out .+= weights[i] .* f(oct * x, oct * y, oct * z; cache_index=i)
        end

        return out
    end

    sum((weights[i] .* f(octaves[i] * x, octaves[i] * y, octaves[i] * z; cache_index=i) for i=1:4))
end

function fractal(f, x, y, z, w)
    if f == worley_noise
        oct = octaves[1]
        out = f(oct * x, oct * y, oct * z, oct * w; cache_index=1)
        out .*= weights[1]

        for i=2:4
            oct = octaves[i]
            out .+= weights[i] .* f(oct * x, oct * y, oct * z, oct * w; cache_index=i)
        end

        return out
    end

    sum((weights[i] .* f(octaves[i] * x, octaves[i] * y, octaves[i] * z, octaves[i] * w; cache_index=i) for i=1:4))
end
