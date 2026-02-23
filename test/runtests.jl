using PNoise
using Test
using Plots

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

    worley_noise(10)
    worley_noise(10)
    worley_noise(10, 2.2)
    worley_noise(10, 2.2)
    worley_noise(10, 2.2, 3.3)
    worley_noise(10, 2.2, 3.3)
    worley_noise(UInt8(10), 2.2, 3.3, 4.4)
    worley_noise(10, 2.2, 3.3, 4.4)

    fractal(perlin_noise, 10)
    fractal(perlin_noise, 10, 2.2)
    fractal(perlin_noise, 10, 2.2, 3.3)
    fractal(perlin_noise, UInt8(10), 2.2, 3.3, 4.4)


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

    @test 0 == @allocations worley_noise(1)
    @test 0 == @allocations worley_noise(1)
    @test 0 == @allocations worley_noise(1, 2.2)
    @test 0 == @allocations worley_noise(1, 2.2)
    @test 0 == @allocations worley_noise(1, 2.2, 3.3)
    @test 0 == @allocations worley_noise(1, 2.2, 3.3)
    @test 0 == @allocations worley_noise(UInt8(1), 2.2, 3.3, 4.4)
    @test 0 == @allocations worley_noise(1, 2.2, 3.3, 4.4)

    @test 0 == @allocations sim_noise2d(1, 2.2)
    @test 0 == @allocations sim_noise2d(1, 2.2, 3.3)

    @test 0 == @allocations sim_noise3d(1, 2.2, 5.6)
    @test 0 == @allocations sim_noise3d(1, 2.2, 5.6, 3.3)

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

    @test 0 == @allocations fractal(worley_noise, 1)
    @test 0 == @allocations fractal(worley_noise, 1, 2.2)
    @test 0 == @allocations fractal(worley_noise, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(worley_noise, UInt8(1), 2.2, 3.3, 4.4)

    @test 0 == @allocations fractal(sim_noise2d, 1, 2.2)
    @test 0 == @allocations fractal(sim_noise2d, UInt8(1), 2.2, 3.3)

    @test 0 == @allocations fractal(sim_noise3d, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(sim_noise3d, 1, 2.2, 3.3)
    @test 0 == @allocations fractal(sim_noise3d, UInt8(1), 2.2, 3.3, 4.4)
    @test 0 == @allocations fractal(sim_noise3d, 1, 2.2, 3.3, 4.4)
end
