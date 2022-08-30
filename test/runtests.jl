using Noise
using Test
using Random30

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


@testset "range of perlin noise" begin
    Noise.set_seed(rand30(Int))
    mn = 1.0
    mx = 0.0
    for i=0:0.073:10000
        p = perlin_noise(i)
        mn = p < mn ? p : mn
        mx = p > mx ? p : mx
    end
    @test mx-mn > 0.95
    @test mx < 1
    @test mn > 0

    mn = 1.0
    mx = 0.0
    for i=0.5:1:100, j=0.5:1:100
        p = perlin_noise(i, j)
        mn = p < mn ? p : mn
        mx = p > mx ? p : mx
    end
    @test mx-mn > 0.95
    @test mx < 1
    @test mn > 0

    mn = 1.0
    mx = 0.0
    for i=0.5:1:200, j=0.5:1:200, k=0.5:1:200
        p = perlin_noise(i, j, k)
        mn = p < mn ? p : mn
        mx = p > mx ? p : mx
    end
    @test mx-mn > 0.86 # 0.9125 is about as much as i got
    @test mx < 1
    @test mn > 0

    mn, mx = f()
    @test mx-mn > 0.6 # cannot really hope for more if this test is supposed to end on this day...  (max like 0.67)
    @test mx < 1
    @test mn > 0

end

