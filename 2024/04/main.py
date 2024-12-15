import numpy as np

XMAS = ["XMAS", "SAMX"]
MAS = ["MAS", "SAM"]


def findxmas(arr: np.ndarray) -> int:
    rows, cols = arr.shape

    counter = 0
    for r in range(rows):
        for c in range(cols):
            # Horizontal check
            if c <= cols - 4:
                if arr[r, c] + arr[r, c + 1] + arr[r, c + 2] + arr[r, c + 3] in XMAS:
                    counter += 1
            # Vertical check
            if r <= rows - 4:
                if arr[r, c] + arr[r + 1, c] + arr[r + 2, c] + arr[r + 3, c] in XMAS:
                    counter += 1
            # Diagonal (top-left to bottom-right)
            if r <= rows - 4 and c <= cols - 4:
                if (
                    arr[r, c]
                    + arr[r + 1, c + 1]
                    + arr[r + 2, c + 2]
                    + arr[r + 3, c + 3]
                    in XMAS
                ):
                    counter += 1
            # Diagonal (bottom-left to top-right)
            if r >= 3 and c <= cols - 4:
                if (
                    arr[r, c]
                    + arr[r - 1, c + 1]
                    + arr[r - 2, c + 2]
                    + arr[r - 3, c + 3]
                    in XMAS
                ):
                    counter += 1
    return counter


def findmas(arr: np.ndarray) -> int:
    rows, cols = arr.shape
    counter = 0
    for r in range(rows):
        for c in range(cols):
            if c <= cols - 3 and r <= rows - 3:
                if (
                    arr[r + 1, c + 1] == "A"
                    and arr[r, c] + arr[r + 1, c + 1] + arr[r + 2, c + 2] in MAS
                    and arr[r + 2, c] + arr[r + 1, c + 1] + arr[r, c + 2] in MAS
                ):
                    counter += 1
    return counter


if __name__ == "__main__":
    with open("input", "r") as f:
        content = f.read().split("\n")[:-1]

    arr = np.array([[w for w in s] for s in content])
    print(findxmas(arr))
    print(findmas(arr))
