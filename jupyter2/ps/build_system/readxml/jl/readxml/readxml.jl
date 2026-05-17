import LightXML

function parse(filename)
    doc = LightXML.parse_file(filename)
    return doc
end

function height(node)
    if LightXML.is_elementnode(node)
        max_height = 0
        for child in LightXML.child_nodes(node)
            d = height(child)
            if d > max_height
                max_height = d
            end
        end
        max_height + 1
    else
        return 0
    end
end

function main()
    filename = ARGS[1]
    doc = parse(filename)
    d = height(LightXML.root(doc))
    println(d)
end

main()
