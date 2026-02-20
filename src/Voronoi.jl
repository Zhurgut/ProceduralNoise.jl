
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
        l, _, _ = bounds(x)
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
        l, _, _ = bounds(x)
        b, _, _ = bounds(y)
        ti = Threads.threadid()

        return index[ti].value == (l, b) ? load() : store!(l, b)
    end

end



let points::Matrix{NTuple{3, Float64}} = zeros(NTuple{3, Float64}, (320, Threads.nthreads())),
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
        l, _, _ = bounds(x)
        b, _, _ = bounds(y)
        a, _, _ = bounds(z)
        ti = Threads.threadid()

        return index[ti].value == (l, b, a) ? load() : store!(l, b, a)
    end

end




let points::Matrix{NTuple{4, Float64}} = zeros(NTuple{4, Float64}, (1600, Threads.nthreads())),
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
        l, _, _ = bounds(x)
        b, _, _ = bounds(y)
        a, _, _ = bounds(z)
        v, _, _  = bounds(w)
        ti = Threads.threadid()

        return index[ti].value == (l, b, a, v) ? load() : store!(l, b, a, v)
    end

end

