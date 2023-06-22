
using Test
include("../src/Interpolate.jl")
using .Interpolate
using BenchmarkTools

i1(x, l, r) = l + (6x^5 - 15x^4 + 10x^3)*(r - l)
function i2(x, y, tl, tr, bl, br)
    t = i1(x, tl, tr)
    b = i1(x, bl, br)
    return i1(y, t, b)
end
function i3(x, y, z, tl1, tr1, bl1, br1, tl2, tr2, bl2, br2)
    v1 = i2(x, y, tl1, tr1, bl1, br1)
    v2 = i2(x, y, tl2, tr2, bl2, br2)
    return i1(z, v1, v2)
end
function i4(x, y, z, w, atl1, atr1, abl1, abr1, atl2, atr2, abl2, abr2, otl1, otr1, obl1, obr1, otl2, otr2, obl2, obr2)
    a = i3(x, y, z, atl1, atr1, abl1, abr1, atl2, atr2, abl2, abr2)
    o = i3(x, y, z, otl1, otr1, obl1, obr1, otl2, otr2, obl2, obr2)
    return i1(w, a, o)
end

function f_equals(ref, f, dim)
    vals_ref = zeros(Float64, 1000)
    vals_f   = zeros(Float64, 1000)
    for i=1:1000
        coords = rand(dim)
        its = 10 .* randn(2^dim)
        vals_ref[i] = ref(coords..., its...)
        vals_f[i]   = f(coords..., its...)
    end
    return (vals_ref .- vals_f).^2 |> sum
end

@testset "correctness" begin
    @test f_equals(i1, interpolate, 1) <= 0.00001
    @test f_equals(i2, interpolate, 2) <= 0.00001
    @test f_equals(i3, interpolate, 3) <= 0.00001
    @test f_equals(i4, interpolate, 4) <= 0.00001
end


function f1() 
    dim = 1
    numbers = randn(2048)
    argc = 2^dim
    ncalls = 2048 ÷ argc
    coords = rand(dim*ncalls)
    results = zeros(Float64, ncalls)
    for l=1:10
        for i=1:ncalls
            results[i] = i1(coords[i], numbers[(i-1)*argc+1], numbers[(i-1)*argc+2])
        end
    end
end

function f2() 
    dim = 2
    numbers = randn(2048)
    argc = 2^dim
    ncalls = 2048 ÷ argc
    coords = rand(dim*ncalls)
    results = zeros(Float64, ncalls)
    for l=1:10
        for i=1:ncalls
            results[i] = i2(coords[(i-1)*dim+1], coords[i*dim], numbers[(i-1)*argc+1], numbers[(i-1)*argc+2], numbers[(i-1)*argc+3], numbers[(i-1)*argc+4])
        end
    end
end

function f3() 
    dim = 3
    numbers = randn(2048)
    argc = 2^dim
    ncalls = 2048 ÷ argc
    coords = rand(dim*ncalls)
    results = zeros(Float64, ncalls)
    for l=1:10
        for i=1:ncalls
            results[i] = i3(coords[(i-1)*dim+1], coords[(i-1)*dim+2], coords[(i-1)*dim+3], 
                numbers[(i-1)*argc+1], numbers[(i-1)*argc+2], numbers[(i-1)*argc+3], numbers[(i-1)*argc+4],
                numbers[(i-1)*argc+1+4], numbers[(i-1)*argc+2+4], numbers[(i-1)*argc+3+4], numbers[(i-1)*argc+4+4])
        end
    end
end

