let n = Int(readLine()!)!
var shark:[(Int, Int, Int)] = []
var visited:[Bool] = Array(repeating: false, count: n)
var eater:[Int] = Array(repeating: -1, count: n)
for _ in 0..<n {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    shark.append((line[0], line[1], line[2]))
}

func dfs(idx: Int) -> Bool {
    for i in 0..<n where i != idx {
        if visited[i] {
            continue
        }
        if shark[i].0 <= shark[idx].0 && shark[i].1 <= shark[idx].1 && shark[i].2 <= shark[idx].2 {
            if shark[i] == shark[idx] && idx >= i {
                continue
            }
            visited[i] = true
            if eater[i] == -1 || dfs(idx: eater[i]) {
                eater[i] = idx
                return true
            }
        }
    }
    return false
}

var result = 0
for i in 0..<n {
    visited = Array(repeating: false, count: n)
    if dfs(idx: i) {
        result += 1
    }
    visited = Array(repeating: false, count: n)
    if dfs(idx: i) {
        result += 1
    }
}
print(n-result)
