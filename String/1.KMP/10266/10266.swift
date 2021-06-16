func makepi(str: [Int]) -> [Int] {
    var pi = Array(repeating: 0, count: str.count)
    var j = 0
    for i in 1..<str.count {
        while j > 0 && str[i] != str[j] {
            j = pi[j-1]
        }
        if str[i] == str[j] {
            j += 1
            pi[i] = j
        }
    }
    return pi
}

func makeDiff(str: [Int]) -> [Int] {
    var arr = [Int]()
    for i in 0..<str.count-1 {
        arr.append(str[i+1]-str[i])
    }
    arr.append(360000-str.last!+str[0])
    return arr
}

let n = Int(readLine()!)!
let S = makeDiff(str: readLine()!.split(separator: " ").map{Int(String($0))!}.sorted())
let S1 = S + S
let S2 = makeDiff(str: readLine()!.split(separator: " ").map{Int(String($0))!}.sorted())
let pi = makepi(str: S2)
var i = 0
var j = 0
var result = false
while i+j < S1.count && i < S2.count {
    let curr = i+j
    while j > 0 && S1[curr] != S2[j] {
        j = pi[j-1]
        i = curr - j
    }
    if S1[curr] == S2[j] {
        j += 1
        if j == S2.count {
            result = true
            break
        }
    }
    else {
        i += 1
    }
}
print(result ? "possible" : "impossible")
