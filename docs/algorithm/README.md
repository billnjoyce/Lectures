# Itroduction
----------------------- 

컴퓨터 공학에서의 다양한 알고리즘의 정의 및 종류에 대해서 살펴봅니다.


주요 강좌 및 개념
-----------------------  

* [Recursive](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Recursive.pdf)

> Recursive는 우리말로 풀이하면 ‘재귀’ 라는 단어로서 컴퓨터 과학(CS)에서의 재귀는 자신을 정의할 때 자기 자신을 재참고 하는 방법을 뜻합니다.

```swift
public func factorial(n: Int) -> Int {
    if n == 0 {
        return 1
    }
    
    return n * factorial(n: n-1)
}

public func fibonacci(n: Int) -> Int {
    if n == 0 || n == 1 {
        return n
    } else {
        return fibonacci(n: n-1) + fibonacci(n: n-2)
    }
}

public func power(x:Double, n:Int) -> Double {
    if n == 0 {
        return 1
    }
    else if n > 0
    {
        if n % 2 == 0
        {
            return power(x: x, n: n / 2) * power(x: x, n: n / 2)
        } else {
            return x * power(x: x, n: n-1)
        }
    } else {
        return 1 / power(x: x, n: -n)
    }
}

public func gcd(a:Int, b:Int) -> Int {
    if a == b { return a }
    else if a > b { //
        if a % b == 0 { return b }
        else { return gcd(a: b, b: a % b) }
    } else{
        if b % a == 0{ return a }
        else { return gcd(a: a, b: b % a) }
    }
}
```

* [Selection Sort](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Selection%20Sort.pdf)

> Selection Sort(선택 정렬)은 배열의 전체 원소들을 중에서 기준 위치에 맞는 원소를 선택하여 자리를 교환하는 방식으로 정렬하는 정렬 알고리즘입니다.

```swift
func selectionSort<T : Comparable>(_ array: [T]) -> [T] {
    var arr = array
    
    for stand in 0 ..< (arr.count - 1) {
        var lowest = stand
        for index in (stand + 1) ..< arr.count {
            if arr[lowest] > arr[index] {
                lowest = index
            }
            let tmp = arr[lowest]
            arr[lowest] = arr[stand]
            arr[stand] = tmp
        }
    }
    
    return arr
}
```

* [Insertion Sort](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Insertion%20Sort.pdf)

> Insertion Sort(삽입 정렬)은 정렬 알고리즘으로서 특정 배열에서 처음 요소 왼쪽부터 오른쪽으로 순차적으로 비교해가면서 정렬해 나가는 알고리즘입니다.

```swift
func insertionSort<T: Comparable>(_ array: [T]) -> [T] {
    var sort = array
    
    for i in 1..<array.count {
        var j = i
        let temp = sort[j]
        while j > 0 && temp < sort[j - 1] {
          sort[j] = sort[j - 1]
          j -= 1
        }
        
        sort[j] = temp
    }
    return sort
}

// isAscending: (T, T) -> Bool : 
// 두 개의 T 객체를 받아서, 첫 번째 객체가 두 번째 것보다 
// 앞에 위치하면 true를 반환하고, 그 반대라면 false를 반환하는 함수
func insertionSort<T: Comparable>(_ array: [T], 
                                  _ isAscending: (T, T) -> Bool) -> [T] {
    var sort = array
    
    for i in 1..<array.count {
        var j = i
        let temp = sort[j]
        while j > 0 && temp < sort[j - 1] && isAscending(sort[j - 1], temp) {
          sort[j] = sort[j - 1]
          j -= 1
        }
        
        sort[j] = temp
    }
    return sort
}
```

* [Bubble Sort](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Bubble%20Sort.pdf)

> Bubble Sort는 배열을 순차적으로 두 인접한 원소를 검사하여 정렬하는 정렬 알고리즘입니다.

```swift
func bubbleSort<T: Comparable>(_ array: [T]) -> [T] {
    var sort = array
    
    for _ in 0..<sort.count {
        for j in 1..<sort.count {
            if sort[j-1] > sort[j] {
                sort.swapAt(j-1, j)
            }
        }
    }
    
    return sort
}

func bubbleSort<T: Comparable>(_ array: [T], _ isAscending: (T, T) -> Bool) -> [T] {
    var sort = array
    
    for _ in 0..<sort.count {
        for j in 1..<sort.count {
            if isAscending(sort[j-1], sort[j]) {
                sort.swapAt(j-1, j)
            }
        }
    }
    
    return sort
}
```

* [Merge Sort](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Merge%20Sort.pdf)

