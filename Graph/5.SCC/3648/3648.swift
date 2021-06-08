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


while let l = readLine() {
    let nm = l.split(separator: " ").map{Int(String($0))!}
    let n = nm[0], m = nm[1]
    edge = Array(repeating: [], count: 2*n)
    visited = Array(repeating: 0, count: 2*n)
    finished = Array(repeating: false, count: 2*n)
    NodeSCC = Array(repeating: 0, count: 2*n)
    index = 1
    SCC = []
    stack = []

    for _ in 0..<m {
        let line = readLine()!.split(separator: " ").map{Int(String($0))!}
        var N1 = line[0], N2 = line[1]
        N1 = (N1 < 0 ? -(2*N1)-1 : 2*(N1-1))
        N2 = (N2 < 0 ? -(2*N2)-1 : 2*(N2-1))
        edge[NotOper(n: N1)].append(N2)
        edge[NotOper(n: N2)].append(N1)
    }
    edge[NotOper(n: 0)].append(0)
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
    print(possible ? "yes" : "no")
}

