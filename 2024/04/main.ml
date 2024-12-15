let file = "example"

let read fn =
  let ic = open_in file in
  let lines = ref [] in
  try
    try
      while true do
        lines := input_line ic :: !lines
      done
    with End_of_file ->
      close_in ic;

      let content = List.rev !lines in
      content
  with e ->
    close_in_noerr ic;
    raise e

let () =
    let content = read file in
    List.iter (fun x -> print_endline x) content;
