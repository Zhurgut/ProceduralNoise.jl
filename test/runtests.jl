using PNoise
using Test
import Plots
using LinearAlgebra: norm

@testset "Noise.jl" begin
    # Write your tests here.
end

@testset "allocs" begin
    random_noise(10)
    random_noise(10, 2.2)
    random_noise(10, 2.2, 3.3)
    random_noise(10, 2.2, 3.3, 4.4)

    value_noise(10)
    value_noise(10, 2.2)
    value_noise(10, 2.2, 3.3)
    value_noise(10, 2.2, 3.3, 4.4)

    perlin_noise(10)
    perlin_noise(10)
    perlin_noise(10, 2.2)
    perlin_noise(10, 2.2)
    perlin_noise(10, 2.2, 3.3)
    perlin_noise(10, 2.2, 3.3)
    perlin_noise(10, 2.2, 3.3, 4.4)
    perlin_noise(10, 2.2, 3.3, 4.4)

    worley_noise1(10)
    worley_noise1(10)
    worley_noise1(10, 2.2)
    worley_noise1(10, 2.2)
    worley_noise1(10, 2.2, 3.3)
    worley_noise1(10, 2.2, 3.3)
    worley_noise1(UInt8(10), 2.2, 3.3, 4.4)
    worley_noise1(10, 2.2, 3.3, 4.4)

    fractal(perlin_noise, 10)
    fractal(perlin_noise, 10, 2.2)
    fractal(perlin_noise, 10, 2.2, 3.3)
    fractal(perlin_noise, UInt8(10), 2.2, 3.3, 4.4)

    fractal(perlin_noise, 10, gradient=true)
    fractal(perlin_noise, 10, 2.2, gradient=true)
    fractal(perlin_noise, 10, 2.2, 3.3, gradient=true)
    fractal(perlin_noise, UInt8(10), 2.2, 3.3, 4.4, gradient=true)

    fractal(worley_noise1, 10)
    fractal(worley_noise1, 10, 2.2)
    fractal(worley_noise1, 10, 2.2, 3.3)
    fractal(worley_noise1, UInt8(10), 2.2, 3.3, 4.4)

    fractal(sim_noise2d, 1, 2.2)
    fractal(sim_noise2d, UInt8(1), 2.2, 3.3)

    fractal(sim_noise3d, 1, 2.2, 3.3)
    fractal(sim_noise3d, UInt8(1), 2.2, 3.3, 4.4)

    fractal(curl_noise, 1, 2.2, 3.3)
    fractal(curl_noise, UInt8(1), 2.2, 3.3, 4.4)

    fractal(bitangent_noise, 1, 2.2, 3.3)
    fractal(bitangent_noise, UInt8(1), 2.2, 3.3, 4.4)


    @test 0 == @allocations random_noise(1)
    @test 0 == @allocations random_noise(1, 2.2)
    @test 0 == @allocations random_noise(UInt8(1), 2.2, 3.3)
    @test 0 == @allocations random_noise(1, 2.2, 3.3, 4.4)

    @test 0 == @allocations value_noise(1)
    @test 0 == @allocations value_noise(1, 2.2)
    @test 0 == @allocations value_noise(UInt8(1), 2.2, 3.3)
    @test 0 == @allocations value_noise(1, 2.2, 3.3, 4.4)

    @test 0 == @allocations perlin_noise(1)
    @test 0 == @allocations perlin_noise(1)
    @test 0 == @allocations perlin_noise(1, 2.2)
    @test 0 == @allocations perlin_noise(1, 2.2)
    @test 0 == @allocations perlin_noise(1, 2.2, 3.3)
    @test 0 == @allocations perlin_noise(1, 2.2, 3.3)
    @test 0 == @allocations perlin_noise(UInt8(1), 2.2, 3.3, 4.4)
    @test 0 == @allocations perlin_noise(1, 2.2, 3.3, 4.4)

    @test 0 == @allocations worley_noise1(1)
    @test 0 == @allocations worley_noise1(1)
    @test 0 == @allocations worley_noise1(1, 2.2)
    @test 0 == @allocations worley_noise1(1, 2.2)
    @test 0 == @allocations worley_noise1(1, 2.2, 3.3)
    @test 0 == @allocations worley_noise1(1, 2.2, 3.3)
    @test 0 == @allocations worley_noise1(UInt8(1), 2.2, 3.3, 4.4)
    @test 0 == @allocations worley_noise1(1, 2.2, 3.3, 4.4)

    @test 0 == @allocations sim_noise2d(1, 2.2)
    @test 0 == @allocations sim_noise2d(1, 2.2, 3.3)

    @test 0 == @allocations sim_noise3d(1, 2.2, 5.6)
    @test 0 == @allocations sim_noise3d(UInt8(1), 2.2, 5.6, 3.3)

    @test 0 == @allocations curl_noise(1, 2.2, 5.6)
    @test 0 == @allocations curl_noise(UInt8(1), 2.2, 5.6, 3.3)

    @test 0 == @allocations bitangent_noise(1, 2.2, 5.6)
    @test 0 == @allocations bitangent_noise(UInt8(1), 2.2, 5.6, 3.3)

    @test 0 == @allocations fractal(perlin_noise, 1)
    @test 0 == @allocations fractal(perlin_noise, 1)
    @test 0 == @allocations fractal(perlin_noise, 1, 2.2)
    @test 0 == @allocations fractal(perlin_noise, 1, 2.2)
    @test 0 == @allocations fractal(perlin_noise, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(perlin_noise, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(perlin_noise, UInt8(1), 2.2, 3.3, 4.4)
    @test 0 == @allocations fractal(perlin_noise, 1, 2.2, 3.3, 4.4)

    @test 0 == @allocations fractal(random_noise, 1)
    @test 0 == @allocations fractal(random_noise, 1, 2.2)
    @test 0 == @allocations fractal(random_noise, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(random_noise, UInt8(1), 2.2, 3.3, 4.4)

    @test 0 == @allocations fractal(value_noise, 1)
    @test 0 == @allocations fractal(value_noise, 1, 2.2)
    @test 0 == @allocations fractal(value_noise, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(value_noise, UInt8(1), 2.2, 3.3, 4.4)

    @test 0 == @allocations fractal(worley_noise1, 1)
    @test 0 == @allocations fractal(worley_noise1, 1, 2.2)
    @test 0 == @allocations fractal(worley_noise1, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(worley_noise1, UInt8(1), 2.2, 3.3, 4.4)

    @test 0 == @allocations fractal(sim_noise2d, 1, 2.2)
    @test 0 == @allocations fractal(sim_noise2d, UInt8(1), 2.2, 3.3)

    @test 0 == @allocations fractal(sim_noise3d, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(sim_noise3d, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(sim_noise3d, UInt8(1), 2.2, 3.3, 4.4)
    @test 0 == @allocations fractal(sim_noise3d, 1, 2.2, 3.3, 4.4)

    @test 0 == @allocations fractal(curl_noise, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(curl_noise, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(curl_noise, UInt8(1), 2.2, 3.3, 4.4)
    @test 0 == @allocations fractal(curl_noise, 1, 2.2, 3.3, 4.4)

    @test 0 == @allocations fractal(bitangent_noise, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(bitangent_noise, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(bitangent_noise, UInt8(1), 2.2, 3.3, 4.4)
    @test 0 == @allocations fractal(bitangent_noise, 1, 2.2, 3.3, 4.4)

    @test 0 == @allocations value_noise(1, gradient=true)
    @test 0 == @allocations value_noise(1, 2.2, gradient=true)
    @test 0 == @allocations value_noise(UInt8(1), 2.2, 3.3, gradient=true)
    @test 0 == @allocations value_noise(1, 2.2, 3.3, 4.4, gradient=true)

    @test 0 == @allocations perlin_noise(1, gradient=true)
    @test 0 == @allocations perlin_noise(1, gradient=true)
    @test 0 == @allocations perlin_noise(1, 2.2, gradient=true)
    @test 0 == @allocations perlin_noise(1, 2.2, gradient=true)
    @test 0 == @allocations perlin_noise(1, 2.2, 3.3, gradient=true)
    @test 0 == @allocations perlin_noise(1, 2.2, 3.3, gradient=true)
    @test 0 == @allocations perlin_noise(UInt8(1), 2.2, 3.3, 4.4, gradient=true)
    @test 0 == @allocations perlin_noise(1, 2.2, 3.3, 4.4, gradient=true)

    @test 0 == @allocations fractal(perlin_noise, 1, gradient=true)
    @test 0 == @allocations fractal(perlin_noise, 1, gradient=true)
    @test 0 == @allocations fractal(perlin_noise, 1, 2.2, gradient=true)
    @test 0 == @allocations fractal(perlin_noise, 1, 2.2, gradient=true)
    @test 0 == @allocations fractal(perlin_noise, 1, 2.2, 3.3, gradient=true)
    @test 0 == @allocations fractal(perlin_noise, 1, 2.2, 3.3, gradient=true)
    @test 0 == @allocations fractal(perlin_noise, UInt8(1), 2.2, 3.3, 4.4, gradient=true)
    @test 0 == @allocations fractal(perlin_noise, 1, 2.2, 3.3, 4.4, gradient=true)

    @test 0 == @allocations fractal(random_noise, 1, gradient=true)
    @test 0 == @allocations fractal(random_noise, 1, 2.2, gradient=true)
    @test 0 == @allocations fractal(random_noise, 1, 2.2, 3.3, gradient=true)
    @test 0 == @allocations fractal(random_noise, UInt8(1), 2.2, 3.3, 4.4, gradient=true)

    @test 0 == @allocations fractal(value_noise, 1, gradient=true)
    @test 0 == @allocations fractal(value_noise, 1, 2.2, gradient=true)
    @test 0 == @allocations fractal(value_noise, 1, 2.2, 3.3, gradient=true)
    @test 0 == @allocations fractal(value_noise, UInt8(1), 2.2, 3.3, 4.4, gradient=true)

    @test 0 == @allocations fractal(worley_noise1, 1, gradient=true, nr_octaves=Val(3), persistence=0.4, lacunarity=2.2)
    @test 0 == @allocations fractal(worley_noise1, 1, 2.2, gradient=true, nr_octaves=Val(3), persistence=0.4, lacunarity=2.2)
    @test 0 == @allocations fractal(worley_noise1, 1, 2.2, 3.3, gradient=true, nr_octaves=Val(3), persistence=0.4, lacunarity=2.2)
    @test 0 == @allocations fractal(worley_noise1, UInt8(1), 2.2, 3.3, 4.4, gradient=true, nr_octaves=Val(3), persistence=0.4, lacunarity=2.2)
    
    @test 0 == @allocations fractal(worley_noise8, 1, gradient=true)
    @test 0 == @allocations fractal(worley_noise8, 1, 2.2, gradient=true)
    @test 0 == @allocations fractal(worley_noise8, 1, 2.2, 3.3, gradient=true)
    @test 0 == @allocations fractal(worley_noise8, UInt8(1), 2.2, 3.3, 4.4, gradient=true)
end



@testset "gradients" begin
    fns = [value_noise, perlin_noise, worley_noise1, worley_noise2, worley_noise3, worley_noise4, worley_noise5, worley_noise6, worley_noise7, worley_noise8]
    N = 1
    for f in fns
        println(f)
        println("1D")
        for i=1:N
            r1, r2, r3, r4 = 20 .* rand(4) .- 10
            grad = f(r1, gradient=true)
            fgrad = 1e6 .* (f(r1) - f(r1-1e-6),)
            @test norm(grad .- fgrad) < 1e-4
        end
        println("2D")
        for i=1:N
            r1, r2, r3, r4 = 20 .* rand(4) .- 10
            grad = f(r1, r2, gradient=true)
            fgrad = 1e6 .* (f(r1, r2) - f(r1-1e-6, r2), f(r1, r2) - f(r1, r2-1e-6))
            @test norm(grad .- fgrad) < 1e-4
        end
        println("3D")
        for i=1:N
            r1, r2, r3, r4 = 20 .* rand(4) .- 10
            grad = f(r1, r2, r3, gradient=true)
            fgrad = 1e6 .* (f(r1, r2, r3) - f(r1-1e-6, r2, r3), f(r1, r2, r3) - f(r1, r2-1e-6, r3), f(r1, r2, r3) - f(r1, r2, r3-1e-6))
            @test norm(grad .- fgrad) < 1e-4
        end
        println("4D")
        for i=1:N
            r1, r2, r3, r4 = 20 .* rand(4) .- 10
            grad = f(r1, r2, r3, r4, gradient=true)
            v = f(r1, r2, r3, r4)
            fgrad = 1e6 .* (v - f(r1-1e-6, r2, r3, r4), v - f(r1, r2-1e-6, r3, r4), v - f(r1, r2, r3-1e-6, r4), v - f(r1, r2, r3, r4-1e-6))
            @test norm(grad .- fgrad) < 1e-4
        end
    end

end

@testset "normalization" begin
    N = 10000
    fns = [random_noise, value_noise, perlin_noise, worley_noise1, worley_noise2, worley_noise3, worley_noise4, worley_noise5, worley_noise6, worley_noise7, worley_noise8]
    for f in fns
        println(f)
        mn = 2.0
        mx = -1.0
        println("1D")
        for i=1:N
            r1 = 2000 * rand() - 1000
            x = f(r1, cache_index=1)
            mn, mx = min(mn, x), max(mx, x)
        end
        println(mn, ", ", mx)
        @test mn >= 0
        @test mx <= 1

        mn = 2.0
        mx = -1.0
        println("2D")
        for i=1:N
            r1, r2, r3, r4 = 2000 .* rand(4) .- 1000
            x = f(r1, r2, cache_index=2)
            mn, mx = min(mn, x), max(mx, x)
        end
        println(mn, ", ", mx)
        @test mn >= 0
        @test mx <= 1

        mn = 2.0
        mx = -1.0
        println("3D")
        for i=1:N
            r1, r2, r3, r4 = 2000 .* rand(4) .- 1000
            x = f(r1, r2, r3, cache_index=3)
            mn, mx = min(mn, x), max(mx, x)
        end
        println(mn, ", ", mx)
        @test mn >= 0
        @test mx <= 1

        mn = 2.0
        mx = -1.0
        println("4D")
        for i=1:N
            r1, r2, r3, r4 = 2000 .* rand(4) .- 1000
            x = f(r1, r2, r3, r4, cache_index=4)
            mn, mx = min(mn, x), max(mx, x)
        end
        println(mn, ", ", mx)
        @test mn >= 0
        @test mx <= 1
    end
    
end

