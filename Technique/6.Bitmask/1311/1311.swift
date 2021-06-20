let n = Int(readLine()!)!
var dp:[[Int]] = Array(repeating: Array(repeating: -1, count: 1<<21), count: 20)
var cost:[[Int]] = []
for _ in 1...n {
    cost.append(readLine()!.split(separator: " ").map{Int(String($0))!})
}

func dfs(d: Int, visited: Int) -> Int {
    if d == n {
        return 0
    }
    else if dp[d][visited] != -1 {
        return dp[d][visited]
    }
    else {
        dp[d][visited] = 1_000_000
        for i in 0..<n {
            if (visited & (1<<i)) == 0 {
                dp[d][visited] = min(dp[d][visited], dfs(d: d+1, visited: visited|(1<<i)) + cost[d][i])
            }
        }
        return dp[d][visited]
    }
}
print(dfs(d:0, visited:0))
