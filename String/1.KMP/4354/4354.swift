func makepi(str: [Character]) -> [Int] {
    var j = 0
    var pi = Array(repeating: 0, count: str.count)
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

while let line = readLine() {
    if line == "." {
        break
    }
    let S = line.map{Character(String($0))}
    let pi = makepi(str: S)
    let last = pi.last!
    let length = S.count - last
    if last == 0 || (S.count-length)%length != 0{
        print(1)
    }
    else {
        print(S.count / length)
    }
}

