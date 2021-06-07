/*
 fread 코드는 JCSooHwanCho님의 FileIO.swift 를 참조하였습니다.
 <출처 : https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88>
*/
import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}

let fIO = FileIO()
let n = fIO.readInt()
let INF = 1_000_000_007
let s = 501, e = 502
var level:[Int] = Array(repeating: -1, count: 555)
var edge:[[Int]] = Array(repeating: [], count: 555)
var c:[[Int]] = Array(repeating: Array(repeating: 0, count: 555), count: 555)
var f:[[Int]] = Array(repeating: Array(repeating: 0, count: 555), count: 555)
var work:[Int] = Array(repeating: 0, count: 555)

func addEdge(s: Int, e: Int, val: Int) {
    edge[s].append(e)
    edge[e].append(s)
    c[s][e] += val
}

func bfs() -> Bool {
    level = Array(repeating: -1, count: 555)
    var q = [Int]()
    level[s] = 1
    q.append(s)
    while !q.isEmpty {
        let curr = q.removeFirst()
        for i in edge[curr] {
            if level[i] == -1 && c[curr][i] - f[curr][i] > 0 {
                level[i] = level[curr] + 1
                q.append(i)
            }
        }
    }
    return level[e] != -1
}

func dfs(curr: Int, flow: Int) -> Int {
    if curr == e {
        return flow
    }
    let nextVertex = work[curr]
    for i in nextVertex..<edge[curr].count {
        let next = edge[curr][i]
        if level[next] == level[curr] + 1 && c[curr][next] - f[curr][next] > 0 {
            let tmp = dfs(curr: next, flow: min(flow, c[curr][next] - f[curr][next]))
            if tmp > 0 {
                f[curr][next] += tmp
                f[next][curr] -= tmp
                return tmp
            }
        }
        work[curr] += 1
    }
    return 0
}

func dinic() -> Int {
    var totalFlow = 0
    while bfs() {
        work = Array(repeating: 0, count: 555)
        while true {
            let tmpflow  = dfs(curr: s, flow: INF)
            if tmpflow == 0 {
                break
            }
            totalFlow += tmpflow
        }
    }
    return totalFlow
}

for i in 1...n {
    let v = fIO.readInt()
    if v == 1 {
        addEdge(s: s, e: i, val: INF)
    }
    else if v == 2 {
        addEdge(s: i, e: e, val: INF)
    }
}
for i in 1...n {
    for j in 1...n {
        let w = fIO.readInt()
        if i == j {
            continue
        }
        addEdge(s: i, e: j, val: w)
    }
}

print(dinic())
var a = "", b = ""
for i in 1...n {
    if level[i] != -1 {
        a += "\(i) "
    }
    else {
        b += "\(i) "
    }
}
print(a)
print(b)

