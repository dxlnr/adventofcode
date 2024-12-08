let swap arr i j = 
    let a = List.nth arr i in
    let arr = List.mapi (fun idx x -> 
        if idx = i then (List.nth arr j) 
        else if idx = j then a 
        else x) arr in
    arr
;;
let partition arr st en = 
    let i = ref (st - 1) in
    let arr = ref arr in
    for idx = st to en do
        if List.nth !arr idx < List.nth !arr en then 
            begin 
                i := !i + 1; 
                arr := swap !arr !i idx;
            end;
    done;
    i := !i + 1; 
    arr := swap !arr !i en;
    (!arr, !i)
;;

let rec quicksort arr st en = 
    if st < en then
        let (arr, pivot) = partition arr st en in
        let arr = quicksort arr st (pivot - 1) in
        let arr = quicksort arr (pivot + 1) en in
        arr
    else
        arr
;;
(* let () = *) 
(*     let test = quicksort [8;2;4;7;1;3;9;6;5] 0 8 in *)
(*     print_endline (String.concat "," (List.map string_of_int test));; *)
(* ;; *)
