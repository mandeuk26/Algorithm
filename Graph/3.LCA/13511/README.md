# 백준 13511 트리와 쿼리 2
n개의 정점으로 이루어진 트리가 주어지면 각 간선에 이동하는 비용이 적혀있다고 하자.  
이 때 u에서 v 정점으로 가는 비용 혹은 u에서 v로가는 경로의 k번째 정점을 출력하는 문제이다.  
트리상에서 u에서 v로 이동하는 최단 경로는 lca를 거쳐 가는 경로이다.  
따라서 우리는 lca알고리즘을 활용해야 함을 알 수 있다.  
  
먼저 cost의 경우 root부터 각 정점까지 이동 비용을 dfs하면서 저장시켜둔다.  
그 후 u에서 v로 이동하는 cost는 root -> u까지의 cost와 root -> v 로의 cost를 합친 뒤 root -> lca(u, v) 로의 cost를 2배해서 빼준 것과 같다.  
직접 그래프를 그려보면 쉽게 알 수 있다.  
`cost(u, v) = cost(root, u) + cost(root, v) - 2*cost(root, lca(u, v))`  
  
자 그러면 k 번째 경로에 대해서 알아내야 할 것이다.  
cost와 마찬가지로 u, v간의 lca값을 먼저 알아내야 할 것이다.  
u -> lca(u, v) 까지의 최대 이동 횟수는 lca가 u의 부모이기 때문에 depth 차이만큼 이동한다는 것을 알 수 있다.  
따라서 lca에서부터 두 정점까지의 depth차이를 구해주고 k번째에 해당하는 위치를 찾아주면 된다.  
그런데 일일히 경로를 따라가면서 k번째 위치를 찾는 행위는 최대 *O(n)* 이 걸리게된다.  
- LCAPath Function
```swift
func LCAPath(x: Int, y: Int, z: Int) -> Int {
    let lca = LCA(x: x, y: y)
    let leftdist = depth[x] - depth[lca]
    let rightdist = depth[y] - depth[lca]
    var k = z - 1
    if k > leftdist {
    // lca에서 y로의 경로에 위치시
        k = leftdist + rightdist + 1 - z
        var index = y
        var i = 0
        while k != 0 {
            if k&1 != 0 {
            //비트마스크를 활용해 해당 영역을 찾아간다, logn으로 시간 단축!
                index = parent[index][i]
            }
            k = k >> 1
            i += 1
        }
        return index
    }
    else {
    // lca에서 x로의 경로에 위치시
        var index = x
        var i = 0
        while k != 0 {
            if k&1 != 0 {
                index = parent[index][i]
            }
            k = k >> 1
            i += 1
        }
        return index
    }
}
```
코드를 보면 알 수 있듯이 먼저 leftDist와 rightDist를 k와 비교해 k번째 정점이 lca부터 u로의 경로에 위치할 것인지 lca부터 v로의 경로에 위치할 것인지를 찾아준다.  
찾았다면 해당 영역 u 혹은 v 정점으로부터 부모를 거슬러올라가면서 경로를 찾아주면 된다.  
