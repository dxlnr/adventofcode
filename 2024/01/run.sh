ocamlfind ocamlopt -package str -linkpkg quicksort.ml histeria.ml -o histeria

./histeria
rm *.cmx *.o histeria
