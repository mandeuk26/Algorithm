struct Heap<T> {
    var arr:[T]
    var compare:(T, T) -> Bool
    mutating func shiftUp(a: Int) {
        var index = a
        while index > 0 {
            let parent = (index-1)/2
            if compare(arr[index], arr[parent]) {
                arr.swapAt(index, parent)
                index = parent
            }
            else {
                break
            }
        }
    }
    mutating func shiftDown(a: Int) {
        var index = a
        var child = 2*a+1
        let count = arr.count
        while child < count {
            if child + 1 < count {
                child = compare(arr[child], arr[child+1]) ? child : child+1
            }
            if compare(arr[child], arr[index]) {
                arr.swapAt(index, child)
                index = child
                child = 2*index+1
            }
            else {
                break
            }
        }
    }
    mutating func insert(_ a: T) {
        arr.append(a)
        shiftUp(a: arr.count-1)
    }
    mutating func pop() -> T? {
        if arr.isEmpty {
            return nil
        }
        else {
            arr.swapAt(0, arr.count-1)
            let result = arr.removeLast()
            shiftDown(a: 0)
            return result
        }
    }
    init(arr: [T] = [], compare: @escaping (T, T) -> Bool) {
        self.arr = arr
        self.compare = compare
    }
}

var minHeap = Heap<Int>{
    if abs($0) < abs($1) {
        return true
    }
    else if abs($0) == abs($1) {
        return $0 < $1
    }
    else {
        return false
    }
}
let n = Int(readLine()!)!
for _ in 1...n {
    let k = Int(readLine()!)!
    if k == 0 {
        print(minHeap.pop() ?? 0)
    }
    else {
        minHeap.insert(k)
    }
}
