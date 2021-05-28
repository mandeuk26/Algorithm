import Foundation

let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1], sqrtN = Int(sqrt(Double(n)))
let A = [0] + readLine()!.split(separator: " ").map{Int(String($0))!}
var query = Array(repeating: (0, 0, 0), count: m)
var qResult = Array(repeating: 0, count: m)
var count = Array(repeating: 0, count: 1000001)
for i in 0..<m {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    query[i] = (line[0], line[1], i)
}
query.sort(by: {$0.1 < $1.1})
query.sort(by: {$0.0/sqrtN < $1.0/sqrtN})

func plus(s: Int, e: Int, r: inout Int) {
    for i in s...e {
        r += A[i]*(2*count[A[i]]+1)
        count[A[i]] += 1
    }
}

func minus(s: Int, e: Int, r: inout Int) {
    for i in s...e {
        r += A[i]*(1-2*count[A[i]])
        count[A[i]] -= 1
    }
}

var result = 0, ps = query[0].0, pe = query[0].1
plus(s: ps, e: pe, r: &result)
qResult[query[0].2] = result
for i in 1..<m {
    let curr = query[i]
    if ps < curr.0 {
        minus(s: ps, e: curr.0-1, r: &result)
    }
    else if ps > curr.0 {
        plus(s: curr.0, e: ps-1, r: &result)
    }
    if pe < curr.1 {
        plus(s: pe+1, e: curr.1, r: &result)
    }
    else if pe > curr.1 {
        minus(s: curr.1+1, e: pe, r: &result)
    }
    ps = curr.0
    pe = curr.1
    qResult[curr.2] = result
}

var str = ""
for i in 0..<m {
    str += "\(qResult[i])\n"
}
print(str)

