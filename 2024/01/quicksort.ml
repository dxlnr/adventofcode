let swap arr i j = 
    let a = List.nth arr i in (*8*)
    let arr = List.mapi (fun idx x -> if idx = i then (List.nth arr j) else x) arr in
    let arr = List.mapi (fun idx x -> if idx = j then a else x) arr in
    arr
;;
let partition arr st en = 
    (* let i = -1 in *)
    (* List.iter arr *)
    arr
let quicksort arr st en = 
    if st < en then 
        let arr = partition arr st en in
        arr
    else
        arr
;;


let () = 
    let test = quicksort [8;2;4;7;1;3;9;6;5] 0 8 in
    print_endline (String.concat "," (List.map string_of_int test));;
;;
