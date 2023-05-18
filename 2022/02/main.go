package main

import (
    "fmt"
    "log"
    "os"
)

func main() {
    d, err := os.ReadFile("puzzle")
    if err != nil {
        log.Fatalf("unable to read file: %v", err)
    }
    
    var result int = 0
    var counter uint8 = 0
    var elf uint8 = 0
    var you uint8 = 0
    for _, c := range d {
        if c == 32  {
            counter = counter + 1
        } else if c == 10 {
            // Elf shows Rock
            if (elf == 65 && you == 88) {
                result = result + 1 + 3
            }
            if (elf == 65 && you == 89) {
                result = result + 2 + 6 
            }
            if (elf == 65 && you == 90) {
                result = result + 3 + 0
            }
            // Elf shows Paper 
            if (elf == 66 && you == 88) {
                result = result + 1 + 0
            }
            if (elf == 66 && you == 89) {
                result = result + 2 + 3
            }
            if (elf == 66 && you == 90) {
                result = result + 3 + 6
            }
            // Elf shows Scissors 
            if (elf == 67 && you == 88) {
                result = result + 1 + 6
            }
            if (elf == 67 && you == 89) {
                result = result + 2 + 0
            }
            if (elf == 67 && you == 90) {
                result = result + 3 + 3
            }
        } else {
            if counter == 0 {
                elf = c
            } else {
                you = c 
                counter = 0
            }
        }
    }
    fmt.Println("Total score :", result)
}
