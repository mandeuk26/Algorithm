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

