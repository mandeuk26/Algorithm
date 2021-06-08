public struct PriorityQueue {
    private var heap = Heap<(Int, Int, Int)>(compare: {
        return $0.2 < $1.2
    })
    public var isEmpty:Bool {
        return heap.isEmpty
    }
    public var count:Int {
        return heap.count
    }
    public mutating func insert(_ a: (Int, Int, Int)) {
        heap.insert(a)
    }
    public mutating func pop() -> (Int, Int, Int)? {
        return heap.pop()
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
    public mutating func shiftUp(_ a: Int) {
        var i = a
        while i > 0 {
            if compare(arr[i], arr[(i-1)/2]) {
                arr.swapAt(i, (i-1)/2)
                i = (i-1)/2
            }
            else {
                break
            }
        }
    }
    public mutating func shiftDown(_ a: Int) {
        var i = a
        var s = 2*i+1
        while s < arr.count {
            if s+1 < arr.count && compare(arr[s+1], arr[s]) {
                s += 1
            }
            if compare(arr[s], arr[i]) {
                arr.swapAt(s, i)
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
    public mutating func pop() -> T? {
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

let testcase = Int(readLine()!)!
for _ in 1...testcase {
    let NMK = readLine()!.split(separator: " ").map{Int(String($0))!}
    let N = NMK[0], M = NMK[1], K = NMK[2]
    var Edge:[[[(Int, Int)]]] = Array(repeating: Array(repeating: [], count: N+1), count: N+1)
    var Dist:[[Int]] = Array(repeating: Array(repeating: 100001, count: M+1), count: N+1)
    for _ in 1...K {
        let line = readLine()!.split(separator: " ").map{Int(String($0))!}
        let from = line[0], to = line[1], cost = line[2], time = line[3]
        Edge[from][to].append((cost, time))
    }
    
    
    var PQ = PriorityQueue()
    PQ.insert((1, 0, 0))
    Dist[1][0] = 0
    while !PQ.isEmpty {
        let current = PQ.pop()!
        let currentIndex = current.0
        let currentCost = current.1
        let currentTime = current.2
        if currentIndex == N {break}
        for i in 1...N {
            let nextIndex = i
            for edge in Edge[currentIndex][nextIndex] {
                let nextCost = currentCost + edge.0
                if nextCost > M {continue}
                let nextTime = currentTime + edge.1
                if Dist[nextIndex][nextCost] <= nextTime {continue}
                for k in nextCost...M {
                    if Dist[nextIndex][k] > nextTime {
                        Dist[nextIndex][k] = nextTime
                    }
                    else {
                        break
                    }
                }
                PQ.insert((nextIndex, nextCost, nextTime))
            }
        }
    }
    var result = 100001
    for i in 0...M {
        result = min(result, Dist[N][i])
    }
    print(result == 100001 ? "Poor KCM" : result)
}
