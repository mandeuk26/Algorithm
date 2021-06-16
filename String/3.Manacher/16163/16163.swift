func manacher(str: [Character]) -> [Int] {
    let n = str.count
    var r = -1, p = -1
    var A = Array(repeating: 0, count: n)
    for i in 0..<n {
        if i <= r {
            A[i] = min(A[2*p-i], r-i)
        }
        while i-A[i]-1 >= 0 && i+A[i]+1 < n && str[i-A[i]-1] == str[i+A[i]+1] {
            A[i] += 1
        }
        if i+A[i] > r {
            r = i+A[i]
            p = i
        }
    }
    return A
}

let line = readLine()!
var str = [Character]()
str.append("#")
for c in line {
    str.append(c)
    str.append("#")
}
let pe = manacher(str: str)
var result = 0
for i in 0..<pe.count {
    if i%2 == 0 {
        result += pe[i]/2
    }
    else {
        result += (pe[i]+1)/2
    }
}
print(pe)
print(result)

