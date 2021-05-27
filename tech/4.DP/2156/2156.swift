let n = Int(readLine()!)!
var c = Array(repeating: 0, count: n)
for i in 0..<n {
    c[i] = Int(readLine()!)!
}
if n == 1 {
    print(c[0])
}
else {
    var dp = Array(repeating: Array(repeating: 0, count: 2), count: 2)
    dp[0][1] = c[0]
    dp[1][0] = c[0]
    dp[1][1] = c[0]+c[1]
    for i in 2..<n {
        let nDrink = max(dp[1][0], dp[1][1])
        let Drink = max(dp[1][0], dp[0][0] + c[i-1]) + c[i]
        dp[0] = dp[1]
        dp[1] = [nDrink, Drink]
    }
    print(max(dp[1][0], dp[1][1]))
}
