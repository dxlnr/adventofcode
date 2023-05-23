"""Day 6: Tuning Trouble"""

s1 = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"  # 7
s2 = "bvwbjplbgvbhsrlpgdmjqwftvncz"  # 5
s3 = "nppdvjthqldpwncqszvftbrmjlhg"  # 6
s4 = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"  # 10
s5 = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"  # 11


def find_marker(s: str, l: int = 4) -> dict[int, str]:
    """
    :param s: Input string which will be examined.
    :param l: Distinct character length that needs to be fullfilled.
    """
    r = ""
    rd = dict()
    for idx, c in enumerate(s):
        if not c in r:
            r += c
        else:
            i = r.index(c)
            r += c
            r = r[i + 1 :]
        if len(r) == l:
            rd[idx + 1] = r
            break
    return rd


if __name__ == "__main__":
    # Part one
    print("--- Part One ---")
    print("\t", find_marker(s1))
    print("\t", find_marker(s2))
    print("\t", find_marker(s3))
    print("\t", find_marker(s4))
    print("\t", find_marker(s5))

    with open("puzzle", "r") as f:
        t = f.read().replace('\n', '')
        print("\nanswer: ", find_marker(t),"\n")

    # Part two 
    print("--- Part Two ---")
    print("\t", find_marker(s1, 14))
    print("\t", find_marker(s2, 14))
    print("\t", find_marker(s3, 14))
    print("\t", find_marker(s4, 14))
    print("\t", find_marker(s5, 14))

    with open("puzzle", "r") as f:
        t = f.read().replace('\n', '')
        print("\nanswer: ", find_marker(t, 14),"\n")

