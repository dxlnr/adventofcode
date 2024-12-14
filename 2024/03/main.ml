let file = "input"

let search s r = 
    let rec searchh s r idx res =
        match idx < String.length s with
            | false -> res
            | true -> begin
                try
                    let idx = Str.search_forward r s idx in
                    let matched = Str.matched_string s in
                    searchh s r (idx + String.length matched) (res ^ matched)
                with
                 | Not_found -> res 
            end
    in searchh s r 0 ""

let () =
    let s = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))" in

    (* let sl = Str.split (Str.regexp "[mul\(\d\d\)]+") s in *)
    (* let r = Str.regexp "mul\(\d,\d\)" in *)
    (* let r = Str.regexp "[^mul(0-9,0-9)]+" in *)
    (* let sl = Str.split r s in *)
    (* let r = Str.regexp "[^(?=mul(0-9,0-9))]+" in *)
    (* let r = Str.regexp "^/(.*?)mul(0-9,0-9)/" in *)
    (* let r = Str.regexp "[^mul(]+" in *)
    (* let sl = Str.split r s in *)

    let r = Str.regexp "mul([0-9]+,[0-9]+)" in 
    let sl = search s r in

    (* try *)
    (*     let _ = Str.search_forward r s 2 in *)
    (*     let matched = Str.matched_string s in *)
    (*     Printf.printf "Matched substring: '%s'\n" matched *)
    (* with *)
    (*     | Not_found -> Printf.printf "No match found.\n"; *)

    (* let sl = Str.split_delim r s in *)
 
    print_endline s; 
    print_endline sl; 
    (* print_endline (string_of_int idx) *)
    (* List.iter (fun x -> print_endline x) sl *)
