def quicksort(arr: list[int], start: int, end: int) -> list[int]:
    def partition(arr: list[int], start: int, end: int):
        i = -1
        for idx, ele in enumerate(arr):
            if ele < arr[end]:
                i += 1
                arr[idx] = arr[i]
                arr[i] = ele

            if idx == end:
                i += 1
                arr[idx] = arr[i]
                arr[i] = ele

        return arr, i

    if start < end:
        arr, pivot = partition(arr, start, end)
        quicksort(arr, start, pivot - 1)
        quicksort(arr, pivot + 1, end)
    return arr


if __name__ == '__main__':
    # test = [3,4,2,1,3,3]
    test = [8,2,4,7,1,3,9,6,5]
    print(quicksort(test, 0, len(test) - 1))
