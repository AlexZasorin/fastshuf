using Random

function main()
    # Check if we received any arguments
    if isempty(ARGS)
        # If we did not, default to 100 elements
        n = 100
    else
        # If we did, use the argument we were given
        n = parse(Int64, ARGS[1])
    end

    # Instantiate our reservoir and fill it with values from stdin
    R = Array{String, 1}()
    for elem in zip(1:n, eachline())
        push!(R, elem[2])
    end

    # Shuffle our initial sample in case there is no more input from stdin
    R = shuffle(R)

    # for (i, line) in enumerate(eachline())
    #     if i >= 3*n
    #         break
    #     end
    #
    #     rand_int = rand(1:n+i)
    #
    #     if rand_int <= n
    #         R[rand_int] = line
    #     end
    # end

    W = exp(log(rand(Float64))/n)

    counter = 0
    while !eof(stdin)
        line = readline()

        if counter > 0
            counter = counter - 1
        else
            R[rand(1:n)] = line
            W = W * exp(log(rand(Float64))/n)

            counter = floor(log(rand(Float64))/log(1-W)) + 1
            #println(counter)
        end
    end

    for elem in R
        println(elem)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    #start_time = time()
    main()
    #end_time = time()
    #println(end_time-start_time)
end
