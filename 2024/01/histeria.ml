let file = "input"

let convert_to_pair lst =
  match lst with
  | [ x; y ] -> (x, y)
  | _ -> failwith "Converting failed: List must have exactly 2 elements"

let rec suml lst =
  match lst with
  | [] -> 0
  | [ x ] -> x
  | head :: second :: tail -> suml ((head + second) :: tail)

let rec countl lst n r =
  match lst with
  | [] -> r
  | x :: tail -> if x = n then countl tail n (r + 1) else countl tail n r

let read fn =
  (* open_in: string -> in_channel *)
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

let splitlines content =
  let lines =
    List.map
      (fun x ->
        convert_to_pair
          (List.map int_of_string (Str.split (Str.regexp "[ \t]+") x)))
      content
  in
  let a, b = List.split lines in
  (a, b)

let () =
  let content = read file in
  let a, b = splitlines content in

  let a = Quicksort.quicksort a 0 (List.length a - 1) in
  let b = Quicksort.quicksort b 0 (List.length b - 1) in

  let res = suml (List.map (fun (x, y) -> abs (x - y)) (List.combine a b)) in

  print_endline (string_of_int res)

let () =
  let content = read file in
  let a, b = splitlines content in

  let res = suml (List.map (fun x -> x * countl b x 0) a) in

  print_endline (string_of_int res)
