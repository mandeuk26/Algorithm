let nk = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nk[0], k = nk[1]
var row2col:[Int] = Array(repeating: -1, count: n+1)
var edge:[[Int]] = Array(repeating: [], count: n+1)
var visited:[Bool] = Array(repeating: false, count: n+1)
for _ in 0..<k {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    edge[line[0]].append(line[1])
}
func dfs(col: Int) -> Bool {
    for row in edge[col] {
        if visited[row] {
            continue
        }
        visited[row] = true
        if row2col[row] == -1 || dfs(col: row2col[row]) {
            row2col[row] = col
            return true
        }
    }
    return false
}
var r = 0
for i in 1...n {
    visited = Array(repeating: false, count: n+1)
    if dfs(col: i) {
        r += 1
    }
}
print(r)

