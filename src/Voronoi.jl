# distance from border


voronoi_noise(coords...) = voronoi_noise(Float64.(coords)...)

function voronoi_noise(x)
    # l2...(pl2)...l..x.(pl)....r....(pr)....r+1...
    l::Int = floor(x)
    r = l+1
    l2 = l-1
    pl2 = rand30_from(l2 ⊻ SEED)
    pl = rand30_from(l ⊻ SEED)
    pr = rand30_from(r ⊻ SEED)
    dx = x - l
    dl2 = dx + 1-pl2
    dl = abs(pl - dx)
    dr = pr + 1-dx
    return min(dl2, dl, dr)
end


# 2D
let coords::Vector{Int} = Int[typemin(Int), typemin(Int)],
    points::Vector{Tuple{Float64, Float64}} = Vector{Tuple{Float64, Float64}}(undef, 25),
    nr_inner_points::Int = 0,
    got_outer::Bool = false

    function push_points(x::Int, y::Int, sx::Int, sy::Int)
        nr_points = (randn30_from(x+sx ⊻ SEED, y+sy ⊻ SEED) |> abs |> floor |> Int) + 1
        for i=1:nr_points
            px = more_rand30_from()
            py = more_rand30_from()
            push!(points, (sx+px, sy+py))
        end
    end

    # x and y are the coordinates of the top left corner of the center square

    # the 9 squares around the center, commonly, the closest point is in here
    function get_center_points(x::Int, y::Int)
        for i=-1:1, j=-1:1
            push_points(x, y, i, j)
        end
    end

    function get_outer_points(x::Int, y::Int)
        for i in -1:1, j in (-2, 2)
            push_points(x, y, i, j)
            push_points(x, y, j, i)
        end
    end

    dist(t1, t2) = begin d1 = t1[1]-t2[1]; d2 = t1[2]-t2[2]; sqrt(d1*d1 + d2*d2) end

    global function voronoi_noise(x::Float64, y::Float64)
        @inbounds begin
            ix::Int = floor(x)
            iy::Int = floor(y)
            px = x-ix
            py = y-iy
            if !(coords[1] == ix && coords[2] == iy)
                coords[1] = ix
                coords[2] = iy
                empty!(points)
                get_center_points(ix, iy)
                nr_inner_points = length(points)
                got_outer = false
            end

            min_dist = 2.0
            for i in 1:nr_inner_points
                d = dist(points[i], (px, py))
                if d < min_dist
                    min_dist = d
                end
            end

            if min_dist < 1
                return (1/1.4142135623730951)min_dist
            end

            if !got_outer
                get_outer_points(ix, iy)
                got_outer = true
            end

            for i in (nr_inner_points+1):length(points)
                d = dist(points[i], (px, py))
                if d < min_dist
                    min_dist = d
                end
            end

            return (1/1.4142135623730951)min_dist
        end
    end
end


# 3D
let coords::Vector{Int} = Int[typemin(Int), typemin(Int), typemin(Int)],
    points::Vector{Tuple{Float64, Float64, Float64}} = Vector{Tuple{Float64, Float64, Float64}}(undef, 125),
    nr_inner_points::Int = 0,
    got_outer::Bool = false

    function push_points(x, y, z, sx, sy, sz)
        nr_points = (randn30_from(x+sx ⊻ SEED, y+sy ⊻ SEED, z+sz ⊻ SEED) |> abs |> floor |> Int) + 1
        for i=1:nr_points
            px = more_rand30_from()
            py = more_rand30_from()
            pz = more_rand30_from()
            push!(points, (sx+px, sy+py, sz+pz))
        end
    end

    # x and y are the coordinates of the top left corner of the center square

    # the 9 squares around the center, commonly, the closest point is in here
    function get_center_points(x, y, z)
        for i=-1:1, j=-1:1, k=-1:1
            push_points(x, y, z, i, j, k)
        end
    end

    function get_outer_points(x, y, z)
        for i in -1:1, j in -1:1, k in (-2, 2)
            push_points(x, y, z, i, j, k)
            push_points(x, y, z, i, k, j)
            push_points(x, y, z, k, i, j)
        end
    end

    dist(t1, t2) = begin d1 = t1[1]-t2[1]; d2 = t1[2]-t2[2]; d3 = t1[3]-t2[3]; sqrt(d1*d1 + d2*d2 + d3*d3) end

    global function voronoi_noise(x::Float64, y::Float64, z::Float64)
        @inbounds begin
            ix::Int = floor(x)
            iy::Int = floor(y)
            iz::Int = floor(z)
            px = x-ix
            py = y-iy
            pz = z-iz
            if !(coords[1] == ix && coords[2] == iy && coords[3] == iz)
                coords[1] = ix
                coords[2] = iy
                coords[3] = iz
                empty!(points)
                get_center_points(ix, iy, iz)
                nr_inner_points = length(points)
                got_outer = false
            end

            min_dist = 2.0
            for i in 1:nr_inner_points
                d = dist(points[i], (px, py, pz))
                if d < min_dist
                    min_dist = d
                end
            end

            if min_dist < 1
                return (1/1.7320508075688772)min_dist
            end

            if !got_outer
                get_outer_points(ix, iy, iz)
                got_outer = true
            end

            for i in (nr_inner_points+1):length(points)
                d = dist(points[i], (px, py, pz))
                if d < min_dist
                    min_dist = d
                end
            end

            return (1/1.7320508075688772)min_dist
        end
    end
