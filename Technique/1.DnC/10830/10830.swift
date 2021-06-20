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
