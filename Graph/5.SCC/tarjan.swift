let n = 2000
var edge:[[Int]] = Array(repeating: [], count: n)
var visited:[Int] = Array(repeating: 0, count: n)
var finished:[Bool] = Array(repeating: false, count: n)
var index = 1
var SCC:[[Int]] = []
var NodeSCC:[Int] = Array(repeating: -1, count: n)
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

for i in 0..<n {
    if visited[i] == 0 {
        dfs(n: i)
    }
}

