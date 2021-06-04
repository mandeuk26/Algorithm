# LCA (Lowest Common Ancestor)
최소 공통 조상으로 두 정점의 가장 가까운 공통 조상을 찾는 알고리즘을 말한다.  
다음 그림을 보면 6과 8의 LCA는 2고 9와 10의 LCA는 1이다.  

<img width="849" alt="lca2" src="https://user-images.githubusercontent.com/78075226/120491248-0c41af80-c3f4-11eb-9c2c-b6a451385647.png">

만약 두 정점이 존재한다면 둘의 depth를 동일하게 맞춰주고 하나씩 부모로 거슬러 올라가면서 둘의 부모가 같은 지점을 찾아주면 될 것이다.  
하지만 이렇게 구현을 할 경우 최대 *O(n)* 의 시간이 걸리게 된다.  
이 시간을 단축하기 위해 우리는 각각의 노드별로 부모가 누군지를 저장할 것인데 이 때 2<sup>0</sup>번째 부모, 2<sup>1</sup>번째 부모, 2<sup>2</sup>번째 부모, 2<sup>3</sup>번째 부모 이런식으로 2의 제곱수에 해당하는 위치의 부모에 대해서 저장할 것이다.  
이렇게 해주는 이유는 이분탐색과 비슷하게 동작하도록 위함이다.  
구현하는 방법은 어떤 노드의 2<sup>n</sup> 부모는 그 노드의 1번째 부모의 2<sup>n-1</sup>와 같다는 것을 이용한다.
- DFS를 이용해 parent 정보를 포함한 tree 만들기
```swift
func dfs(n: Int, p: Int) {
    depth[n] = depth[p] + 1
    check[n] = true
    parent[n][0] = p
    for i in 1...maxK {
        parent[n][i] = parent[parent[n][i-1]][i-1]
    }
    //이 부분이 parent에 대해 저장하는 부분이다.
    for e in edge[n] {
        if !check[e] {
            dfs(n: e, p: n)
        }
    }
}
```
이제 부모의 정보가 저장되어 있다고 했을 때 두 정점의 LCA를 구하고자 한다.  
이 때 먼저 depth가 큰 노드를 작은 노드에 맞춰 부모로 이동시킬 것인데 만약 두 노드의 depth 차이가 7이라면 4번째 부모로 이동 -> 2번째 부모로 이동 -> 1번째 부모로 이동 하는 방식을 택하면 depth를 동일하게 맞출 수 있다. 
- Depth 동일화 code
```swift
for i in 0...maxK {
    if depth[a] <= depth[parent[b][maxK-i]] {
        b = parent[b][maxK-i]
    }
}
```
그 후 두 노드가 동일하다면 한쪽이 다른쪽의 부모가 되는 경우로 해당 노드를 return해주면 된다.  
그렇지 않을 경우 2의 제곱수에 해당하는 부모들을 제곱수가 큰 부모부터 하나씩 비교해가면서 두 개의 부모가 다르다면 해당 위치로 노드를 옮겨가면서 계속 비교하는 방식을 사용한다.  
최종적으로 변경된 노드의 위치는 LCA의 child node에 해당하기 때문에 첫번째 부모를 return 해주면 된다.
- 부모 노드 비교 code
```swift
if a == b {
    return a
}
for i in 0...maxK {
    if parent[a][maxK-i] != parent[b][maxK-i] {
        a = parent[a][maxK-i]
        b = parent[b][maxK-i]
    }
}
return parent[a][0]
```
@3176, 13511 정리
