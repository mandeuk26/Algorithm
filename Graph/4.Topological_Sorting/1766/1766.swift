struct PriorityQueue<T>{
    private var arr:[T]
    private var compare:(T, T) -> Bool
    public var isEmpty:Bool {
        return arr.isEmpty
    }
    public var count:Int {
        return arr.count
    }
    mutating func shiftUp(_ a: Int) {
        var i = a
        while i > 0 {
            let p = (i-1)/2
            if compare(arr[i], arr[p]) {
                arr.swapAt(i, p)
                i = p
            }
            else {
                break
            }
        }
    }
    mutating func shiftDown(_ a: Int) {
        var i = a
        var c = 2*i+1
        while c < arr.count {
            if c+1 < arr.count && compare(arr[c+1], arr[c]) {
                c = c+1
            }
            if compare(arr[c], arr[i]) {
                arr.swapAt(c, i)
                i = c
                c = 2*i+1
            }
            else {
                break
            }
        }
    }
    mutating func insert(_ a: T) {
        arr.append(a)
        shiftUp(arr.count-1)
    }
    mutating func pop() -> T? {
        if arr.isEmpty {
            return nil
        }
        else {
            arr.swapAt(0, arr.count-1)
            let result = arr.popLast()
            shiftDown(0)
            return result
        }
    }
    init(arr: [T] = [], compare: @escaping (T, T) -> Bool) {
        self.arr = arr
        self.compare = compare
    }
}

let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1]
var edge:[[Int]] = Array(repeating: [], count: n+1)
var inedge:[Int] = Array(repeating: 0, count: n+1)
var pq = PriorityQueue<Int>(compare: <)
for _ in 0..<m {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    let S1 = line[0], S2 = line[1]
    edge[S1].append(S2)
    inedge[S2] += 1
}
for i in 1...n {
    if inedge[i] == 0 {
        pq.insert(i)
    }
}

var str = ""
while !pq.isEmpty {
    let curr = pq.pop()!
    str += "\(curr) "
    for e in edge[curr] {
        inedge[e] -= 1
        if inedge[e] == 0 {
            pq.insert(e)
        }
    }
}
print(str)

