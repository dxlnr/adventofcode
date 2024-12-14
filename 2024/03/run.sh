ocamlfind ocamlopt -package str -linkpkg main.ml -o main 

./main
rm *.cmx *.cmi *.o main
