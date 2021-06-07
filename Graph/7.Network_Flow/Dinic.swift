let n = 100
let INF = 1_000_000_007
let s = 501, e = 502
var level:[Int] = Array(repeating: -1, count: 555)
var edge:[[Int]] = Array(repeating: [], count: 555)
var c:[[Int]] = Array(repeating: Array(repeating: 0, count: 555), count: 555)
var f:[[Int]] = Array(repeating: Array(repeating: 0, count: 555), count: 555)
var work:[Int] = Array(repeating: 0, count: 555)

// 마찬가지로 edge와 capacity 배열을 문제에 맞게 잘 설정해주도록 하자.

func addEdge(s: Int, e: Int, val: Int) {
    edge[s].append(e)
    edge[e].append(s)
    c[s][e] += val
}

func bfs() -> Bool {
    level = Array(repeating: -1, count: 555)
    var q = [Int]()
    level[s] = 1
    q.append(s)
    while !q.isEmpty {
        let curr = q.removeFirst()
        for i in edge[curr] {
            if level[i] == -1 && c[curr][i] - f[curr][i] > 0 {
                level[i] = level[curr] + 1
                q.append(i)
            }
        }
    }
    return level[e] != -1
}

func dfs(curr: Int, flow: Int) -> Int {
    if curr == e {
        return flow
    }
    let nextVertex = work[curr]
    for i in nextVertex..<edge[curr].count {
        let next = edge[curr][i]
        if level[next] == level[curr] + 1 && c[curr][next] - f[curr][next] > 0 {
            let tmp = dfs(curr: next, flow: min(flow, c[curr][next] - f[curr][next]))
            // 유량은 항상 경로상 최솟값이 흘러야 함을 유의
            if tmp > 0 {
                f[curr][next] += tmp
                f[next][curr] -= tmp
                return tmp
            }
        }
        work[curr] += 1
        // 유량이 해당 edge로 흐르지 못한다면 work배열을 1을 증가시킨다.
    }
    return 0
}

func dinic() -> Int {
    var totalFlow = 0
    while bfs() {
        work = Array(repeating: 0, count: 555)
        while true {
            let tmpflow  = dfs(curr: s, flow: INF)
            if tmpflow == 0 {
                break
            }
            totalFlow += tmpflow
        }
    }
    return totalFlow
}
