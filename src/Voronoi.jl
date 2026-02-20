
# distances from points 


let points::Matrix{Float64} = zeros(16, Threads.nthreads()),
    index::Vector{pad(Int)} = zeros(pad(Int), Threads.nthreads())
    nr_points::Vector{pad(Int)} = zeros(pad(Int), Threads.nthreads())

    function get_points!(idx, pos)
        ti = Threads.threadid()

        r, h = random_from(pos)

        p, h = more_random_from(h)
        points[idx, ti] = pos + p
        idx += 1
        
        if r < 0.1
            p, h = more_random_from(h)
            points[idx, ti] = pos + p
            idx += 1
        end

        if r < 0.02
            p, h = more_random_from(h)
            points[idx, ti] = pos + p
            idx += 1
        end

        return idx
    end

    function load()
        ti = Threads.threadid()
        @view points[1:nr_points[ti].value, ti]
    end

    function store!(l)
        i = 1
        for f=-2:2
            i = get_points!(i, l+f)
        end

        ti = Threads.threadid()
        len = i-1
        nr_points[ti] = Padding(len, nr_points[ti].padding)
        index[ti] = Padding(l, index[ti].padding)

        @view points[1:len, ti]
    end

    store!(0)


    global function voronoi_points(x)
        l, r, d = bounds(x)
        ti = Threads.threadid()
        return index[ti].value == l ? load() : store!(l)
    end

end


let points::Matrix{NTuple{2, Float64}} = zeros(NTuple{2, Float64}, (64, Threads.nthreads())),
    index::Vector{pad(Tuple{Int, Int})} = zeros(pad(Tuple{Int, Int}), Threads.nthreads())
    nr_points::Vector{pad(Int)} = zeros(pad(Int), Threads.nthreads())

    function get_points!(idx, p1, p2)
        ti = Threads.threadid()

        r, h = random_from(p1, p2)

        x, h = more_random_from(h)
        y, h = more_random_from(h)
        points[idx, ti] = (p1+x, p2+y)
        idx += 1
        
        if r < 0.1
            x, h = more_random_from(h)
            y, h = more_random_from(h)
            points[idx, ti] = (p1+x, p2+y)
            idx += 1
        end

        if r < 0.02
            x, h = more_random_from(h)
            y, h = more_random_from(h)
            points[idx, ti] = (p1+x, p2+y)
            idx += 1
        end

        return idx
    end

    function load()
        ti = Threads.threadid()
        @view points[1:nr_points[ti].value, ti]
    end

    function store!(l, b)
        i = 1
        for x=-2:2, y=-2:2
            if (abs(x) + abs(y) <= 3)
                i = get_points!(i, l+x, b+y)
            end
        end

        ti = Threads.threadid()
        len = i-1
        nr_points[ti] = Padding(len, nr_points[ti].padding)
        index[ti] = Padding((l, b), index[ti].padding)

        @view points[1:len, ti]
    end

    store!(0, 0)


    global function voronoi_points(x, y)
        l, r, dx = bounds(x)
        b, t, dy = bounds(y)
        ti = Threads.threadid()

        return index[ti].value == (l, b) ? load() : store!(l, b)
    end

end



let points::Matrix{NTuple{3, Float64}} = zeros(NTuple{3, Float64}, (160, Threads.nthreads())),
    index::Vector{pad(Tuple{Int, Int, Int})} = zeros(pad(Tuple{Int, Int, Int}), Threads.nthreads())
    nr_points::Vector{pad(Int)} = zeros(pad(Int), Threads.nthreads())

    function get_points!(idx, p1, p2, p3)
        ti = Threads.threadid()

        r, h = random_from(p1, p2, p3)

        x, h = more_random_from(h)
        y, h = more_random_from(h)
        z, h = more_random_from(h)
        points[idx, ti] = (p1+x, p2+y, p3+z)
        idx += 1
        
        if r < 0.1
            x, h = more_random_from(h)
            y, h = more_random_from(h)
            z, h = more_random_from(h)
            points[idx, ti] = (p1+x, p2+y, p3+z)
            idx += 1
        end

        if r < 0.02
            x, h = more_random_from(h)
            y, h = more_random_from(h)
            z, h = more_random_from(h)
            points[idx, ti] = (p1+x, p2+y, p3+z)
            idx += 1
        end

        return idx
    end

    function load()
        ti = Threads.threadid()
        @view points[1:nr_points[ti].value, ti]
    end

    function store!(l, b, a)
        i = 1
        for x=-2:2, y=-2:2, z=-2:2
            if (abs(x) + abs(y) + abs(z) <= 5)
                i = get_points!(i, l+x, b+y, a+z)
            end
        end

        ti = Threads.threadid()
        len = i-1
        nr_points[ti] = Padding(len, nr_points[ti].padding)
        index[ti] = Padding((l, b, a), index[ti].padding)

        @view points[1:len, ti]
    end

    store!(0, 0, 0)

    global function voronoi_points(x, y, z)
        l, r, dx = bounds(x)
        b, t, dy = bounds(y)
        a, o, dz = bounds(z)
        ti = Threads.threadid()

        return index[ti].value == (l, b, a) ? load() : store!(l, b, a)
    end

