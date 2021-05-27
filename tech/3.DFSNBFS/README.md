# DFS & BFS
DFS & BFS는 그래프 파트에 있어야 할 것 같지만 DP문제에도 활용되고 다양한 분야에 섞여서 많이 쓰이는 개념이기 때문에 미리 다루었다.
## 1. DFS (Depth First Search)
그래프 상에서 가장 깊은 지점까지 탐색한 후 분기점까지 돌아와 다른 경로를 마찬가지로 탐색하는 방식. 이미 방문한 노드에 대해서는 check함수를 이용해 다시 방문하지 않도록하여 무한루프를 돌지 않도록 한다. 주로 스택을 이용해서 구현을 하거나 재귀함수 호출을 이용하여 구현을 한다.  
다음과 같은 그래프가 있다고 하자.  

<img width="313" alt="BFSDFSgraph" src="https://user-images.githubusercontent.com/78075226/119501853-3667f180-bda4-11eb-9911-59d3a7926b30.png">

```
1. B -> D -> E 순으로 들어갈 수 있는 최대한의 깊이까지 탐색을 한다.
2. 이때 E에서는 다른 곳으로 갈수가 없으므로 D로 돌아간다. 
3. 마찬가지로 D에서도 E 이외의 다른 경로가 없기 때문에 B로 돌아가고 B에서도 A로 돌아간다.
4. A에서 다시 다른 경로인 D를 확인한다. 이 때 D는 이미 방문을 했으므로 넘어간다.
5. C이라는 경로로 이동 후 C에서 E를 바라보지만 E는 이미 방문을 했으므로 A로 돌아간 후 실행이 종료된다.
```
```swift
func dfs(n: Int) {
    check[n] = true
    str += "\(n) "
    for e in edge[n] {
        if !check[e] {
            dfs(n: e)
        }
    }
}
```
## 2. BFS (Breadth First Search)
DFS와는 다르게 이번에는 큐라는 구조체를 이용할 것이다.  
DFS와 같은 그래프를 보도록 하자.
```
1. 시작 노드를 먼저 큐에 집어넣는다.
2. 큐에 가장 앞에 있는 노드를 pop해주고 해당 노드와 연결된 방문하지않은 모든 노드들을 큐에 집어넣는다.
3. 큐가 빌때까지 2를 반복한다.
```
이렇게 구현을 하면 DFS에서는 “A B D E C” 의 순서로 방문했던것과는 다르게 “A B C D E” 로 방문한다는 것을 확인할 수 있다. 
```swift
func bfs(n: Int) -> String {
    var queue = [Int]()
    var result = ""
    queue.append(n)
    check[n] = true
    while !queue.isEmpty {
        let curr = queue.removeFirst()
        result += "\(curr) "
        for e in edge[curr] {
            if !check[e] {
                queue.append(e)
                check[e] = true
            }
        }
    }
    return result
}
```
