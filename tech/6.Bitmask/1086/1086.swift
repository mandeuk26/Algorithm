import Foundation
let n = Int(readLine()!)!
var num:[String] = []
var modnum:[Int] = []
var len:[Int] = []
var ten = Array(repeating: 1, count: 51)
var fact:[CLongLong] = Array(repeating: 1, count: 16)
for _ in 1...n {
    let tmp = readLine()!
    len.append(tmp.count)
    num.append(tmp)
}
let k = Int(readLine()!)!
for i in 1...50 {
    ten[i] = (ten[i-1]*10) % k
}
for i in 1...15 {
    fact[i] = fact[i-1]*CLongLong(i)
}
for i in 0..<n {
    var tmp = 0
    for c in num[i] {
        tmp = (tmp*10 + Int(String(c))!) % k
    }
    modnum.append(tmp)
}
var dp:[[CLongLong]] = Array(repeating: Array(repeating: 0, count: k), count: (1<<n))
dp[0][0] = 1

for i in 0..<(1<<n) {
    for j in 0..<k {
        if dp[i][j] == 0 {
            continue
        }
        for idx in 0..<n {
            if (i & (1<<idx)) == 0 {
                let next = ((j*ten[len[idx]])%k + modnum[idx]) % k
                dp[i|(1<<idx)][next] += dp[i][j]
            }
        }
    }
}

let gcdVal = gcd(a: dp[(1<<n)-1][0], b: fact[n])
print("\(dp[(1<<n)-1][0]/gcdVal)/\(fact[n]/gcdVal)")

func gcd(a: CLongLong, b: CLongLong) -> CLongLong {
    return b == 0 ? a : gcd(a:b, b:a % b)
}