function f4() 
    dim = 4
    numbers = randn(2048)
    argc = 2^dim
    ncalls = 2048 ÷ argc
    coords = rand(dim*ncalls)
    results = zeros(Float64, ncalls)
    for l=1:10
        for i=1:ncalls
            results[i] = i4(coords[(i-1)*dim+1], coords[(i-1)*dim+2], coords[(i-1)*dim+3], coords[(i-1)*dim+4],
                numbers[(i-1)*argc+1], numbers[(i-1)*argc+2], numbers[(i-1)*argc+3], numbers[(i-1)*argc+4],
                numbers[(i-1)*argc+1+4], numbers[(i-1)*argc+2+4], numbers[(i-1)*argc+3+4], numbers[(i-1)*argc+4+4],
                numbers[(i-1)*argc+1+8], numbers[(i-1)*argc+2+8], numbers[(i-1)*argc+3+8], numbers[(i-1)*argc+4+8],
                numbers[(i-1)*argc+1+4+8], numbers[(i-1)*argc+2+4+8], numbers[(i-1)*argc+3+4+8], numbers[(i-1)*argc+4+4+8]
            
            )
        end
    end
end

function g1() 
    dim = 1
    numbers = randn(2048)
    argc = 2^dim
    ncalls = 2048 ÷ argc
    coords = rand(dim*ncalls)
    results = zeros(Float64, ncalls)
    for l=1:10
        for i=1:ncalls
            results[i] = interpolate(coords[i], numbers[(i-1)*argc+1], numbers[(i-1)*argc+2])
        end
    end
end

function g2() 
    dim = 2
    numbers = randn(2048)
    argc = 2^dim
    ncalls = 2048 ÷ argc
    coords = rand(dim*ncalls)
    results = zeros(Float64, ncalls)
    for l=1:10
        for i=1:ncalls
            results[i] = interpolate(coords[(i-1)*dim+1], coords[i*dim], numbers[(i-1)*argc+1], numbers[(i-1)*argc+2], numbers[(i-1)*argc+3], numbers[(i-1)*argc+4])
        end
    end
end

function g3() 
    dim = 3
    numbers = randn(2048)
    argc = 2^dim
    ncalls = 2048 ÷ argc
    coords = rand(dim*ncalls)
    results = zeros(Float64, ncalls)
    for l=1:10
        for i=1:ncalls
            results[i] = interpolate(coords[(i-1)*dim+1], coords[(i-1)*dim+2], coords[(i-1)*dim+3], 
                numbers[(i-1)*argc+1], numbers[(i-1)*argc+2], numbers[(i-1)*argc+3], numbers[(i-1)*argc+4],
                numbers[(i-1)*argc+1+4], numbers[(i-1)*argc+2+4], numbers[(i-1)*argc+3+4], numbers[(i-1)*argc+4+4])
        end
    end
end

function g4() 
    dim = 4
    numbers = randn(2048)
    argc = 2^dim
    ncalls = 2048 ÷ argc
    coords = rand(dim*ncalls)
    results = zeros(Float64, ncalls)
    for l=1:10
        for i=1:ncalls
            results[i] = interpolate(coords[(i-1)*dim+1], coords[(i-1)*dim+2], coords[(i-1)*dim+3], coords[(i-1)*dim+4],
                numbers[(i-1)*argc+1], numbers[(i-1)*argc+2], numbers[(i-1)*argc+3], numbers[(i-1)*argc+4],
                numbers[(i-1)*argc+1+4], numbers[(i-1)*argc+2+4], numbers[(i-1)*argc+3+4], numbers[(i-1)*argc+4+4],
                numbers[(i-1)*argc+1+8], numbers[(i-1)*argc+2+8], numbers[(i-1)*argc+3+8], numbers[(i-1)*argc+4+8],
                numbers[(i-1)*argc+1+4+8], numbers[(i-1)*argc+2+4+8], numbers[(i-1)*argc+3+4+8], numbers[(i-1)*argc+4+4+8]
            
            )
        end
    end
end

function speed()
    f1();f2();f3();f4()
    g1();g2();g3();g4()
    println("speedup (over stoopid implementation, on some arbitrary benchmark code)")
    println("1d: ", (@belapsed f1()) / (@belapsed g1()))
    println("2d: ", (@belapsed f2()) / (@belapsed g2()))
    println("3d: ", (@belapsed f3()) / (@belapsed g3()))
    println("4d: ", (@belapsed f4()) / (@belapsed g4()))
end

speed()