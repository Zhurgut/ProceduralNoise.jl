
include("../src/Interpolate.jl")
using .Interpolate



function time_div()
    x = rand()
    L = rand()

    N = 100
    M = 100

    ts = zeros(Float64, M)
    for m=1:M
        ts[m] = @elapsed begin
            for i = 1:N
                x = @fastmath L * (1 / x)
            end
        end
    end

    sort!(ts)
    t = ts[5]
    t = t / N # time per call
    c = t*1000_000_000*4.5 # cycles per call
    tp = 1 / t # calls per second
    t = "$(Int(round(tp)))"

    println("$t calls / second\t ($(round(c, digits=2)) cycles latency)")

    return x
end


# >= 30 cycles
function time_it_1d()
    x = rand()

    L = rand()
    R = rand()

    N = 100000
    M = 1000

    ts = zeros(Float64, M)
    for m=1:M
        ts[m] = @elapsed begin
            for i = 1:N
                x = interpolate(x, L, R)
            end
        end
    end

    sort!(ts)
    t = ts[5]
    t = t / N # time per call
    c = t*1000_000_000*4.5 # cycles per call
    tp = 1 / t # calls per second
    t = "$(Int(round(tp)))"

    println("$t calls / second\t ($(round(c, digits=2)) cycles latency)")

    return x
end


function time_it_2d()
    x = rand()
    y = rand()

    L = rand()
    R = rand()

    N = 100000
    M = 1000

    ts = zeros(Float64, M)
    for m=1:M
        ts[m] = @elapsed begin
            for i = 1:N
                x = interpolate(x, y, L, R, 0.9L, 0.8R)
                y = 1-x
            end
        end
    end

    sort!(ts)
    t = ts[5]
    t = t / N # time per call
    c = t*1000_000_000*4.5 # cycles per call
    tp = 1 / t # calls per second
    t = "$(Int(round(tp)))"

    println("$t calls / second\t ($(round(c, digits=2)) cycles latency)", x, y)

    return c
end

function time_it_3d()
    x = rand()
    y = rand()
    z = rand()

    L = rand()
    R = rand()

    N = 1000
    M = 300

    ts = zeros(Float64, M)
    for m=1:M
        
        ts[m] = @elapsed begin
            for i = 1:N
                x = interpolate(x, y, z, L, R, 0.8L, 0.9R, 0.7L, 0.89R, 0.98L, 0.88R)
                y = 1-x
                z = 0.999-x
            end
        end
    end

    sort!(ts)
    t = ts[5]
    t = t / N # time per call
    c = t*1000_000_000*4.5 # cycles per call
    tp = 1 / t # calls per second
    t = "$(Int(round(tp)))"

    println("$t calls / second\t ($(round(c, digits=2)) cycles latency)")

    return x, y, z
end



function time_it_4d()
    x = rand()
    y = rand()
    z = rand()
    w = rand()

    L = rand()
    R = rand()

    N = 10000
    M = 300

    ts = zeros(Float64, M)
    for m=1:M
        ts[m] = @elapsed begin
            for i = 1:N
                x = interpolate(x, y, z, w, L, R, 0.8L, 0.9R, 0.7L, 0.89R, 0.98L, 0.88R, 0.987L, 0.789R, 0.86L, 0.69R, 0.76L, 0.896R, 0.986L, 0.886R)
                y = 1-x
                z = 0.999-x
                w = 0.98 - x
            end
        end
    end

    sort!(ts)
    t = ts[5]
    t = t / N # time per call
    c = t*1000_000_000*4.5 # cycles per call
    tp = 1 / t # calls per second
    t = "$(Int(round(tp)))"

    println("$t calls / second\t ($(round(c, digits=2)) cycles latency)")

    return x, y, z, w
end

println("latency: ")
print("div "); time_div()
print("it1d "); time_it_1d()
print("it2d "); time_it_2d()
print("it3d "); time_it_3d()
print("it4d "); time_it_4d()
println("(just looking for linear scaling)")