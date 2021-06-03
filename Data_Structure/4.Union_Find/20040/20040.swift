struct DisjointSet {
    var arr:[Int]
    init(_ n: Int) {
        arr = [Int](0..<n)
    }
    mutating func findRoot(_ n: Int) -> Int {
        if arr[n] == n {
            return n
        }
        else {
            let root = findRoot(arr[n])
            arr[n] = root
            return root
        }
    }
    mutating func union(_ a: Int, _ b: Int) -> Bool {
        let rootA = findRoot(a), rootB = findRoot(b)
        if rootA == rootB {
            return false
        }
        else if rootA < rootB {
            arr[rootB] = rootA
        }
        else {
            arr[rootA] = rootB
        }
        return true
    }
}

let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n =  nm[0], m = nm[1]
var disjointSet = DisjointSet(n)
var result = 0
for i in 1...m {
    let node = readLine()!.split(separator: " ").map{Int(String($0))!}
    if !disjointSet.union(node[0], node[1]) {
        result = i
        break
    }
}
print(result)