end



# 4D
let coords::Vector{Int} = Int[typemin(Int), typemin(Int), typemin(Int), typemin(Int)],
    points::Vector{Tuple{Float64, Float64, Float64, Float64}} = Vector{Tuple{Float64, Float64, Float64, Float64}}(undef, 300),
    nr_inner_points::Int = 0,
    got_outer::Bool = false

    function push_points(x, y, z, w, sx, sy, sz, sw)
        nr_points = (randn30_from(x+sx ⊻ SEED, y+sy ⊻ SEED, z+sz ⊻ SEED, w+sw ⊻ SEED) |> abs |> floor |> Int) + 1
        for i=1:nr_points
            px = more_rand30_from()
            py = more_rand30_from()
            pz = more_rand30_from()
            pw = more_rand30_from()
            push!(points, (sx+px, sy+py, sz+pz, sw+pw))
        end
    end

    # x and y are the coordinates of the top left corner of the center square

    # the 9 squares around the center, commonly, the closest point is in here
    function get_center_points(x, y, z, w)
        for i=-1:1, j=-1:1, k=-1:1, l=-1:1
            push_points(x, y, z, w, i, j, k, l)
        end
    end

    function get_outer_points(x, y, z, w)
        for i in -1:1, j in -1:1, l in -1:1, k in (-2, 2)
            push_points(x, y, z, w, i, j, l, k)
            push_points(x, y, z, w, i, j, k, l)
            push_points(x, y, z, w, i, k, j, l)
            push_points(x, y, z, w, k, i, j, l)
        end
    end

    dist(t1, t2) = begin d1 = t1[1]-t2[1]; d2 = t1[2]-t2[2]; d3 = t1[3]-t2[3]; d4 = t1[4]-t2[4]; sqrt(d1*d1 + d2*d2 + (d3*d3 + d4*d4)) end

    global function voronoi_noise(x::Float64, y::Float64, z::Float64, w::Float64)
        @inbounds begin
            ix::Int = floor(x)
            iy::Int = floor(y)
            iz::Int = floor(z)
            iw::Int = floor(w)
            px = x-ix
            py = y-iy
            pz = z-iz
            pw = w-iw
            if !(coords[1] == ix && coords[2] == iy && coords[3] == iz && coords[4] == iw)
                coords[1] = ix
                coords[2] = iy
                coords[3] = iz
                coords[4] = iw
                empty!(points)
                get_center_points(ix, iy, iz, iw)
                nr_inner_points = length(points)
                got_outer = false
            end

            min_dist = 3.0
            for i in 1:nr_inner_points
                d = dist(points[i], (px, py, pz, pw))
                if d < min_dist
                    min_dist = d
                end
            end

            if min_dist < 1
                return 0.5min_dist
            end

            if !got_outer
                get_outer_points(ix, iy, iz, iw)
                got_outer = true
            end

            for i in (nr_inner_points+1):length(points)
                d = dist(points[i], (px, py, pz, pw))
                if d < min_dist
                    min_dist = d
                end
            end

            return 0.5min_dist
        end
    end
end