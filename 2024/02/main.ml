let file = "input"

type level = Inc | Dec | Neither

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

let match_level diff =
  match diff with x when x < 0 -> Dec | 0 -> Neither | _ -> Inc

let rec check lst lvl system =
  match lst with
  | [] -> false
  | [ x ] -> system
  | h :: s :: tail ->
      let diff = int_of_string h - int_of_string s in
      if abs diff < 1 || abs diff > 3 then false
      else
        let nlvl = match_level diff in
        if lvl == Neither || nlvl == lvl then
          check (List.append [ s ] tail) nlvl true
        else false

let rec countl lst c =
  match lst with
  | [] -> c
  | x :: tail -> if x then countl tail (c + 1) else countl tail c

let () =
  let content = read file in

  let lst = List.map (fun s -> Str.split (Str.regexp "[ \\d]+") s) content in
  let res = countl (List.map (fun x -> check x Neither false) lst) 0 in

  print_endline (string_of_int res)
