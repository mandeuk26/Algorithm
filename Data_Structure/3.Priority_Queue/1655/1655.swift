struct Heap<T> {
    var arr:[T]
    var compare:(T, T) -> Bool
    var root:T? {
        get {
            if arr.isEmpty {
                return nil
            }
            else {
                return arr[0]
            }
        }
    }
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

var minHeap = Heap<Int>{$0<$1}
var maxHeap = Heap<Int>{$0>$1}

let n = Int(readLine()!)!
if n == 1 {
    print(Int(readLine()!)!)
}
else {
    var str = ""
    maxHeap.insert(Int(readLine()!)!)
    str += "\(maxHeap.root!)\n"
    for i in 2...n {
        let k = Int(readLine()!)!
        if i%2 == 0 {minHeap.insert(k)}
        else {maxHeap.insert(k)}
        let a = maxHeap.root!
        let b = minHeap.root!
        if a > b {
            minHeap.arr[0] = a
            maxHeap.arr[0] = b
        }
        if i%2 == 0 {maxHeap.shiftDown(a: 0)}
        else {minHeap.shiftDown(a: 0)}
        str += "\(maxHeap.root!)\n"
    }
    print(str)
}

