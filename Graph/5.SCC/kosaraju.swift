var edgeF:[[Int]] = []
var edgeB:[[Int]] = []
var check:[Bool] = []
var ft:[Int] = []
var index = 0, scc = 0
var SCC:[Int] = []

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

func dfsB(n: Int, scc: Int) {
    SCC[n] = scc
    for e in edgeB[n] {
        if SCC[e] == 0 {
            dfsB(n: e, scc: scc)
        }
    }
}

for i in 0..<n {
    if !check[i] {
        dfsF(n: i)
    }
}

for i in 0..<n {
    let node = ft[n-1-i]
    if SCC[node] == 0 {
        scc += 1
        dfsB(n: node, scc: scc)
    }
}
