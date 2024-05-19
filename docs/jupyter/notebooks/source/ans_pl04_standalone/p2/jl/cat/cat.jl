open(ARGS[1]) do f
    content = read(f, String)
    print(content)
end
