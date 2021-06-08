let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1]
var edgeF:[[Int]] = Array(repeating: [], count: n+1)
var edgeB:[[Int]] = Array(repeating: [], count: n+1)
var check:[Bool] = Array(repeating: false, count: n+1)
var ft:[Int] = Array(repeating: 0, count: n+1)
var index = 1

var SCC:[Int] = Array(repeating: 0, count: n+1)
var SCCTotalCash:[Int] = Array(repeating: 0, count: n+1)
var SCCRestExist:[Bool] = Array(repeating: false, count: n+1)
var SCCEdge:[Set<Int>] = Array(repeating: [], count: n+1)
var SCCDP:[Int] = Array(repeating: -1, count: n+1)
var sNum = 0
var atm:[Int] = Array(repeating: 0, count: n+1)
var rest:[Bool] = Array(repeating: false, count: n+1)
for _ in 0..<m {
    let road = readLine()!.split(separator: " ").map{Int(String($0))!}
    let A = road[0], B = road[1]
    edgeF[A].append(B)
    edgeB[B].append(A)
}
for i in 1...n {
    atm[i] = Int(String(readLine()!))!
}
let SP = readLine()!.split(separator: " ").map{Int(String($0))!}
let Restaurant = readLine()!.split(separator: " ").map{Int(String($0))!}
for i in Restaurant {
    rest[i] = true
}
for i in 1...n {
    if !check[i] {
        dfsF(n: i)
    }
}
for i in 1...n {
    let node = ft[n+1-i]
    if SCC[node] == 0 {
        sNum += 1
        dfsB(n: node, sNum: sNum)
    }
}
print(dfsSCC(n: SCC[SP[0]]))

func dfsF(n: Int) {
    check[n] = true
    for e in edgeF[n] {
        if !check[e] {
            dfsF(n: e)
        }
    }
    ft[index] = n
    index += 1
}

func dfsB(n: Int, sNum: Int) {
    SCC[n] = sNum
    SCCTotalCash[sNum] += atm[n]
    if rest[n] {
        SCCRestExist[sNum] = true
    }
    for e in edgeB[n] {
        if SCC[e] == 0 {
            dfsB(n: e, sNum: sNum)
        }
        else if SCC[e] != sNum {
            SCCEdge[SCC[e]].insert(sNum)
        }
    }
}

func dfsSCC(n: Int) -> Int {
    if SCCDP[n] != -1 {
        return SCCDP[n]
    }
    else {
        var tmp = 0
        for e in SCCEdge[n] {
            tmp = max(tmp, dfsSCC(n: e))
        }
        if tmp != 0 || SCCRestExist[n] {
            tmp += SCCTotalCash[n]
        }
        SCCDP[n] = tmp
        return tmp
    }
}
