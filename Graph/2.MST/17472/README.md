# 백준 17472 다리 만들기 2
NxM의 격자가 주어지고 격자 위에 섬에 해당하는 부분은 1로 표시가 된다.  
이어져 있는 땅 끼리는 하나의 섬이 된다고 했을 때 섬들 간에 다리를 연결해서 모든 섬을 이르려고 한다.  
이 때 다리는 가로 또는 세로 한쪽 방향으로만 지을 수 있고 길이는 최소 2 이상이여야 한다.  
다리간에 교차는 가능하다고 했을 때 모든 섬을 잇는 다리를 짓는 최소 비용을 구하는 문제이다.  

먼저 섬들을 분리해서 각각의 섬에 번호를 매겨줘야하기 때문에 DFS나 BFS를 사용해서 전체 격자를 탐색해야함을 알 수 있다.  
이 때 각각의 섬의 번호를 1번부터 다르게 매겨주었다.  
- Island Number DFS Code
```swift
var islandCount = 1
for i in 0..<n {
    for j in 0..<m {
        if island[i][j] == 1 && !check[i][j] {
            dfs(x: j, y: i, islandNum: islandCount)
            islandCount += 1
        }
    }
}
islandCount -= 1
```
이제 각 섬마다 다리를 연결하기 위해서 섬 사이의 간선을 설정해주어야 할 것이다.  
이를 어떻게 할까 고민을 해보면 각 섬마다 섬의 내륙이 아닌 바다와 연결된 땅에 대해서 바다쪽으로 쭉 나아갔을 때 다른 섬이 등장하면 두 섬간에는 다리를 지을 수 있다고 판단할 수 있다.  
이를 그대로 알고리즘에 적용해서 모든 섬의 땅에 대해서 상하좌우로 뻗어나갈 수 있는 만큼 뻗어서 다른 섬을 만난다면 두 섬간에 다리를 지을 수 있다고 판단하고 edge 연결을 해주는 식으로 구현했다.  
- Bridge Add Code
```swift
if nextX < 0 || nextX >= m || nextY < 0 || nextY >= n {
    return
}
else {
    let next = island[nextY][nextX]
    if next == 0 {
        bridgeAdd(x: x, y: y, count: count+1, direction: direction)
    }
    else if next != island[y][x] && count > 2 {
        node.append((n: island[y][x], m: next, d: count-1))
    }
}
```
해당 함수 내부를 보면 count라는 것이 사용되는데 해당 방향으로 얼마만큼 떨어진 땅을 봤는지를 나타내주는 역할을 한다.  
따라서 새로운 땅을 만났을 때 거리가 2 이상이 되는지를 확인해 조건에 부합하다면 배열에 추가시켜준다.  

간선을 모두 설정했다면 크루스칼 알고리즘으로 MST를 찾아주면 된다.  
edge를 설정하는 부분이 어려운 문제였지만 그 외에는 기본 알고리즘을 사용해주면 된다.  
