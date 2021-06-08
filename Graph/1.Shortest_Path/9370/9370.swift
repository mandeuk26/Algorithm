struct PriorityQueue {
    private var heap = Heap<(Int, Int)>{
        if $0.1 < $1.1 {
            return true
        }
        else {
            return false
        }
    }
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    mutating func insert(_ a: (Int, Int)) {
        heap.insert(a)
    }
    mutating func delete() -> (Int, Int)? {
        return heap.delete()
    }
}

public struct Heap<T> {
    private var arr:[T]
    private var compare:(T, T) -> Bool
    public var isEmpty:Bool {
        return arr.isEmpty
    }
    public var count:Int {
        return arr.count
    }
    
    init(arr: [T] = [], compare: @escaping (T, T) -> Bool) {
        self.arr = arr
        self.compare = compare
    }
    
    private mutating func shiftUp(_ a: Int) {
        var i = a
        while i > 0 {
            let parent = (i-1)/2
            if compare(arr[i], arr[parent]) {
                arr.swapAt(i, parent)
                i = parent
            }
            else {
                break
            }
        }
    }
    private mutating func shiftDown(_ a: Int) {
        var i = a
        var s = 2*a+1
        while s < arr.count {
            if s+1 < arr.count && compare(arr[s+1], arr[s]) {
                s = s+1
            }
            if compare(arr[s], arr[i]) {
                arr.swapAt(i, s)
                i = s
                s = 2*i+1
            }
            else {
                break
            }
        }
    }
    public mutating func insert(_ a: T) {
        arr.append(a)
        shiftUp(arr.count-1)
    }
    public mutating func delete() -> T? {
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
}

func calculateMin(start: Int, PQ: inout PriorityQueue, Dist: inout [Int], Edge: [[(Int, Int)]]) {
    PQ.insert((start,0))
    Dist[start] = 0
    while !PQ.isEmpty {
        let current = PQ.delete()!
        let currentIndex = current.0
        let currentDist = current.1
        for i in 0..<Edge[currentIndex].count {
            let nextIndex = Edge[currentIndex][i].0
            let nextWeight = Edge[currentIndex][i].1
            if Dist[nextIndex] > currentDist + nextWeight {
                Dist[nextIndex] = currentDist + nextWeight
                PQ.insert((nextIndex, currentDist + nextWeight))
            }
        }
    }
}

let testcase = Int(readLine()!)!
for _ in 1...testcase {
    let nmt = readLine()!.split(separator: " ").map{Int(String($0))!}
    let sgh = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n = nmt[0], m = nmt[1], t = nmt[2], s = sgh[0], g = sgh[1], h = sgh[2]
    var Edge:[[(Int, Int)]] = Array(repeating: [], count: n+1)
    var Dist = Array(repeating: 50_000_001, count: n+1)
    var Dist2 = Array(repeating: 50_000_001, count: n+1)
    var Dist3 = Array(repeating: 50_000_001, count: n+1)
    var Destination:[Int] = []
    for _ in 1...m {
        let edge = readLine()!.split(separator: " ").map{Int(String($0))!}
        Edge[edge[0]].append((edge[1], edge[2]))
        Edge[edge[1]].append((edge[0], edge[2]))
    }
    for _ in 1...t {
        Destination.append(Int(readLine()!)!)
    }
    Destination.sort()
    var PQ = PriorityQueue()
    calculateMin(start: g, PQ: &PQ, Dist: &Dist, Edge: Edge)
    calculateMin(start: h, PQ: &PQ, Dist: &Dist2, Edge: Edge)
    calculateMin(start: s, PQ: &PQ, Dist: &Dist3, Edge: Edge)
    var str = ""
    for goal in Destination {
        let result = min(Dist[s] + Dist[h] + Dist2[goal], Dist2[s] + Dist2[g] + Dist[goal])
        if result == Dist3[goal] {
            str += "\(goal) "
        }
    }
    print(str)
}
