include("readxml.jl")

function main()
    filename = ARGS[1]
    doc = parse(filename)
    d = height(LightXML.root(doc))
    println(d)
end

main()
