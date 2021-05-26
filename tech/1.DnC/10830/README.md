# 백준 10830 행렬 제곱
NxN인 행렬 A를 B제곱하는 프로그램을 작성하는 문제이다.  
분할정복 readme에서 설명했던 것과 동일한 방식으로 진행되는데 차이점은 2x2가 아닌 NxN이기 때문에 형식에 맞춰 수정만 하면 되는 문제이다.  
각 원소를 1000으로 나눈 나머지를 출력해야하기에 mod 연산을 꾸준히 해줘야한다.
```swift
let nm = readLine()!.split(separator: " ").map{Int($0)!}
let n = nm[0], m = nm[1]
var I = Array(repeating: Array(repeating: 0, count: n), count: n)
for i in 0..<n {
    I[i][i] = 1
}

var A:[[Int]] = []
for _ in 1...n {
    A.append(readLine()!.split(separator: " ").map{Int($0)!%1000})
}
let AB = powA(A: A, n: n, m: m)
var str = ""
for i in 0..<n {
    for j in 0..<n {
        str += "\(AB[i][j]) "
    }
    str += "\n"
}
print(str)

func powA(A: [[Int]], n: Int, m: Int) -> [[Int]] {
    if m == 0 {
        return I
    }
    else if m == 1 {
        return A
    }
    else {
        let p1 = powA(A: A, n: n, m: m/2)
        let p2 = powA(A: A, n: n, m: m%2)
        return multA(A: multA(A: p1, B: p1, n: n), B: p2, n: n)
    }
}


func multA(A: [[Int]], B: [[Int]], n: Int) -> [[Int]] {
    var resultArr = Array(repeating: Array(repeating: 0, count: n), count: n)
    for i in 0..<n {
        for j in 0..<n {
            var result = 0
            for k in 0..<n {
                result += (A[i][k] * B[k][j]) % 1000
            }
            resultArr[i][j] = result % 1000
        }
    }
    return resultArr
}
```

