let lg = readLine()!.split(separator: " ").map{Int(String($0))!}
let l = lg[0], g = lg[1]
let c = readLine()!.split(separator: " ").map{Int64(String($0))!}
var dp:[[Int64]] = Array(repeating: Array(repeating: -1, count: l+1), count: g+1)
var opt = Array(repeating: Array(repeating: -1, count: l+1), count: g+1)
var sum:[Int64] = Array(repeating: 0, count: l+1)
for i in 1...l {
    sum[i] = sum[i-1]+c[i-1]
    dp[1][i] = sum[i]*Int64(i)
}
for t in 2..<g+1 {
    dnc(s: 1, e: l, l: 1, r: l, t: t)
}
print(dp[g][l])

func dnc(s: Int, e: Int, l: Int, r: Int, t: Int) {
    if s > e {
        return
    }
    let m = (s+e)/2
    for i in l...min(r, m) {
        let dpVal = dp[t-1][i] + c(i+1, m)
        if dp[t][m] == -1 || dp[t][m] > dpVal {
            dp[t][m] = dpVal
            opt[t][m] = i
        }
    }
    dnc(s: s, e: m-1, l: l, r: opt[t][m], t: t)
    dnc(s: m+1, e: e, l: opt[t][m], r: r, t: t)
}

func c(_ i: Int, _ j: Int) -> Int64 {
    return (sum[j]-sum[i-1])*Int64(j-i+1)
}

