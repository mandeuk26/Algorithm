let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1]
let s = 0, e = n+m+1, INF = 1_000_000_007
var c:[[Int]] = Array(repeating: Array(repeating: 0, count: n+m+2), count: n+m+2)
var f:[[Int]] = Array(repeating: Array(repeating: 0, count: n+m+2), count: n+m+2)
var d:[[Int]] = Array(repeating: Array(repeating: 0, count: n+m+2), count: n+m+2)
var edge:[[Int]] = Array(repeating: [], count: n+m+2)
var parent:[Int] = Array(repeating: -1, count: n+m+2)

func SPFA() -> Bool {
    var dst = Array(repeating: INF, count: n+m+2)
    var inq = Array(repeating: false, count: n+m+2)
    var queue = [Int]()
    queue.append(s)
    inq[s] = true
    dst[s] = 0
    while !queue.isEmpty {
        let curr = queue.removeFirst()
        inq[curr] = false
        for next in edge[curr] {
            if c[curr][next] - f[curr][next] <= 0 {
                continue
            }
            if dst[curr] < INF && (dst[next] == INF || dst[next] < dst[curr]+d[curr][next]) {
                dst[next] = dst[curr]+d[curr][next]
                parent[next] = curr
                if !inq[next] {
                    queue.append(next)
                    inq[next] = true
                }
            }
        }
    }
    return dst[e] != INF
}

func flow() -> (Int, Int) {
    var totalFlow = 0, money = 0
    while SPFA() {
        var idx = e, cost = 0, minF = INF
        while idx != s {
            let prev = parent[idx]
            minF = min(minF, c[prev][idx]-f[prev][idx])
            cost += d[prev][idx]
            idx = prev
        }
        idx = e
        while idx != s {
            let prev = parent[idx]
            f[prev][idx] += minF
            f[idx][prev] -= minF
            idx = prev
        }
        money += cost*minF
        totalFlow += minF
    }
    return (totalFlow, money)
}

func addEdge(s: Int, e: Int, val: Int) {
    edge[s].append(e)
    edge[e].append(s)
    c[s][e] += val
}

for i in 1...n {
    addEdge(s: s, e: i, val: 1)
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    for j in 0..<line[0] {
        let workIdx = n+line[2*j+1], cost = line[2*j+2]
        addEdge(s: i, e: workIdx, val: 1)
        d[i][workIdx] = cost
        d[workIdx][i] = -cost
    }
}
for i in n+1...n+m {
    addEdge(s: i, e: e, val: 1)
}
let result = flow()
print(result.0)
print(result.1)

