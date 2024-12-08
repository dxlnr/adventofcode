let file = "test1"

let () = 
    let ic = open_in file in
    (* open_in: string -> in_channel *)
    try
        for variable = start_value to input_line icdo

        let line = input_line ic in
        (* read line, discard \n *)
            print_endline line;
        (* write the result to stdout *)
        (* write on the underlying device now *)
        done

        flush stdout;
        close_in ic
        (* close the input channel *)
    with e ->
        (* some unexpected exception occurs *)
        close_in_noerr ic;
        (* emergency closing *)
        raise e
