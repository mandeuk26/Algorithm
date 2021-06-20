# 백준 11054 가장 긴 바이토닉 부분 수열
어떤 수열이 주어졌을 때 가장 긴 바이토닉 부분 수열을 찾는 문제이다. 바이토닉 부분 수열이란 앞에서부터 증가했다가 어떤 수를 기점으로 감소하는 형태를 보이는 부분 수열을 말한다.  
앞에서 다루었던 LIS의 응용버전이다. 간단하게 정상적인 LIS를 구한 뒤 주어진 수열을 reverse해서 거꾸로 계산한 LIS을 구해준 뒤 각 자리마다 더해준 후 최댓값을 찾아내면 된다. 
```swift
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
```
성능을 위해 *O(nlogn)* 으로 구현했으며 각 수열의 자리마다 본인을 마지막으로 포함하는 LIS의 값을 구해야하기 때문에 lis 배열에 저장해둔 뒤 return 시켰다.
