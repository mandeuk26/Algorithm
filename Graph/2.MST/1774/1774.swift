import Foundation
struct DisjointSet {
    var arr:[Int]
    init(_ n: Int) {
        arr = [Int](0...n)
    }
    mutating func findRoot(_ n:Int) -> Int {
        if arr[n] == n {
            return n
        }
        else {
            let root = findRoot(arr[n])
            arr[n] = root
            return root
        }
    }
    mutating func union(_ n: Int, _ m: Int) -> Bool {
        let rootN = findRoot(n), rootM = findRoot(m)
        if rootN == rootM {
            return false
        }
        else if rootN < rootM {
            arr[rootM] = rootN
        }
        else {
            arr[rootN] = rootM
        }
        return true
    }
}

let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1]
var disjoint = DisjointSet(n)
var node:[(Double, Double)] = [(0, 0)]
var edge:[(Int, Int, Double)] = []
for _ in 1...n {
    let line = readLine()!.split(separator: " ").map{Double(String($0))!}
    node.append((line[0], line[1]))
}
for _ in 1...m {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    disjoint.union(line[0], line[1])
}
for i in 1..<n+1 {
    for j in i+1..<n+1 {
        if disjoint.findRoot(i) == disjoint.findRoot(j) {continue}
        let dx = node[i].0 - node[j].0
        let dy = node[i].1 - node[j].1
        let dist = sqrt(dx*dx + dy*dy)
        edge.append((i, j, dist))
    }
}
edge.sort(by: {$0.2 < $1.2})
var result:Double = 0
var index = 0
var count = edge.count
while index < count {
    let current = edge[index]
    index += 1
    if disjoint.union(current.0, current.1) {
        result += current.2
    }
}
print(String(format: "%.2f", result))
