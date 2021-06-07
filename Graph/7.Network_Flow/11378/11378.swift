let nmk = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nmk[0], m = nmk[1], k = nmk[2]
let s = 0, bridge = n+m+1, e = n+m+2
var c:[[Int]] = Array(repeating: Array(repeating: 0, count: e+1), count: e+1)
var f:[[Int]] = Array(repeating: Array(repeating: 0, count: e+1), count: e+1)
var edge:[[Int]] = Array(repeating: [], count: e+1)

// 0이 스타트 n+m+1이 bridge n+m+2가 end
for i in 1...n {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    for j in 0..<line[0] {
        let mIdx = n+line[j+1]
        addEdge(s: i, e: mIdx, val: 1)
    }
    addEdge(s: s, e: i, val: 1)
    addEdge(s: bridge, e: i, val: k)
}
addEdge(s: s, e: bridge, val: k)
for i in n+1...n+m {
    addEdge(s: i, e: e, val: 1)
}
print(edward(s: s, e: e))


func addEdge(s: Int, e: Int, val: Int) {
    edge[s].append(e)
    edge[e].append(s)
    c[s][e] += val
}

func edward(s: Int, e: Int) -> Int {
    var result = 0
    while true {
        var parent:[Int] = Array(repeating: -1, count: e+1)
        var q:[Int] = []
        parent[s] = s
        q.append(s)
        while !q.isEmpty && parent[e] == -1 {
            let curr = q.removeFirst()
            for i in edge[curr] {
                if c[curr][i] - f[curr][i] > 0 && parent[i] == -1 {
                    parent[i] = curr
                    q.append(i)
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
            minF = min(minF, c[prev][idx] - f[prev][idx])
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