end




let points::Matrix{NTuple{4, Float64}} = zeros(NTuple{4, Float64}, (360, Threads.nthreads())),
    index::Vector{pad(Tuple{Int, Int, Int, Int})} = zeros(pad(Tuple{Int, Int, Int, Int}), Threads.nthreads())
    nr_points::Vector{pad(Int)} = zeros(pad(Int), Threads.nthreads())

    function get_points!(idx, p1, p2, p3, p4)
        ti = Threads.threadid()

        r, h = random_from(p1, p2, p3, p4)

        x, h = more_random_from(h)
        y, h = more_random_from(h)
        z, h = more_random_from(h)
        w, h = more_random_from(h)
        points[idx, ti] = (p1+x, p2+y, p3+z, p4+w)
        idx += 1
        
        if r < 0.1
            x, h = more_random_from(h)
            y, h = more_random_from(h)
            z, h = more_random_from(h)
            w, h = more_random_from(h)
            points[idx, ti] = (p1+x, p2+y, p3+z, p4+w)
            idx += 1
        end

        if r < 0.02
            x, h = more_random_from(h)
            y, h = more_random_from(h)
            z, h = more_random_from(h)
            w, h = more_random_from(h)
            points[idx, ti] = (p1+x, p2+y, p3+z, p4+w)
            idx += 1
        end

        return idx
    end

    function load()
        ti = Threads.threadid()
        @view points[1:nr_points[ti].value, ti]
    end

    function store!(l, b, a, v)
        i = 1
        
        for x=-2:2, y=-2:2, z=-2:2, w=-2:2
            if (abs(x) + abs(y) + abs(z) + abs(w) <= 7)
                i = get_points!(i, l+x, b+y, a+z, v+w)
                # println(i)
            end
        end

        ti = Threads.threadid()
        len = i-1
        nr_points[ti] = Padding(len, nr_points[ti].padding)
        index[ti] = Padding((l, b, a, v), index[ti].padding)

        @view points[1:len, ti]
    end

    store!(0, 0, 0, 0)


    global function voronoi_points(x, y, z, w)
        l, r, dx = bounds(x)
        b, t, dy = bounds(y)
        a, o, dz = bounds(z)
        v, _, _  = bounds(w)
        ti = Threads.threadid()

        return index[ti].value == (l, b, a, v) ? load() : store!(l, b, a, v)
    end

end





function min_max_dists2d()
    ds = []
    relevant = []
    for l=-3:3, b=-3:3
        r = l+1
        close_h, far_h = abs(l) < abs(r) ? (l, r) : (r, l)
        t = b+1
        close_v, far_v = abs(b) < abs(t) ? (b, t) : (t, b)
        close_d = sqrt(close_h^2 + close_v^2)
        far_d = sqrt(far_h^2 + far_v^2)
        push!(ds, ((l, b), close_d, far_d))
        if (close_d < sqrt(2))
            push!(relevant, (b, l))
        end
    end
    display(relevant)
    by_l1 = []
    for l1 = 0:5
        mn = 10000
        mx = 0
        for d in ds
            (l,b), cl, fr = d
            l1_dist = abs(l) + abs(b)
            if l1_dist == l1
                mn = min(mn, cl)
                mx = max(mx, fr)
            end
        end
        push!(by_l1, (l1, mn, mx))
    end
    display(by_l1)
end

