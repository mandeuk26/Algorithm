let VE = readLine()!.split(separator: " ").map{Int(String($0))!}
let V = VE[0], E = VE[1]
var DP:[[Int]] = Array(repeating: Array(repeating: 4_000_001, count: V+1), count: V+1)
for _ in 0..<E {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    DP[line[0]][line[1]] = line[2]
}
for i in 1...V {
    for j in 1...V {
        for k in 1...V {
            DP[j][k] = min(DP[j][k], DP[j][i] + DP[i][k])
        }
    }
}

var result = 4_000_001
for i in 1...V {
    result = min(result, DP[i][i])
}
print(result == 4_000_001 ? -1 : result)


