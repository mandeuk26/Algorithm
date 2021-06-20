let nkm = readLine()!.split(separator: " ").map{CLongLong(String($0))!}
var n = nkm[0], k = nkm[1], m = nkm[2]
let IntM = Int(m)
var comb:[[Int]] = Array(repeating: Array(repeating: 0, count: 2001), count: 2001)
comb[0][0] = 1
for i in 1...IntM {
    comb[i][0] = 1
    for j in 1...i {
        comb[i][j] = (comb[i-1][j-1] + comb[i-1][j])%IntM
    }
}

var result = 1
while n != 0 && k != 0 {
    result *= comb[Int(n%m)][Int(k%m)]
    result %= IntM
    n /= m
    k /= m
}
print(result)

