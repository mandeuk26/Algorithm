# 백준 1774 우주신과의 교감
정점들의 좌표가 주어지고 이미 연결된 정점들의 번호가 주어졌을 때 MST를 구성하기 위해 추가적으로 이어야하는 간선의 최단 비용을 찾으면 된다.  
MST를 구하는 방법에는 여러가지가 있으나 여기서는 크루스칼을 사용하였다.  
크루스칼의 경우 같은 집합에 속한다면 edge연결을 하지 않는다.  
따라서 이미 통로가 연결되어 있는 정점들 간에는 disjoint set에서 하나의 집합으로 union해주었다.  
또한 edge를 설정할 때 모든 정점간에 하는 것이 아닌 같은 집합에 속해있지 않은 경우에만 edge를 생성해주어 시간을 단축했다.  
- Edge 설정 코드
```swift
for i in 1..<n+1 {
    for j in i+1..<n+1 {
    //i -> j 나 j -> i는 같은 간선이기 때문에 한번만 추가하도록 했다.
        if disjoint.findRoot(i) == disjoint.findRoot(j) {continue}
        let dx = node[i].0 - node[j].0
        let dy = node[i].1 - node[j].1
        let dist = sqrt(dx*dx + dy*dy)
        edge.append((i, j, dist))
    }
}
```
그 외에는 크루스칼 알고리즘과 동일하다.  
문제에서 요구하는 출력 형식에 맞게 출력하는 것 잊지말자.  