> Merge Sort(병합 정렬)는 삽입이나 선택 정렬보다 빠른 정렬 알고리즘으로서 분할 및 정복 과정을 통하여 동작하는 알고리즘입니다.

```swift
public func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    if array.count < 2 {
        print("split - array : \(array)")
        return array
    }
    
    let center = array.count / 2
    
    print("split - array : \(array)")
    
    return merge(leftHalf: mergeSort([T](array[0..<center])),
                 rightHalf:mergeSort([T](array[center..<array.count])))
}

private func merge<T: Comparable>(leftHalf: [T], rightHalf: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    var tempList = [T]()
    
    //tempList.reserveCapacity(leftHalf.count + rightHalf.count)
    
    while leftIndex < leftHalf.count && rightIndex < rightHalf.count {
        if leftHalf[leftIndex] < rightHalf[rightIndex] {
            tempList.append(leftHalf[leftIndex])
            leftIndex = leftIndex + 1
            
        } else if leftHalf[leftIndex] > rightHalf[rightIndex] {
            tempList.append(rightHalf[rightIndex])
            rightIndex = rightIndex + 1
        }
        else {
            tempList.append(leftHalf[leftIndex])
            tempList.append(rightHalf[rightIndex])
            leftIndex = leftIndex + 1
            rightIndex = rightIndex + 1
        }
    }
    
    tempList += leftHalf[leftIndex..<leftHalf.count]
    tempList += rightHalf[rightIndex..<rightHalf.count]
    
    print("merge - array : \(tempList)")
    
    return tempList
}
```

* [Quick Sort](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Quick%20Sort.pdf)

> Quick Sort(퀵 정렬)는 대표적인 분할, 정복 정렬 알고리즘으로서 최악의 경우는 O(n^2)이지만 평균적으로는 O(nlogn)으로서 병합 정렬보다 보편적으로 빠른 속도를 가진 알고리즘입니다.

```swift
func quickSort<T: Comparable>(_ array: [T]) -> [T] {
    if array.count < 2 {
        print("last array : \(array)")
        return array
    }
    else { print("array : \(array)") }

    let pivot = array.first!
    print("pivot : \(pivot)")
    
    let smaller = array.filter { $0 < pivot }
    let larger = array.filter { $0 > pivot }
    
    print("smaller : \(smaller)")
    print("larger : \(larger)")

    let result = quickSort(smaller) + [pivot] + quickSort(larger)
    
    print("smaller + pivot + larger : \(result)")
    
    return result
}
```

* [Heap Sort](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Heap%20Sort.pdf)

> Heap Sort(힙 정렬)는 힙 트리를 활용하여 데이터를 정렬을 하는 정렬 알고리즘입니다.

```swift
func heapify<T : Comparable>(_ array: inout [T], _ i: Int, _ size: Int) {
    var largest = i
    let left = i * 2 + 1
    let right = i * 2 + 2
    
    if left < size && array[largest] < array[left] {
        largest = left
    }
    
    if right < size && array[largest] < array[right] {
        largest = right
    }
    
    if largest != i {
        swap(&array, largest, i)
        heapify(&array, largest, size)
    }
}

func swap<T : Comparable>(_ array: inout [T] , _ i: Int, _ j: Int) {
    let temp = array[i]
    array[i] = array[j]
    array[j] = temp
}

func buildHeap<T : Comparable>(_ array: inout [T]) {
    var i = array.count/2
    
    while i >= 0 {
        heapify(&array, i, array.count)
        i -= 1
    }
}

func heapSort<T : Comparable>(_ array: inout [T]) -> [T] {
    buildHeap(&array)
    
    var size = array.count
    var i = size - 1
    
    while i >= 1 {
        swap(&array, i, 0)
        print("\(array)")
            
        i -= 1
        size -= 1
        
        heapify(&array, 0, size)
        
        print("\(array)")
    }
    
    return array
}
```

* [Shell Sort](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Shell%20Sort.pdf)

> Shell Sort(쉘 정렬)는 ‘Donald L. Shell’이라는 사람이 제안한 정렬 알고리즘으로서 삽입 정렬을 보완한 알고리즘입니다.

```swift
public func shellSort<T : Comparable>(_ array: inout [T]) -> [T] {
    var sublistCount = array.count / 2
    
    while sublistCount > 0 {
        for pos in 0..<sublistCount {
            insertionSort(&array, start: pos, gap: sublistCount)
        }
        
        sublistCount = sublistCount / 2
    }
    
    return array
}

private func insertionSort<T : Comparable>(_ array: inout [T], start: Int, gap: Int) {
    // start 부터 to 위치까지 gap 만큼의 차이로 루프를 돈다.
    for i in stride(from: (start + gap), to: array.count, by: gap) {
        let currentValue = array[i]
        var pos = i
        
        while pos >= gap && array[pos - gap] > currentValue {
            array[pos] = array[pos - gap]
            pos -= gap
        }
            
        array[pos] = currentValue
    }
}
```

