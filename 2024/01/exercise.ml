let rec last x = match x with
    | [] -> None
    | [x] -> Some x
    | _ :: tail -> last tail

let 

let () = 
    let res = last ["a" ; "b" ; "c" ; "d"] in 
        Option.iter print_endline res;;
    let res = last [] in 
        Option.iter print_endline res;;
