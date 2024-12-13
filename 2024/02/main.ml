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

let rec check_w_tolerate f lst lvl system=
  match lst with
  | h :: s :: tail -> check_w_tolerate (check (List.append [ h ] tail) lvl system)

let rec check_w_tolerate f lst lvl system =
  match lst with
  | [] -> false (* Base case: no more elements to check *)
  | h :: tail ->
      if f (List.append tail []) lvl system then
        true (* If `f` succeeds with the current element excluded, return true *)
      else
        check_w_tolerate f (tail @ [h]) lvl system


  (* | [] -> false *)
  (* | [ x ] -> system *)
  (* | h :: s :: tail -> *)
  (*     let diff = int_of_string h - int_of_string s in *)
  (*     if abs diff < 1 || abs diff > 3 then false *)
  (*     else *)
  (*       let nlvl = match_level diff in *)
  (*       if lvl == Neither || nlvl == lvl then *)
  (*         check (List.append [ s ] tail) nlvl true *)
  (*       else false *)

(* let rec check_w_tolerate lst lvl system errc = *)
(*   match lst with *)
(*   | [] -> false *)
(*   | [ x ] -> system *)
(*   | h :: s :: tail -> *)
(*       let diff = int_of_string h - int_of_string s in *)
(*       if abs diff < 1 || abs diff > 3 then *)
(*         if errc == 0 then *)
(*           check_w_tolerate (List.append [ h ] tail) lvl false (errc + 1) *)
(*         else false *)
(*       else *)
(*         let nlvl = match_level diff in *)
(*         if lvl == Neither || nlvl == lvl then *)
(*           check_w_tolerate (List.append [ s ] tail) lvl true errc *)
(*         else if errc == 0 then *)
(*           check_w_tolerate (List.append [ h ] tail) lvl false (errc + 1) *)
(*         else false *)

let rec countl lst c =
  match lst with
  | [] -> c
  | x :: tail -> if x then countl tail (c + 1) else countl tail c

let () =
  let content = read file in

  let lst = List.map (fun s -> Str.split (Str.regexp "[ \\d]+") s) content in

  let r1 = countl (List.map (fun x -> check x Neither false) lst) 0 in

  (* let res = countl (List.map (fun x -> check x Neither false) lst) 0 in *)
  (* let lst = List.map (fun x -> check_w_tolerate x Neither false 0) lst in *)
  let r2 = countl (List.map (fun x -> check_w_tolerate check x Neither false) lst) 0 in
  (* let r2 = countl (List.map (fun x -> begin *) 
  (*   let safe = check x Neither false in end ) lst) *)
        (* check x Neither false) lst) 0 in *)

  (* List.iteri (fun idx, x -> print_endline String.concat " : "  (string_of_bool x)) lst *)
        (* List.iteri (fun idx x -> *) 
  (* print_endline (String.concat " : " [string_of_int (idx +1); string_of_bool x]) *)
(* ) lst *)

    print_endline (string_of_int r1);
    print_endline (string_of_int r2);
