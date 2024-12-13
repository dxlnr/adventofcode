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

let check lst =
  let rec checkh l lvl system =
    match l with
    | [] -> false
    | [ x ] -> system
    | h :: s :: tail ->
        let diff = int_of_string h - int_of_string s in
        if abs diff < 1 || abs diff > 3 then false
        else
          let nlvl = match_level diff in
          if lvl == Neither || nlvl == lvl then
            checkh (List.append [ s ] tail) nlvl true
          else false
  in
  checkh lst Neither true

let rec split_at i lst =
  match (i, lst) with
  | _, [] -> ([], [])
  | 0, _ -> ([], lst)
  | _, x :: xs ->
      let left, right = split_at (i - 1) xs in
      (x :: left, right)

let popl lst = match lst with [] -> [] | _ :: xs -> xs

let check_w_tolerate lst =
  let rec check_w_tolerate_helper i lst =
    if i >= List.length lst then false
    else
      let left, right = split_at i lst in
      if check (left @ popl right) then true
      else check_w_tolerate_helper (i + 1) lst
  in
  check_w_tolerate_helper 0 lst

let countl lst =
  let rec countlh lst c =
    match lst with
    | [] -> c
    | x :: tail -> if x then countlh tail (c + 1) else countlh tail c
  in
  countlh lst 0

let () =
  let content = read file in

  let lst = List.map (fun s -> Str.split (Str.regexp "[ \\d]+") s) content in

  let r1 = countl (List.map (fun x -> check x) lst) in
  let r2 = countl (List.map (fun x -> check_w_tolerate x) lst) in

  print_endline (string_of_int r1);
  print_endline (string_of_int r2)
