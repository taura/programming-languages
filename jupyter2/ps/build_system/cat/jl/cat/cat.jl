## jl/cat/cat.jl
function main()
    # get command line arg
    filename = ARGS[1]
    # read file
    file = open(filename, "r")
    # get the whole contents of the file
    contents = read(file, String)
    # print the contents, without adding a newline at the end
    print(contents)
    # close the file
    close(file)
end

main()
