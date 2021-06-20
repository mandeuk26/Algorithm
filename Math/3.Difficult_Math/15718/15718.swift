var combo:[[Int]] = []
func Euclid(a: Int, b: Int) -> Int {
    var r1 = a, r2 = b, s1 = 1, t1 = 0, s2 = 0, t2 = 1
    while r2 != 0 {
        let q = r1/r2
        let r = r1-q*r2, s = s1-q*s2, t = t1-q*t2
        r1 = r2
        s1 = s2
        t1 = t2
        r2 = r
        s2 = s
        t2 = t
    }
    return s1 > 0 ? s1 : b+s1
}

func lucas(n: Int, m: Int, p: Int) -> Int {
    var N = n, M = m
    var result = 1
    while N != 0 && M != 0 {
        result *= combo[Int(N%p)][Int(M%p)]
        result %= p
        N /= p
        M /= p
    }
    return result
}

combo = Array(repeating: Array(repeating: 0, count: 1032), count: 1032)
combo[0][0] = 1
for i in 1...1031 {
    combo[i][0] = 1
    for j in 1...i {
        combo[i][j] = (combo[i-1][j-1] + combo[i-1][j])%100007
    }
}
let nsB = 97*Euclid(a: 97, b: 1031)
let nsA = 1031*Euclid(a: 1031, b: 97)
let t = Int(readLine()!)!
for _ in 0..<t {
    let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n = nm[0], m = nm[1]
    if n < m-1 {
        print(0)
    }
    else if n == 0 {
        if m == 1 {
            print(1)
        }
        else {
            print(0)
        }
    }
    else if m == 1 {
        print(0)
    }
    else {
        let A = lucas(n: n-1, m: m-2, p: 97)
        let B = lucas(n: n-1, m: m-2, p: 1031)
        let result = (A*nsA + B*nsB)%100007
        print(result)
    }
}
