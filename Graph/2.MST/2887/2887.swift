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

let n = Int(readLine()!)!
var X:[(n:Int, x:Int)] = []
var Y:[(n:Int, y:Int)] = []
var Z:[(n:Int, z:Int)] = []
var edge:[(n:Int, m:Int, d:Int)] = []
for i in 1...n {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    X.append((n:i, x:line[0]))
    Y.append((n:i, y:line[1]))
    Z.append((n:i, z:line[2]))
}
X.sort(by: {$0.1 < $1.1})
Y.sort(by: {$0.1 < $1.1})
Z.sort(by: {$0.1 < $1.1})
for i in 0..<n-1 {
    let currX = X[i], nextX = X[i+1]
    let currY = Y[i], nextY = Y[i+1]
    let currZ = Z[i], nextZ = Z[i+1]
    edge.append((n: currX.n, m: nextX.n, d: abs(currX.x - nextX.x)))
    edge.append((n: currY.n, m: nextY.n, d: abs(currY.y - nextY.y)))
    edge.append((n: currZ.n, m: nextZ.n, d: abs(currZ.z - nextZ.z)))
}
edge.sort(by: {$0.2 < $1.2})

var disjoint = DisjointSet(n)
var index = 0
var result = 0
let count = edge.count
while index < count {
    let curr = edge[index]
    index += 1
    if disjoint.union(curr.n, curr.m) {
        result += curr.d
    }
}
print(result)
