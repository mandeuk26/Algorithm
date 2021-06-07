let np = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = np[0], p = np[1]
var c:[[Int]] = Array(repeating: Array(repeating: 0, count: 2*n+1), count: 2*n+1)
var f:[[Int]] = Array(repeating: Array(repeating: 0, count: 2*n+1), count: 2*n+1)
var edge:[[Int]] = Array(repeating: [], count: 2*n+1)
for _ in 0..<p {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    makeEdge(s: 2*line[0], e: 2*line[1]-1, val: 1)
    makeEdge(s: 2*line[1], e: 2*line[0]-1, val: 1)
}
for i in 1...n {
    edge[2*i-1].append(2*i)
    c[2*i-1][2*i] = 1
}
print(edward(s: 2, e: 3))

func makeEdge(s: Int, e: Int, val: Int) {
    edge[s].append(e)
    edge[e].append(s)
    c[s][e] += val
}

func edward(s: Int, e: Int) -> Int {
    var result = 0
    while true {
        var parent:[Int] = Array(repeating: -1, count: 2*n+1)
        var q:[Int] = []
        parent[s] = s
        q.append(s)
        loop: while !q.isEmpty {
            let curr = q.removeFirst()
            for next in edge[curr] {
                if c[curr][next]-f[curr][next] > 0 && parent[next] == -1 {
                    parent[next] = curr
                    q.append(next)
                    if next == e {
                        break loop
                    }
                }
            }
        }
        if parent[e] == -1 {
            break
        }
        var idx = e
        var minF = 1_000_000_000
        while idx != s {
            let prev = parent[idx]
            minF = min(minF, c[prev][idx]-f[prev][idx])
            idx = prev
        }
        idx = e
        while idx != s {
            let prev = parent[idx]
            f[prev][idx] += minF
            f[idx][prev] -= minF
            idx = prev
        }
        result += minF
    }
    return result
}


