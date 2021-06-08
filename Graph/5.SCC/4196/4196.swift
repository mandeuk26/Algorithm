var edgeF:[[Int]] = []
var edgeB:[[Int]] = []
var check:[Bool] = []
var SCC:[Int] = []
var indegree:[Int] = []
var ft:[Int] = []
var index = 1

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
        else if SCC[e] != SCC[n] {
            indegree[scc] += 1
        }
    }
}

let t = Int(readLine()!)!
for _ in 0..<t {
    let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n = nm[0], m = nm[1]
    var scc = 0, result = 0
    edgeF = Array(repeating: [], count: n+1)
    edgeB = Array(repeating: [], count: n+1)
    check = Array(repeating: false, count: n+1)
    SCC = Array(repeating: 0, count: n+1)
    indegree = Array(repeating: 0, count: n+1)
    ft = Array(repeating: 0, count: n+1)
    index = 1
    for _ in 0..<m {
        let line = readLine()!.split(separator: " ").map{Int(String($0))!}
        let N1 = line[0], N2 = line[1]
        edgeF[N1].append(N2)
        edgeB[N2].append(N1)
    }
    
    for i in 1...n {
        if !check[i] {
            dfsF(n: i)
        }
    }
    for i in 1...n {
        let node = ft[n+1-i]
        if SCC[node] == 0 {
            scc += 1
            dfsB(n: node, scc: scc)
        }
    }

    for i in 1...scc {
        if indegree[i] == 0 {
            result += 1
        }
    }
    print(result)
}

