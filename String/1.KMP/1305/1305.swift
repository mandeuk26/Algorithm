func makepi(str: [Character]) -> Int {
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
    return pi.last!
}

let L = Int(readLine()!)!
let S = readLine()!.map{Character(String($0))}
let last = makepi(str: S)
print(L-last)

