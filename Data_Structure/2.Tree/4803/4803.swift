var caseCount = 0
while let i = readLine() {
    caseCount += 1
    let nm = i.split(separator: " ").map{Int(String($0))!}
    let n = nm[0], m = nm[1]
    if n == 0 && m == 0 {break}
    var edge:[[Int]] = Array(repeating: [], count: n+1)
    for _ in 0..<m {
        let line = readLine()!.split(separator: " ").map{Int(String($0))!}
        edge[line[0]].append(line[1])
        edge[line[1]].append(line[0])
    }
    
    var visited = Array(repeating: false, count: n+1)
    func dfs(_ current: Int, _ before: Int) -> Bool {
        visited[current] = true
        for next in edge[current] where next != before {
            if visited[next] {
                return false
            }
            else if !dfs(next, current) {
                return false
            }
        }
        return true
    }
    
    var result = 0
    for i in 1...n {
        if !visited[i] {
            if dfs(i, 0) {
                result += 1
            }
        }
    }
    switch result {
    case 0:
        print("Case \(caseCount): No trees.")
    case 1:
        print("Case \(caseCount): There is one tree.")
    default:
        print("Case \(caseCount): A forest of \(result) trees.")
    }
}

