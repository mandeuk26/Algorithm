let n = Int(readLine()!)!
var edge:[[(Int, Int)]] = Array(repeating: [], count: n+1)
for i in 1...n {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    var index = 1
    while index != line.count-1 {
        edge[line[0]].append((line[index], line[index+1]))
        edge[line[index]].append((line[0], line[index+1]))
        index += 2
    }
}
func dfs(s: Int, d: Int) {
    if visited[s] {
        return
    }
    if d > maximum {
        maximum = d
        maxIndex = s
    }
    visited[s] = true
    for i in edge[s] {
        dfs(s: i.0, d: d+i.1)
    }
}
var visited = Array(repeating: false, count: n+1)
var maximum = 0
var maxIndex = 1
dfs(s:1, d:0)

visited = Array(repeating: false, count: n+1)
maximum = 0
dfs(s:maxIndex, d:0)
print(maximum)

