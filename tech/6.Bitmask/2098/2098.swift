let n = Int(readLine()!)!
var dp:[[Int]] = Array(repeating: Array(repeating: -1, count: 1<<n), count: 20)
var cost:[[Int]] = []
for _ in 1...n {
    cost.append(readLine()!.split(separator: " ").map{Int(String($0))!})
}

func dfs(d: Int, visited: Int) -> Int {
    if visited == ((1<<n)-1) {
        return cost[d][0] == 0 ? 16_000_001 : cost[d][0]
    }
    else if dp[d][visited] != -1 {
        return dp[d][visited]
    }
    else {
        dp[d][visited] = 16_000_001
        for i in 0..<n {
            if (visited & (1<<i)) == 0 && cost[d][i] != 0 {
                dp[d][visited] = min(dp[d][visited], dfs(d: i, visited: visited | (1<<i)) + cost[d][i])
            }
        }
        return dp[d][visited]
    }
}
var result = 16_000_001
result = min(result, dfs(d: 0, visited: 1))
print(result)

