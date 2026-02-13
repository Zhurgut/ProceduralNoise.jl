using PNoise
using PNoise.Interpolate
using Test
using Plots

@testset "Noise.jl" begin
    # Write your tests here.
end

function f()
    mn = 1.0
    mx = 0.0
    for i=0.5:1:100
        println("$i: $(mn) - $(mx)")
        for j=0.5:1:200, k=0.5:1:100, l=0.5:1:100
            p = perlin_noise(i, j, k, l)
            mn = p < mn ? p : mn
            mx = p > mx ? p : mx
        end
    end
    return mn, mx
end

function intp_plots()
    X = collect(0:0.01:1)
    L = 1
    R = 2
    Y = interpolate.(X, L, R)

    r = rand()
    Y2 = interpolate.(X, r, L, R, R, L)
    p = plot(X, Y)
    plot!(p, X, Y2)
end
intp_plots()


# @testset "range of perlin noise" begin
#     PNoise.set_seed(rand(Int))
#     mn = 1.0
#     mx = 0.0
#     for i=0:0.073:10000
#         p = perlin_noise(i)
#         mn = p < mn ? p : mn
#         mx = p > mx ? p : mx
#     end
#     @test mx-mn > 0.95
#     @test mx < 1
#     @test mn > 0

#     mn = 1.0
#     mx = 0.0
#     for i=0.5:1:100, j=0.5:1:100
#         p = perlin_noise(i, j)
#         mn = p < mn ? p : mn
#         mx = p > mx ? p : mx
#     end
#     @test mx-mn > 0.95
#     @test mx < 1
#     @test mn > 0

#     mn = 1.0
#     mx = 0.0
#     for i=0.5:1:200, j=0.5:1:200, k=0.5:1:200
#         p = perlin_noise(i, j, k)
#         mn = p < mn ? p : mn
#         mx = p > mx ? p : mx
#     end
#     @test mx-mn > 0.86 # 0.9125 is about as much as i got
#     @test mx < 1
#     @test mn > 0

#     mn, mx = f()
#     @test mx-mn > 0.6 # cannot really hope for more if this test is supposed to end on this day...  (max like 0.67)
#     @test mx < 1
#     @test mn > 0

# end

