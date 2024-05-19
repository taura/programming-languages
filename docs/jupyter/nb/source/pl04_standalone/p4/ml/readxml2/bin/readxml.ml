open Markup
;;

type dom = Text of string | Element of name * dom list
;;

let readxml filename = 
  let (ch, _) = Markup.file filename in
  parse_xml ch
  |> signals
  |> tree
       ~text: (fun ss -> Text (String.concat "" ss))
       ~element: (fun name _ children -> (Element(name, children)))

;;

