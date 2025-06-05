# COMPILE
clang -c -o main.o main.s
# as -arch arm64 main.s -o main.o
# LINK
clang -o main main.o
# ld -arch arm64 -o main main.o -lSystem -syslibroot $(xcrun --sdk macosx --show-sdk-path) -e _main
# RUN
./main
