let file = "test1"

let read fn = 
    let ic = open_in file in
    (* open_in: string -> in_channel *)
    let lines = ref [] in
    try
        try
            while true; do
                lines := input_line ic :: !lines 
            done;
        with End_of_file ->
            close_in ic;

        let content = List.rev !lines in
        content
    with e ->
        close_in_noerr ic;
        raise e

let convert_to_pair lst =
  match lst with
  | [x; y] -> (x, y)
  | _ -> failwith "Converting failed: List must have exactly 2 elements"

let splitlines content =
    let lines = List.map(fun x -> convert_to_pair (List.map int_of_string (Str.split (Str.regexp "[ \t]+") x))) content in
    let (a, b) = List.split lines in
    (a, b)

let () = 
    let content = read file in
    let (a, b) = splitlines content in

    let a = Quicksort.quicksort a 0 5 in
    let b = Quicksort.quicksort b 0 5 in
        
    print_endline (String.concat "," (List.map string_of_int a));
    print_endline (String.concat "," (List.map string_of_int b));
