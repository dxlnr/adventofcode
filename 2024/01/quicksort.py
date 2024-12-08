def quicksort(arr: list[int], start: int, end: int) -> list[int]:
    def partition(arr: list[int], start: int, end: int):
        def swap(arr,i,j):
            tmp = arr[i]
            arr[i] = arr[j]
            arr[j] = tmp
            return arr

        i = start - 1
        for j in range(start, end):
            if arr[j] <= arr[end]:
                i += 1
                swap(arr,i,j)
        i += 1
        swap(arr,i,end)

        return arr, i

    if start < end:
        arr, pivot = partition(arr, start, end)
        quicksort(arr, pivot + 1, end)
        quicksort(arr, start, pivot - 1)
    return arr


if __name__ == '__main__':
    t1 = [3,4,2,1,3,3]
    t2 = [8,2,4,7,1,3,9,6,5]
    print(f"{t1} -> {quicksort(t1, 0, len(t1) - 1)}")
    print(f"{t2} -> {quicksort(t2, 0, len(t2) - 1)}")
