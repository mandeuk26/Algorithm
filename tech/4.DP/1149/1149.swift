let n = Int(readLine()!)!
var cost: [[Int]] = []
for _ in 1...n {
    cost.append(readLine()!.split(separator: " ").map{Int(String($0))!})
}

var dp = cost[0]
for idx in 1..<n {
    let rcost = min(dp[1], dp[2]) + cost[idx][0]
    let gcost = min(dp[0], dp[2]) + cost[idx][1]
    let bcost = min(dp[0], dp[1]) + cost[idx][2]
    dp = [rcost, gcost, bcost]
}
print(dp.min()!)
