let n = Int(readLine()!)!
let m = Int(readLine()!)!
var Edge:[[Int]] = Array(repeating: Array(repeating: 10_000_001, count: n+1), count: n+1)
for _ in 1...m {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    let from = line[0], to = line[1], cost = line[2]
    Edge[from][to] = min(Edge[from][to], cost)
}

for i in 1...n {
    for j in 1...n {
        if j == i {continue}
        for k in 1...n {
            if k == i || k == j {continue}
            Edge[j][k] = min(Edge[j][k], Edge[j][i] + Edge[i][k])
        }
    }
}

var str = ""
for i in 1...n {
    for j in 1...n {
        str += "\(Edge[i][j] > 10_000_000 ? 0 : Edge[i][j]) "
    }
    str += "\n"
}
print(str)
