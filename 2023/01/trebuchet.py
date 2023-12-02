"""Trebuchet."""
import re


DIGITS = {
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9",
    "zero": "0",
}

if __name__ == "__main__":
    # Part ONE
    res = []
    with open("input1", "r") as f:
        for line in f.read().split("\n"):
            digits = []
            for char in line:
                if char.isdigit():
                    digits.append(char)

            if len(digits) > 0:
                res.append(int(str(digits[0]) + str(digits[-1])))

    print("(1) Calibration sum:", sum(res))

    # Part TWO
    res = []
    with open("input2", "r") as f:
        for idx, line in enumerate(f.read().split("\n")):
            rp = re.compile(r"(?=(one|two|three|four|five|six|seven|eight|nine))")
            line = rp.sub(lambda x: DIGITS.get(x.group(1), ""), line)

            digits = []
            for w in re.split("(\d+)", line):
                if w.isdigit():
                    for d in w:
                        digits.append(d)

            if len(digits) > 0:
                res.append(int(str(digits[0]) + str(digits[-1])))

    print("(2) Calibration sum:", sum(res))
