let file = "input"

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

let multl l =
  let rec multlh lst res =
    match lst with [] -> res | h :: tail -> multlh tail (res * int_of_string h)
  in
  multlh l 1

let search s =
  let rec searchh s r idx res =
    match idx < String.length s with
    | false -> res
    | true -> (
        try
          let idx = Str.search_forward r s idx in
          let matched = Str.matched_string s in

          let nl = Str.split (Str.regexp "[^0-9]+") matched in
          let prod = multl nl in

          searchh s r (idx + String.length matched) (res + prod)
        with Not_found -> res)
  in
  searchh s (Str.regexp "mul([0-9]+,[0-9]+)") 0 0

let () =
  let sl =
    [
      "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";
    ]
  in

  let ex = List.fold_left ( + ) 0 (List.map (fun x -> search x) sl) in
  print_endline (string_of_int ex);

  let i1 = read file in
  let r1 = List.fold_left ( + ) 0 (List.map (fun x -> search x) i1) in
  print_endline (string_of_int r1)
