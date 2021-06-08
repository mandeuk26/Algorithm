let INF = 1_000_000_007

struct MCMF {
    struct Edge {
        var to:Int
        var rev:Int
        var cap:Int
        var cst:Int
    }
    var edge:[[Edge]]
    var parent:[(Int, Int)]
    var n:Int
    var src:Int
    var snk:Int
    init(n: Int, src: Int, snk: Int) {
        self.n = n
        self.src = src
        self.snk = snk
        edge = Array(repeating: [], count: n+5)
        parent = Array(repeating: (-1, -1), count: n+5)
    }
    
    mutating func addEdge(a: Int, b: Int, capa: Int, cost: Int) {
        edge[a].append(Edge(to: b, rev: edge[b].count, cap: capa, cst: cost))
        edge[b].append(Edge(to: a, rev: edge[a].count-1, cap: 0, cst: -cost))
    }
    
    mutating func SPFA() -> Bool {
        var inq = Array(repeating: false, count: n+5)
        var dst = Array(repeating: INF, count: n+5)
        var q = [Int]()
        q.append(src)
        dst[src] = 0
        inq[src] = true
        while !q.isEmpty {
            let curr = q.removeFirst()
            inq[curr] = false
            for i in 0..<edge[curr].count {
                let currEdge = edge[curr][i]
                if currEdge.cap <= 0 {
                    continue
                }
                if dst[curr] < INF && dst[currEdge.to] > dst[curr] + currEdge.cst {
                    dst[currEdge.to] = dst[curr] + currEdge.cst
                    parent[currEdge.to] = (curr, i)
                    if !inq[currEdge.to] {
                        inq[currEdge.to] = true
                        q.append(currEdge.to)
                    }
                }
            }
        }
        return dst[snk] != INF
    }
    
    mutating func flow() -> (Int, Int) {
        var totalFlow = 0, money = 0
        while SPFA() {
            var minFlow = INF, cost = 0, idx = snk
            while idx != src {
                let prevEdge = edge[parent[idx].0][parent[idx].1]
                minFlow = min(minFlow, prevEdge.cap)
                cost += prevEdge.cst
                idx = parent[idx].0
            }
            totalFlow += minFlow
            money += cost*minFlow
            idx = snk
            while idx != src {
                let prevEdge = edge[parent[idx].0][parent[idx].1]
                edge[parent[idx].0][parent[idx].1].cap -= minFlow
                edge[idx][prevEdge.rev].cap += minFlow
                idx = parent[idx].0
            }
        }
        return (totalFlow, money)
    }
}

let t = Int(readLine()!)!
var str = ""
for _ in 0..<t {
    let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
    let N = nm[0], M = nm[1]
    var mcmf = MCMF(n: N, src: N+1, snk: N+2)
    for _ in 0..<M {
        let line = readLine()!.split(separator: " ").map{Int(String($0))!}
        mcmf.addEdge(a: line[0], b: line[1], capa: INF, cost: 1)
        mcmf.addEdge(a: line[1], b: line[0], capa: INF, cost: 1)
    }
    let node = readLine()!.split(separator: " ").map{Int(String($0))!}
    let coin = readLine()!.split(separator: " ").map{Int(String($0))!}
    for i in 0..<N {
        if node[i] != coin[i] {
            if coin[i] == 0 {
                mcmf.addEdge(a: mcmf.src, b: i+1, capa: 1, cost: 0)
            }
            else {
                mcmf.addEdge(a: i+1, b: mcmf.snk, capa: 1, cost: 0)
            }
        }
    }
    str += "\(mcmf.flow().1)\n"
    
}
print(str)

