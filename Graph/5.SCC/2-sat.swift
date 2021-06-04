let n = 20, m = 10
var edge:[[Int]] = Array(repeating: [], count: 2*n)
var visited:[Int] = Array(repeating: 0, count: 2*n)
var finished:[Bool] = Array(repeating: false, count: 2*n)
var NodeSCC:[Int] = Array(repeating: 0, count: 2*n)
var index = 1
var SCC:[[Int]] = []
var stack:[Int] = []

for _ in 0..<m {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    var N1 = line[0], N2 = line[1]
    N1 = (N1 < 0 ? -(2*N1)-1 : 2*(N1-1))
    N2 = (N2 < 0 ? -(2*N2)-1 : 2*(N2-1))
    edge[NotOper(n: N1)].append(N2)
    edge[NotOper(n: N2)].append(N1)
}
//조건식 간선 설정 코드

for i in 0..<2*n {
    if visited[i] == 0 {
        dfs(n: i)
    }
}
//SCC생성

var possible = true
for i in 0..<n {
    if NodeSCC[2*i] == NodeSCC[2*i+1] {
        possible = false
        break
    }
}
//참이 되는 해 존재 여부 파악

var result = Array(repeating: -1, count: n)
if possible {
    for i in 0..<SCC.count {
        let currentSCC = SCC[SCC.count-1-i]
        for s in currentSCC {
            if result[s/2] == -1 {
                result[s/2] = s%2
            }
        }
    }
}
//최종 해 계산

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

