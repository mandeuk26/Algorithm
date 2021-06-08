var edge:[[(n:Int, c:Int)]] = []
var check:[Bool] = []
var depth:[Int] = []
var dist:[Int] = []
var parent:[[Int]] = []
let maxK = 18

func dfs(n: (n:Int, c:Int), p: Int) {
    depth[n.n] = depth[p] + 1
    check[n.n] = true
    parent[n.n][0] = p
    dist[n.n] = dist[p] + n.c
    for i in 1...maxK {
        parent[n.n][i] = parent[parent[n.n][i-1]][i-1]
    }
    for e in edge[n.n] {
        if !check[e.n] {
            dfs(n: e, p: n.n)
        }
    }
}

func LCA(x: Int, y: Int) -> Int {
    var a = x, b = y
    if depth[a] > depth[b] {
        swap(&a, &b)
    }
    for i in 0...maxK {
        if depth[a] <= depth[parent[b][maxK-i]] {
            b = parent[b][maxK-i]
        }
    }
    if a == b {
        return a
    }
    for i in 0...maxK {
        let currentA = parent[a][maxK-i]
        let currentB = parent[b][maxK-i]
        if currentA != currentB {
            a = currentA
            b = currentB
        }
    }
    return parent[a][0]
}

func LCACost(x: Int, y: Int) -> Int {
    let lca = LCA(x: x, y: y)
    return dist[x] + dist[y] - 2*dist[lca]
}

func LCAPath(x: Int, y: Int, z: Int) -> Int {
    let lca = LCA(x: x, y: y)
    let leftdist = depth[x] - depth[lca]
    let rightdist = depth[y] - depth[lca]
    var k = z - 1
    if k > leftdist {
        k = leftdist + rightdist + 1 - z
        var index = y
        var i = 0
        while k != 0 {
            if k&1 != 0 {
                index = parent[index][i]
            }
            k = k >> 1
            i += 1
        }
        return index
    }
    else {
        var index = x
        var i = 0
        while k != 0 {
            if k&1 != 0 {
                index = parent[index][i]
            }
            k = k >> 1
            i += 1
        }
        return index
    }
}

let n = Int(readLine()!)!
edge = Array(repeating: [], count: n+1)
check = Array(repeating: false, count: n+1)
depth = Array(repeating: 0, count: n+1)
parent = Array(repeating: Array(repeating: 0, count: maxK+1), count: n+1)
dist = Array(repeating: 0, count: n+1)
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
    if line[0] == 1 {
        str += "\(LCACost(x: line[1], y: line[2]))\n"
    }
    else {
        str += "\(LCAPath(x: line[1], y: line[2], z: line[3]))\n"
    }
}
print(str)

