import re

game_config = {"red": 12, "green": 13, "blue": 14}

if __name__ == "__main__":
    res1, res2 = [], []
    with open("input", "r") as f:
        for line in f.read().splitlines():
            line = line.split(":")
            id, g = [int(s) for s in re.findall(r"\b\d+\b", line[0])][0], list(
                filter(lambda x: x != "", re.split(r"[,; ]", line[1]))
            )

            assert len(g) % 2 == 0, "ERROR: Parsing error."
            res1.append(id)
            for n, cube in zip(*[iter(g)] * 2):
                if int(n) > game_config[cube]:
                    res1.pop()
                    break

            assert len(g) % 2 == 0, "ERROR: Parsing error."
            m = [0, 0, 0]
            for n, cube in zip(*[iter(g)] * 2):
                if cube == "red" and int(n) > m[0]:
                    m[0] = int(n)
                elif cube == "green" and int(n) > m[1]:
                    m[1] = int(n)
                elif cube == "blue" and int(n) > m[2]:
                    m[2] = int(n)
                else:
                    pass
            res2.append(m[0] * m[1] * m[2])

    print("Puzzle 1", sum(res1))
    print("Puzzle 2", sum(res2))
