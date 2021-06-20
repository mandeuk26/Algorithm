let alist:[UInt64] = [2, 7, 61]
func powmod(x: UInt64, y: UInt64, m:UInt64) -> UInt64 {
    var X = x%m
    var iter = y
    var result:UInt64 = 1
    while iter != 0 {
        if iter%2 == 1 {
            result = (result*X)%m
        }
        X = (X*X)%m
        iter /= 2
    }
    return result
}

func miller(n: UInt64, a: UInt64) -> Bool {
    var d = n-1
    while d%2 == 0 {
        if powmod(x: a, y: d, m: n) == n-1 {
            return true
        }
        d /= 2
    }
    let tmp = powmod(x: a, y: d, m: n)
    return tmp == n-1 || tmp == 1
}

func isPrime(n: UInt64) -> Bool {
    if n <= 1 {
        return false
    }
    for a in alist {
        if !miller(n: n, a: a) {
            return false
        }
    }
    return true
}

let t = Int(readLine()!)!
var result = 0
for _ in 0..<t {
    let k = UInt64(readLine()!)!
    let C = 2*k+1
    if C == 2 || C == 7 || C == 61 {
        result += 1
    }
    else if isPrime(n: 2*k+1) {
        result += 1
    }
}
print(result)

