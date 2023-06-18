
struct Vertex
    parents::Vector{Int8}
end

struct Graph
    origin::Vertex
    verteces::Vector{Vertex}
end

Vertex() = Vertex(Int8[])
Graph(n) = Graph(Vertex(), [Vertex() for i=1:n])

function edge!(g, i, j)
    if i==0
        push!(g.verteces[j].parents, 0)
    else
        push!(g.verteces[j].parents, i)
    end
end

function random_order(graph)
    orders::Vector{Vector{Int8}} = []
    start_order = [Int8(i) for i=1:length(graph.verteces) if 0 ∈ graph.verteces[i].parents]
    return random_order(graph, start_order, all_available(graph, start_order))
end


function random_order(graph, order_so_far, options)
    if length(options) == 0
        return order_so_far
    end
    n = length(options)
    r = rand(1:n)
    current_order = [order_so_far; Int8(options[r])]
    new_options = options ∪ all_available(graph, current_order)
    new_options = setdiff!(new_options, current_order)
    return random_order(graph, current_order, new_options)
end

function is_reachable(i, g, visited)
    deps = g.verteces[i].parents
    return deps ⊆ visited
end

function all_available(g, visited)
    reachables = Int8[]
    for i=1:length(g.verteces)
        if is_reachable(i, g, visited)
            push!(reachables, Int8(i))
        end
    end
    return reachables
end

function variable_to_number(xi)
    xi = String(xi)
    n = xi[2:end]
    n = parse(Int, n)
end

function build_graph(expr)
    args = filter(x->!(x isa LineNumberNode), expr.args)
    assgn = args[1].head
    args = filter(x->(x.head == assgn), args)
    g = Graph(length(args))
    for e in args
        if e.args[2] isa Expr
            assigned = e.args[1]
            current_args = e.args[2].args[2:end] |> unique

            assigned = variable_to_number(assigned)
            current_args = variable_to_number.(current_args)

            for c in current_args
                edge!(g, c, assigned)
            end
        else
            n = variable_to_number(e.args[1])
            edge!(g, 0, n)
        end
    end
    return g
end

ex = quote
    x1 = a
    x2 = b
    x3 = c
    x4 = 4
    x5 = 2
    x6 = -x2
    x7 = x2*x2
    x8 = x1*x3
    x9 = x4*x8
    x10 = x7 - x9
    x11 = sqrt(x10)
    x12 = x5*x1 
    x13 = x6 + x11
    x14 = x13 / x12
    return x14
end

s(a, b, c) = (-b + sqrt(b*b - 4a*c)) / (2a)

function build_example()
    g = Graph(14)
    edge!(g, 0, 1)
    edge!(g, 0, 2)
    edge!(g, 0, 3)
    edge!(g, 0, 4)
    edge!(g, 0, 5)

    edge!(g, 2, 6)
    edge!(g, 2, 7)
    edge!(g, 1, 8) 
    edge!(g, 3, 8)
    edge!(g, 4, 9)
    edge!(g, 8, 9)
    edge!(g, 7, 10)
    edge!(g, 9, 10)
    edge!(g, 10, 11)
    edge!(g, 1, 12)
    edge!(g, 5, 12)
    edge!(g, 6, 13)
    edge!(g, 11, 13)
    edge!(g, 12, 14)
    edge!(g, 13, 14)
    g
end

function reorder(ordering, expr)
    args = filter(x->!(x isa LineNumberNode), expr.args)
    new_args = []
    for i in ordering
        push!(new_args, args[i])
    end
    push!(new_args, args[end])
    Expr(expr.head, new_args...)
end

a = Int8[1, 2, 3, 4, 5, 6, 7, 8, 9, 22, 19, 16, 24, 11, 12, 15, 18, 17, 26, 20, 13, 10, 21, 14, 23, 27, 25, 28] # best order
it2d = quote
    x1 = x
    x2 = y
    x3 = tl
    x4 = tr
    x5 = bl
    x6 = br
    x7 = 6
    x8 = -15
    x9 = 10
    x10 = x2*x2
    x11 = x1*x1
    x12 = fma(x7, x2, x8)
    x13 = x9*x2
    x14 = fma(x12, x10, x13)
    x15 = fma(x7, x1, x8)
    x16 = x9*x1
    x17 = fma(x15, x11, x16)
    x18 = x6-x5
    x19 = x4-x3
    x20 = x18-x19
    x21 = x10*x20
    x22 = x5-x3
    x23 = x10*x22
    x24 = x4-x3
    x25 = fma(x14, x21, x24)
    x26 = x11*x17
    x27 = fma(x14, x23, x3)
    x28 = fma(x26, x25, x27)
    return x28
end

function interpolate(x, y, tl, tr, bl, br)
    x1 = x
    x2 = y
    x3 = tl
    x4 = tr
    x5 = bl
    x6 = br
    x7 = 6
    x8 = -15
    x9 = 10
    x15 = fma(x7, x1, x8)
    x10 = x2 * x2
    x13 = x9 * x2
    x11 = x1 * x1
    x18 = x6 - x5
    x22 = x5 - x3
    x24 = x4 - x3
    x23 = x10 * x22
    x12 = fma(x7, x2, x8)
    x16 = x9 * x1
    x14 = fma(x12, x10, x13)
    x17 = fma(x15, x11, x16)
    x26 = x11 * x17
    x27 = fma(x14, x23, x3)
    x19 = x4 - x3
    x20 = x18 - x19
    x21 = x10 * x20
    x25 = fma(x14, x21, x24)
    x28 = fma(x26, x25, x27)
    return x28
end

function print_reordered(ordering, expr)
    ro = reorder(ordering, expr)
end

g = build_graph(it2d)
best = 100
best_order = nothing
order = nothing
for i=1:200
    optimize2d(g)
end


function redefine(g)
    ord = random_order(g)
    # println(ord)
    new_it2d = reorder(ord, it2d)
    
    eval(quote
        interpolate(x, y, tl, tr, bl, br) = $new_it2d
    end)

    return ord
end

function try_2d(ord)
    
    t = time_it_2d()

    global best
    global best_order
    if t < best
        best = t
        best_order = ord
        println(ord)
    end
end

function optimize2d(g)
    global order
    try_2d(order)
    order = redefine(g)
    
end

function time_it_2d(it)
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
                x = it(x, y, L, R, 0.9L, 0.8R)
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

    println("$t calls / second\t ($(round(c, digits=2)) cycles latency) ($x, $y)")

    return c
end