* [Binary Search](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Binary%20Search.pdf)

> Binary Search이란 이진 탐색으로서 단순한 선형 탐색(Linear Search)와 달리 절반씩 배열을 줄여나가면서 찾는 탐색 알고리즘입니다.

```swift
func binarySearch<T: Comparable>(array: [T], item: T) -> Int {
    var low = 0
    var high = array.count - 1
    
    while low <= high {
        let mid = (low + high) / 2
        let guess = array[mid]
        if guess == item {
            return mid
        } else if guess > item {
            high = mid - 1
        } else {
            low = mid + 1
        }
    }
    
    return -1
}

func binarySearch(first: Int, last: Int, target: Int, array: [Int]) -> Int {
    if first > last {
        return -1
    }
    
    let middle = (first + last) / 2

    if target == array[middle] {
        return middle
    } else {
        if target < array[middle] {
            return binarySearch(first: first, last: middle-1, target: target, array: array)
        } else {
            return binarySearch(first: middle+1, last: last, target: target, array: array)
        }
    }
}
```

* [Radix Sort](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Radix%20Sort.pdf)

> Radix Sort(기수 정렬)는 각 요소를 비교하지 않고 정렬하는 특별한 정렬 알고리즘입니다.

```swift
func radixSort(_ array: inout [Int]) -> [Int] {
    let radix = 10  // 0 ~ 9 까지의 10개의 자릿수
    var done = false
    var index: Int
    var digit = 1
    
    while !done {
        done = true
        var buckets: [[Int]] = [] // 10개의 버킷을 2중 배열로 선언
        for _ in 1...radix { buckets.append([]) }

        for number in array {
            index = number / digit // 해당 요소의 자릿수의 숫자를 추출
            buckets[index % radix].append(number) // 해당 자릿수 버킷에 데이터 추가
            if done && index > 0 {
                done = false
            }
        }

        var i = 0

        for j in 0..<radix {
            let bucket = buckets[j]
            for number in bucket {
                array[i] = number
                i += 1
            }
        }

        digit *= radix  // 다음 자릿수 비교
    }
    
    return array
}
```

* [Counting Sort](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Counting%20Sort.pdf)

> Counting Sort(계수 정렬)는 기수(Radix)정렬과 마찬가지로 각 요소를 비교하지 않고 정렬하는 정렬 알고리즘입니다.

```swift
func countingSort(_ array: [Int]) -> [Int] {
    guard array.count > 0 else { return [] }

    // Step 1
    // Create an array to store the count of each element
    let maxElement = array.max() ?? 0

    var countArray = [Int](repeating: 0, count: Int(maxElement + 1))
    
    for element in array {
        countArray[element] += 1
    }
    
    print("inputArray : \(array)")
    print("countArray : \(countArray)")
    
    // Step 2
    // Set each value to be the sum of the previous two values
    for index in 1 ..< countArray.count {
    let sum = countArray[index] + countArray[index - 1]
        countArray[index] = sum
    }
    
    print("countArray(accumulated) : \(countArray)”)

    // Step 3
    // Place the element in the final array as per the number of elements before it
    
    print("inputArray : \(array)")
    
    var sortedArray = [Int](repeating: 0, count: array.count)
    for element in array {
        countArray[element] -= 1
        sortedArray[countArray[element]] = element
        
        print("출력 배열의 \(countArray[element]) 번째 인덱스에 입력 배열 \(element) 값을 넣음")
        //print("countArray[\(element)] : \(countArray[element])")
    }
    
    print("sortedArray : \(sortedArray)")
    
    return sortedArray
}
```

* [Big O Notation](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Big%20O%20Notation.pdf)

> 컴퓨터 과학에서 알고리즘은 어떠한 문제를 최대한 빠르고 효율적으로 처리하기 위하여 사용합니다.
> 그러한 알고리즘에 대한 성능과 효율성을 측정하기 위해서 점근 표기법(Asymptotic Notation)이라는 것을 사용합니다.

* [Sorting Comparison](https://github.com/billnjoyce/Lectures/blob/master/docs/algorithm/%5BAlgorithm%5D%20Sorting%20Comparison.pdf)

> 정렬 알고리즘의 각 종류별로 특징 및 시간 및 공간 복잡도에 대해서 살펴봅니다.
