
let points::Matrix{Float64} = zeros(16, NR_CACHES),
    index::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES)
    nr_points::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES)

    function get_points!(idx, pos, ti)
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

    function load(ti)
        @view points[1:nr_points[ti].value, ti]
    end

    function store!(l, ti)
        i = 1
        for f=-2:2
            i = get_points!(i, l+f, ti)
        end

        len = i-1
        nr_points[ti] = Padding(len, nr_points[ti].padding)
        index[ti] = Padding(l, index[ti].padding)

        @view points[1:len, ti]
    end

    store!(0, 1)


    global function voronoi_points(x; cache_index=1)
        ti = mod(cache_index-1, NR_CACHES) + 1
        l, _, _ = bounds(x)
        return index[ti].value == l ? load(ti) : store!(l, ti)
    end

end


let points::Matrix{NTuple{2, Float64}} = zeros(NTuple{2, Float64}, (64, NR_CACHES)),
    index::Vector{pad(Tuple{Int, Int})} = zeros(pad(Tuple{Int, Int}), NR_CACHES)
    nr_points::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES)

    function get_points!(idx, p1, p2, ti)
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

    function load(ti)
        @view points[1:nr_points[ti].value, ti]
    end

    function store!(l, b, ti)
        i = 1
        for x=-2:2, y=-2:2
            if (abs(x) + abs(y) <= 3)
                i = get_points!(i, l+x, b+y, ti)
            end
        end

        len = i-1
        nr_points[ti] = Padding(len, nr_points[ti].padding)
        index[ti] = Padding((l, b), index[ti].padding)

        @view points[1:len, ti]
    end

    store!(0, 0, 1)


    global function voronoi_points(x, y; cache_index=1)
        ti = mod(cache_index-1, NR_CACHES) + 1
        l, _, _ = bounds(x)
        b, _, _ = bounds(y)

        return index[ti].value == (l, b) ? load(ti) : store!(l, b, ti)
    end

end



let points::Matrix{NTuple{3, Float64}} = zeros(NTuple{3, Float64}, (320, NR_CACHES)),
    index::Vector{pad(Tuple{Int, Int, Int})} = zeros(pad(Tuple{Int, Int, Int}), NR_CACHES)
    nr_points::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES)

    function get_points!(idx, p1, p2, p3, ti)
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

    function load(ti)
        @view points[1:nr_points[ti].value, ti]
    end

    function store!(l, b, a, ti)
        i = 1
        for x=-2:2, y=-2:2, z=-2:2
            if (abs(x) + abs(y) + abs(z) <= 5)
                i = get_points!(i, l+x, b+y, a+z, ti)
            end
        end

        len = i-1
        nr_points[ti] = Padding(len, nr_points[ti].padding)
        index[ti] = Padding((l, b, a), index[ti].padding)

        @view points[1:len, ti]
    end

    store!(0, 0, 0, 1)

    global function voronoi_points(x, y, z; cache_index=1)
        ti = mod(cache_index-1, NR_CACHES) + 1
        l, _, _ = bounds(x)
        b, _, _ = bounds(y)
        a, _, _ = bounds(z)

        return index[ti].value == (l, b, a) ? load(ti) : store!(l, b, a, ti)
    end

end




let points::Matrix{NTuple{4, Float64}} = zeros(NTuple{4, Float64}, (1600, NR_CACHES)),
    index::Vector{pad(Tuple{Int, Int, Int, Int})} = zeros(pad(Tuple{Int, Int, Int, Int}), NR_CACHES)
    nr_points::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES)

    function get_points!(idx, p1, p2, p3, p4, ti)
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

    function load(ti)
        @view points[1:nr_points[ti].value, ti]
    end

    function store!(l, b, a, v, ti)
        i = 1
        
        for x=-2:2, y=-2:2, z=-2:2, w=-2:2
            if (abs(x) + abs(y) + abs(z) + abs(w) <= 7)
                i = get_points!(i, l+x, b+y, a+z, v+w, ti)
            end
        end

        len = i-1
        nr_points[ti] = Padding(len, nr_points[ti].padding)
        index[ti] = Padding((l, b, a, v), index[ti].padding)

        @view points[1:len, ti]
    end

    store!(0, 0, 0, 0, 1)


    global function voronoi_points(x, y, z, w; cache_index=1)
        ti = mod(cache_index-1, NR_CACHES) + 1
        l, _, _ = bounds(x)
        b, _, _ = bounds(y)
        a, _, _ = bounds(z)
        v, _, _  = bounds(w)

        return index[ti].value == (l, b, a, v) ? load(ti) : store!(l, b, a, v, ti)
    end

end

