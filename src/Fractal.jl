
Base.:(+)(x::NTuple{N, T}, y::NTuple{N, T}) where {N, T} = ntuple(i->(x[i] + y[i]), Val(N))

function fractal(f::F, x; nr_octaves::Val{N}=Val(4), persistence=cbrt(1/6), lacunarity=cbrt(7), cache_index=1, gradient=false) where {F, N}
    ti = N * (cache_index-1)
    amplitudes = ntuple(i->Float64(persistence^(i-1)), Val(N))
    amplitudes = amplitudes .* (1 / sum(amplitudes))

    sx = Float64(x)
    out = amplitudes[1] .* f(sx; cache_index=ti+1, gradient=gradient)
    for i=2:N
        sx *= lacunarity
        out = out + (amplitudes[i] .* f(sx; cache_index=ti+i, gradient=gradient))
    end
    
    return out
end

function fractal(f::F, x, y; nr_octaves::Val{N}=Val(4), persistence=cbrt(1/6), lacunarity=cbrt(7), cache_index=1, gradient=false) where {F, N}
    ti = N * (cache_index-1)
    amplitudes = ntuple(i->Float64(persistence^(i-1)), Val(N))
    amplitudes = amplitudes .* (1 / sum(amplitudes))

    sx, sy = Float64(x), Float64(y)
    out = amplitudes[1] .* f(sx, sy; cache_index=ti+1, gradient=gradient)
    for i=2:N
        sx *= lacunarity
        sy *= lacunarity
        out = out + (amplitudes[i] .* f(sx, sy; cache_index=ti+i, gradient=gradient))
    end
    
    return out
end

function fractal(f::F, x, y, z; nr_octaves::Val{N}=Val(4), persistence=cbrt(1/6), lacunarity=cbrt(7), cache_index=1, gradient=false) where {F, N}
    ti = N * (cache_index-1)
    amplitudes = ntuple(i->Float64(persistence^(i-1)), Val(N))
    amplitudes = amplitudes .* (1 / sum(amplitudes))

    sx, sy, sz = Float64(x), Float64(y), Float64(z)
    out = amplitudes[1] .* f(sx, sy, sz; cache_index=ti+1, gradient=gradient)
    for i=2:N
        sx *= lacunarity
        sy *= lacunarity
        sz *= lacunarity
        out = out + (amplitudes[i] .* f(sx, sy, sz; cache_index=ti+i, gradient=gradient))
    end
    
    return out
end

function fractal(f::F, x, y, z, w; nr_octaves::Val{N}=Val(4), persistence=cbrt(1/6), lacunarity=cbrt(7), cache_index=1, gradient=false) where {F, N}
    ti = N * (cache_index-1)
    amplitudes = ntuple(i->Float64(persistence^(i-1)), Val(N))
    amplitudes = amplitudes .* (1 / sum(amplitudes))

    sx, sy, sz, sw = Float64(x), Float64(y), Float64(z), Float64(w)
    out = amplitudes[1] .* f(sx, sy, sz, sw; cache_index=ti+1, gradient=gradient)
    for i=2:N
        sx *= lacunarity
        sy *= lacunarity
        sz *= lacunarity
        sw *= lacunarity
        out = out + (amplitudes[i] .* f(sx, sy, sz, sw; cache_index=ti+i, gradient=gradient))
    end
    
    return out
end