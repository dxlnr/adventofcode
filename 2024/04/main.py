import numpy as np

XMAS = ["XMAS", "SAMX"]

if __name__ == "__main__":
    with open("input", "r") as f:
        content = f.read().split("\n")[:-1]

    a2d = np.array([[w for w in s] for s in content])
    rows, cols = a2d.shape

    counter = 0
    for r in range(rows):
        for c in range(cols):
            # Horizontal check
            if c <= cols - 4:
                if a2d[r, c] + a2d[r, c + 1] + a2d[r, c + 2] + a2d[r, c + 3] in XMAS:
                    counter += 1
            # Vertical check
            if r <= rows - 4:
                if a2d[r, c] + a2d[r + 1, c] + a2d[r + 2, c] + a2d[r + 3, c] in XMAS:
                    counter += 1
            # Diagonal (top-left to bottom-right)
            if r <= rows - 4 and c <= cols - 4:
                if (
                    a2d[r, c]
                    + a2d[r + 1, c + 1]
                    + a2d[r + 2, c + 2]
                    + a2d[r + 3, c + 3]
                    in XMAS
                ):
                    counter += 1
            # Diagonal (bottom-left to top-right)
            if r >= 3 and c <= cols - 4:
                if (
                    a2d[r, c]
                    + a2d[r - 1, c + 1]
                    + a2d[r - 2, c + 2]
                    + a2d[r - 3, c + 3]
                    in XMAS
                ):
                    counter += 1
    print(counter)
