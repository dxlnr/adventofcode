import string

e = [
    "vJrwpWtwJgWrhcsFMMfFFhFp",
    "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
    "PmmdzqPrVvPwwTWBwg",
    "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
    "ttgJtRGJQctTZtZT",
    "CrZsJsPPZsGzwwsLwLmpwMDw",
]


def compute_prio(s: str, prio: list[str]) -> (str, int):
    s1 = slice(0, len(s) // 2)
    s2 = slice(len(s) // 2, len(s))
    c = list(set([i for i in list(s[s1]) if i in list(s[s2])]))[0]
    r = prio.index(c) + 1
    return c, r


def compute_prio_lists(s: list[str], prio: list[str]) -> (str, int):
    c = list(set([i for i in list(s[0]) if (i in list(s[1])) and (i in list(s[2]))]))[0]
    r = prio.index(c) + 1
    return c, r


def chunks(l: list, cs: int):
    for i in range(0, len(l), cs):
        yield l[i : i + cs]


if __name__ == "__main__":
    prio = list(string.ascii_lowercase) + list(string.ascii_uppercase)

    print("Examples:")
    for s in e:
        c, r = compute_prio(s, prio)
        print(f"  ('{c}', {r})")

    print("(1) Puzzle:")
    with open("puzzle", "r") as f:
        t = f.read().split("\n")

        sum1 = 0
        for s in t:
            if s:
                c, r = compute_prio(s, prio)
                sum1 = sum1 + r
        print(f"  sum: {sum1}")

    print("(2) Puzzle:")
    with open("puzzle", "r") as f:
        t = f.read().split("\n")
        tf = list(filter(None, t))

        sum2 = sum([compute_prio_lists(i, prio)[1] for i in list(chunks(tf, 3))])
        print(f"  sum: {sum2}")