function min_max_dists3d()
    ds = []
    relevant = []
    for l=-3:3, b=-3:3, a=-3:3
        r = l+1
        close_h, far_h = abs(l) < abs(r) ? (l, r) : (r, l)
        t = b+1
        close_v, far_v = abs(b) < abs(t) ? (b, t) : (t, b)
        o = a+1
        close_q, far_q = abs(a) < abs(o) ? (a, o) : (o, a)
        close_d = sqrt(close_h^2 + close_v^2 + close_q^2)
        far_d = sqrt(far_h^2 + far_v^2 + far_q^2)
        push!(ds, ((l, b, a), close_d, far_d))
        if (close_d < sqrt(3))
            push!(relevant, (b, l, a))
        end
    end
    for r in relevant
        println(r)
    end

    by_l1 = []
    for l1 = 0:9
        mn = 10000
        mx = 0
        for d in ds
            (l,b,a), cl, fr = d
            l1_dist = abs(l) + abs(b) + abs(a)
            if l1_dist == l1
                mn = min(mn, cl)
                mx = max(mx, fr)
            end
        end
        push!(by_l1, (l1, mn, mx))
    end
    display(by_l1)
end

function min_max_dists4d()
    ds = []
    relevant = []
    for l=-3:3, b=-3:3, a=-3:3, w=-3:3
        r = l+1
        close_h, far_h = abs(l) < abs(r) ? (l, r) : (r, l)
        t = b+1
        close_v, far_v = abs(b) < abs(t) ? (b, t) : (t, b)
        o = a+1
        close_q, far_q = abs(a) < abs(o) ? (a, o) : (o, a)
        w2 = w+1
        close_w, far_w = abs(w) < abs(w2) ? (w, w2) : (w2, w)
        close_d = sqrt(close_h^2 + close_v^2 + close_q^2 + close_w^2)
        far_d = sqrt(far_h^2 + far_v^2 + far_q^2 + far_w^2)
        push!(ds, ((l, b, a, w), close_d, far_d))
        if (close_d < sqrt(4))
            push!(relevant, (b, l, a, w))
        end
    end
    for r in relevant
        println(r)
    end

    by_l1 = []
    for l1 = 0:9
        mn = 10000
        mx = 0
        for d in ds
            (l,b,a, w), cl, fr = d
            l1_dist = abs(l) + abs(b) + abs(a) + abs(w)
            if l1_dist == l1 
                mn = min(mn, cl)
                mx = max(mx, fr)
            end
        end
        push!(by_l1, (l1, mn, mx))
    end
    by_l1
end



using LinearAlgebra: norm
function max_dists1d()
    ps = [-3, -2, -1, 1, 2, 3]
    max_dists = zeros(5)
    for x=0:0.001:1
        dists = [abs(x - p) for p in ps]
        sort!(dists)
        for i = 1:5
            max_dists[i] = max(max_dists[i], dists[i])
        end

    end
    return max_dists
end

function max_dists2d()
    ps1 = [-3, -2, -1, 1, 2, 3]
    ps = [(p1, p2) for p1 in ps1 for p2 in ps1]
    max_dists = zeros(8)
    for x=0:0.01:1, y=0:0.01:1
        dists = [norm((x, y) .- p) for p in ps]
        sort!(dists)
        for i = 1:8
            max_dists[i] = max(max_dists[i], dists[i])
        end

    end
    return max_dists
end

function max_dists3d()
    ps1 = [-3, -2, -1, 1, 2, 3]
    ps = [(p1, p2, p3) for p1 in ps1 for p2 in ps1 for p3 in ps1]
    max_dists = zeros(8)
    for x=0:0.01:1, y=0:0.01:1, z=0:0.01:1
        dists = [norm((x, y, z) .- p) for p in ps]
        sort!(dists)
        for i = 1:8
            max_dists[i] = max(max_dists[i], dists[i])
        end

    end
    return max_dists
end

function max_dists4d()
    ps1 = [ -1, 1, 2]
    ps = [(p1, p2, p3, p4) for p1 in ps1 for p2 in ps1 for p3 in ps1 for p4 in ps1]
    max_dists::Vector{Float64} = zeros(8)
    dists::Vector{Float64} = zeros(length(ps))
    d = 0.01
    for x=0:d:1
        println(x)
        for y=0:d:1, z=0:d:1, w=0:d:1
            for i=eachindex(dists)
                dists[i] = norm((x, y, z, w) .- ps[i])
            end
            sort!(dists)
            for i = 1:8
                max_dists[i] = max(max_dists[i], dists[i])
            end
        end

    end
    return max_dists
end