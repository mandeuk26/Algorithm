func compare(g: [Int], a: Int, b: Int, t: Int) -> Bool {
    if g[a] == g[b] {
        return g[a+t] < g[b+t]
    }
    else {
        return g[a] < g[b]
    }
}

func suffix(str: [Character]) -> [Int] {
    let n = str.count
    var g = Array(repeating: -1, count: n+1)
    var ng = Array(repeating: -1, count: n+1)
    var sfx = Array(repeating: -1, count: n)
    var t = 1
    
    for i in 0..<n {
        g[i] = Int(str[i].asciiValue!-96)
        sfx[i] = i
    }
    while t < n {
        sfx.sort(by: {compare(g: g, a: $0, b: $1, t: t)})
        ng[sfx[0]] = 0
        for i in 1..<n {
            if compare(g: g, a: sfx[i-1], b: sfx[i], t: t) {
                ng[sfx[i]] = ng[sfx[i-1]] + 1
            }
            else {
                ng[sfx[i]] = ng[sfx[i-1]]
            }
        }
        g = ng
        t <<= 1
    }
    return sfx
}

func LCP(str: [Character], SA: [Int]) -> [Int] {
    let n = str.count
    var strArr = str
    strArr.append("#")
    var lcp = Array(repeating: 0, count: n)
    var rank = Array(repeating: 0, count: n)
    for i in 0..<n {
        rank[SA[i]] = i
    }
    
    var len = 0
    for i in 0..<n {
        let k = rank[i]
        if k > 0 {
            while strArr[SA[k-1]+len] == strArr[i+len] {
                len += 1
            }
            lcp[k] = len
            if len > 0 {
                len -= 1
            }
        }
    }
    return lcp
}

readLine()
let line = readLine()!.map{Character(String($0))}
let sa = suffix(str: line)
let lcp = LCP(str: line, SA: sa)
print(lcp.max()!)
