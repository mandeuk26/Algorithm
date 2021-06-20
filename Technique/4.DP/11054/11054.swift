let n = Int(readLine()!)!
let A = readLine()!.split(separator: " ").map{Int($0)!}
var dp = LIS(A: A)
var backdp = LIS(A: A.reversed())
backdp.reverse()
for i in 0..<n {
    dp[i] += backdp[i]-1
}
print(dp.max()!)

func LIS(A: [Int]) -> [Int] {
    let n = A.count
    var dp = Array(repeating: -1, count: n)
    var lis = Array(repeating: -1, count: n)
    var count = 0
    for i in 0..<n {
        let idx = lowerBound(start: 0, end: count, key: A[i], arr: dp)
        dp[idx] = A[i]
        lis[i] = idx + 1
        if idx == count {
            count += 1
        }
    }
    return lis
}

func lowerBound(start: Int, end: Int, key: Int, arr: [Int]) -> Int {
    var s = start, e = end
    while s < e {
        let m = (s+e)/2
        if arr[m] >= key {
            e = m
        }
        else {
            s = m+1
        }
    }
    return e
}
