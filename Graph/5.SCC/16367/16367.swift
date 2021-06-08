var edge:[[Int]] = []
var visited:[Int] = []
var finished:[Bool] = []
var index = 1
var SCC:[[Int]] = []
var NodeSCC:[Int] = []
var stack:[Int] = []

func dfs(n: Int) -> Int {
    visited[n] = index
    index += 1
    stack.append(n)
    var parent = visited[n]
    for e in edge[n] {
        if visited[e] == 0 {
            parent = min(parent, dfs(n: e))
        }
        else if !finished[e] {
            parent = min(parent, visited[e])
        }
    }
    if parent == visited[n] {
        var tmpScc:[Int] = []
        let count = SCC.count
        while !stack.isEmpty {
            let tmpNode = stack.popLast()!
            tmpScc.append(tmpNode)
            finished[tmpNode] = true
            NodeSCC[tmpNode] = count
            if tmpNode == n {
                break
            }
        }
        SCC.append(tmpScc)
    }
    return parent
}

func NotOper(n: Int) -> Int {
    return (n%2 == 0 ? n+1 : n-1)
}


let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1]
edge = Array(repeating: [], count: 2*n)
visited = Array(repeating: 0, count: 2*n)
finished = Array(repeating: false, count: 2*n)
NodeSCC = Array(repeating: 0, count: 2*n)
index = 1
SCC = []
stack = []

for _ in 0..<m {
    let line = readLine()!.split(separator: " ").map{String($0)}
    var N1 = Int(line[0])!, C1 = line[1]
    var N2 = Int(line[2])!, C2 = line[3]
    var N3 = Int(line[4])!, C3 = line[5]
    N1 = (C1 == "R" ? 2*N1-1 : 2*N1-2)
    N2 = (C2 == "R" ? 2*N2-1 : 2*N2-2)
    N3 = (C3 == "R" ? 2*N3-1 : 2*N3-2)
    edge[NotOper(n: N1)].append(N2)
    edge[NotOper(n: N2)].append(N1)
    edge[NotOper(n: N2)].append(N3)
    edge[NotOper(n: N3)].append(N2)
    edge[NotOper(n: N1)].append(N3)
    edge[NotOper(n: N3)].append(N1)
}
for i in 0..<2*n {
    if visited[i] == 0 {
        dfs(n: i)
    }
}
var possible = true
for i in 0..<n {
    if NodeSCC[2*i] == NodeSCC[2*i+1] {
        possible = false
        break
    }
}
if possible {
    var result = Array(repeating: -1, count: n)
    for i in 0..<SCC.count {
        let currentSCC = SCC[SCC.count-1-i]
        for x in currentSCC {
            if result[x/2] == -1 {
                result[x/2] = x%2 // 0일떄 Red인쇄 1일떄 Blue인쇄
            }
        }
    }
    var str = ""
    for r in result {
        str += (r == 0 ? "R" : "B")
    }
    print(str)
}
else {
    print(-1)
}
