let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1], INF = 60_000_001
var Dist:[Int] = Array(repeating: INF, count: n+1)
var Edge:[[(Int, Int)]] = Array(repeating: [], count: n+1)
for _ in 1...m {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    Edge[line[0]].append((line[1], line[2]))
}

Dist[1] = 0
for _ in 1..<n {
    for i in 1...n {
        if Dist[i] == INF {
            continue
        }
        for e in Edge[i] {
            Dist[e.0] = min(Dist[e.0], Dist[i] + e.1)
        }
    }
}

var change = false
for i in 1...n {
    if Dist[i] == INF {
        continue
    }
    for e in Edge[i] {
        if Dist[e.0] > Dist[i] + e.1 {
            change = true
            break
        }
    }
}
if change {
    print(-1)
}
else {
    for i in 2...n {
        print(Dist[i] == INF ? -1 : Dist[i])
    }
}


