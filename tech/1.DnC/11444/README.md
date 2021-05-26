# 백준 11444 피보나치수6
n이 입력으로 주어질 때 n번째 피보나치 수의 값을 출력하는 문제이다.  
n값이 최대 1,000,000,000,000,000,000까지 나올 수 있으므로 *O(n)* 의 방식을 이용하면 시간초과가 뜨게된다.
DnC readme에서 설명했듯이 피보나치를 행렬로 표현해서 *O(logn)* 안에 해결하는 것이 포인트다.
값이 굉장히 커질 수 있으므로 문제에서 주어진 1,000,000,007로 나눈 나머지를 출력한다.
```swift
let n = Int(readLine()!)!
let A = [[1, 1], [1, 0]]
let I = [[1, 0], [0, 1]]
let result = powA(A: A, m: n)
print(result[0][1])

func powA(A: [[Int]], m: Int) -> [[Int]] {
    if m == 0 {
        return I
    }
    else if m == 1 {
        return A
    }
    else {
        let p1 = powA(A: A, m: m/2)
        let p2 = powA(A: A, m: m%2)
        return multA(A: multA(A: p1, B: p1), B: p2)
    }
}

func multA(A: [[Int]], B: [[Int]]) -> [[Int]] {
    var resultArr = [[0, 0], [0, 0]]
    for i in 0..<2 {
        for j in 0..<2 {
            var result = 0
            for k in 0..<2 {
                result += (A[i][k] * B[k][j]) % 1_000_000_007
            }
            resultArr[i][j] = result % 1_000_000_007
        }
    }
    return resultArr
}
```

