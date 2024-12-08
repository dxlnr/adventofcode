ocamlfind ocamlc -package str -linkpkg quicksort.ml histeria.ml -o histeria
./histeria
rm *.cmi *.cmo histeria
