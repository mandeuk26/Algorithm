# 백준 4803 트리
정점의 갯수와 간선의 갯수가 주어지고 간선의 정보가 이어서 주어진다고 하자. 이 때 해당 그래프에서 트리의 갯수가 몇개인지 세는 문제이다. 트리의 조건은 사이클이 없고 임의의 두 정점에 대해서 경로가 유일하다는 특징을 갖고있다. 이를 활용하여 문제를 풀 것이다.  
트리는 어떤 점을 루트로 잡아도 트리의 형태를 유지한다는 것은 알고있을 것이다. 그렇다면 임의의 한 점을 대상으로 dfs를 돌리면 트리의 모든 정점을 방문할 수 있게 된다. 트리에는 사이클이 없기 때문에 부모로부터 자식으로 내려온 간선을 제외시켜가며 dfs를 돌리면 이미 방문한 노드를 방문할 일이 없다. 만약 dfs과정에서 이미 방문한 노드를 방문한다면 그것은 사이클이 존재한다는 소리고 트리가 아니게 된다.  
- DFS Function
```swift
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
```
따라서 visited 배열을 활용하여 사이클이 발생하는지 확인해주도록 하자. for문을 보면 알겠지만 dfs 입력으로 before (부모 정점)을 받아서 부모 정점으로의 간선은 제외시키고 dfs를 반복적으로 계산했다.
