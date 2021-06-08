
var edge:[[(Int, Int)]] = []
var check:[Bool] = []
var depth:[Int] = []
var parent:[[(n:Int, minc: Int, maxc: Int)]] = []
let maxK = 18

func dfs(n: (Int, Int), p: Int) {
    depth[n.0] = depth[p] + 1
    check[n.0] = true
    parent[n.0][0] = (n: p, minc: n.1, maxc: n.1)
    for i in 1...maxK {
        let midParent = parent[n.0][i-1]
        let finalParent = parent[midParent.n][i-1]
        parent[n.0][i] = (n:finalParent.n, minc:min(midParent.minc, finalParent.minc), maxc:max(midParent.maxc, finalParent.maxc))
    }
    for e in edge[n.0] {
        if !check[e.0] {
            dfs(n: e, p: n.0)
        }
    }
}

func LCA(x: Int, y: Int) -> (Int, Int) {
    var a = x, b = y
    var maximum = 0, minimum = 1_000_001
    if depth[a] > depth[b] {
        swap(&a, &b)
    }
    for i in 0...maxK {
        let current = parent[b][maxK-i]
        if depth[a] <= depth[current.n] {
            maximum = max(maximum, current.maxc)
            minimum = min(minimum, current.minc)
            b = current.n
        }
    }
    if a == b {
        return (minimum, maximum)
    }
    for i in 0...maxK {
        let currentA = parent[a][maxK-i]
        let currentB = parent[b][maxK-i]
        if currentA.n != currentB.n {
            maximum = max(maximum, currentA.maxc, currentB.maxc)
            minimum = min(minimum, currentA.minc, currentB.minc)
            a = currentA.n
            b = currentB.n
        }
    }
    let LCANodeA = parent[a][0], LCANodeB = parent[b][0]
    maximum = max(maximum, LCANodeA.maxc, LCANodeB.maxc)
    minimum = min(minimum, LCANodeA.minc, LCANodeB.minc)
    return (minimum, maximum)
}

let n = Int(readLine()!)!
edge = Array(repeating: [], count: n+1)
check = Array(repeating: false, count: n+1)
depth = Array(repeating: 0, count: n+1)
parent = Array(repeating: Array(repeating: (n:0, minc: 0, maxc: 0), count: maxK+1), count: n+1)
for _ in 0..<n-1 {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    let A = line[0], B = line[1], C = line[2]
    edge[A].append((B, C))
    edge[B].append((A, C))
}
dfs(n: (1, 0), p: 0)
let m = Int(readLine()!)!
var str = ""
for _ in 0..<m {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    let result = LCA(x: line[0], y: line[1])
    str += "\(result.0) \(result.1)\n"
}
print(str)

