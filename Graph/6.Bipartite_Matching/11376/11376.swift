let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1]
var work:[[Int]] = []
var visited:[Bool] = Array(repeating: false, count: m+1)
var work2Worker:[Int] = Array(repeating: -1, count: m+1)
var maxWork = 0

func dfs(worker: Int) -> Bool {
    let workCount = work[worker][0]
    for i in 1..<workCount+1 {
        let currWork = work[worker][i]
        if visited[currWork] {
            continue
        }
        visited[currWork] = true
        if work2Worker[currWork] == -1 || dfs(worker: work2Worker[currWork]) {
            work2Worker[currWork] = worker
            return true
        }
    }
    return false
}

for i in 0..<n {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    work.append(line)
    work.append(line)
    visited = Array(repeating: false, count: m+1)
    if dfs(worker: 2*i) {
        maxWork += 1
    }
    visited = Array(repeating: false, count: m+1)
    if dfs(worker: 2*i+1) {
        maxWork += 1
    }
}
print(maxWork)
