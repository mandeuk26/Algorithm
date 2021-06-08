# 백준 3176 도로 네트워크
n개의 정점들로 이루어진 트리가 주어질 때 정점 쌍이 주어지면 두 정점을 연결하는 경로에서 가장 짧은 도로와 긴 도로의 길이를 출력하는 문제이다.  
얼핏보면 세그먼트를 써야할 것도 같고 하지만 lca를 활용하는 문제이다.  
먼저 lca에서 그동안은 공통 조상이 무엇인지 알아내는 문제를 주로 풀었다.  
그런데 부모 정보 뿐만 아니라 값을 저장시켜 세그먼트 트리처럼 트리의 주어진 구간에서 원하는 값을 얻어낼 수도 있다.  
```swift
var parent:[[(n:Int, minc: Int, maxc: Int)]] = []
```
만약 parent 배열을 위 처럼 정의한다고 하자. min cost와 max cost가 함께 정의된 형태이다.  
```swift
func dfs(n: (Int, Int), p: Int) {
    depth[n.0] = depth[p] + 1
    check[n.0] = true
    parent[n.0][0] = (n: p, minc: n.1, maxc: n.1)
    for i in 1...maxK {
        let midParent = parent[n.0][i-1]
        let finalParent = parent[midParent.n][i-1]
        parent[n.0][i] = (n:finalParent.n, minc:min(midParent.minc, finalParent.minc), maxc:max(midParent.maxc, finalParent.maxc))
    }
    for e in edge[n.0] {
        if !check[e.0] {
            dfs(n: e, p: n.0)
        }
    }
}
```
그러면 기존의 lca처럼 부모 정보를 각 정점마다 저장시키기 위해 dfs를 돌려줄 것이다.  
기존의 parent[n][i]의 의미는 n번 정점의 2<sup>i</sup>번째 부모였지만 이제는 부모가 무엇인지 뿐만아니라 n번 정점부터 2<sup>i</sup>번째 부모까지의 경로 중 거리의 최댓값과 최솟값을 같이 포함하고 있는 것이다.  

<img width="658" alt="3176" src="https://user-images.githubusercontent.com/78075226/121185606-333f2c00-c8a1-11eb-8c7d-83426b86c118.png">

위의 그림을 보면 알 수 있듯이 주황색 즉 E의 2<sup>2</sup>번째 부모를 구하려고한다.  
그렇다면 우리는 dfs 구현에 의해 E의 2<sup>1</sup>번째 부모로 가서 해당 정점의 2<sup>1</sup>를 반환시켜줄 것이다.  
그런데 자세히보면 E의 2<sup>1</sup>번째 부모로 가는 도로의 최솟값과 최댓값을 이미 구해놨었고 C에서도 2<sup>1</sup>번째 부모로의 최솟값과 최댓값을 이미 구해놨다.  
따라서 E의 2<sup>2</sup>부모로 가는 도로의 최솟값과 최댓값은 이 두 정보를 비교하기만 하면 되는 것이다.  
  
이제 우리는 부모의 정보에 해당 부모까지 가는 도로의 최솟값과 최댓값을 알고있기 때문에 lca 알고리즘을 돌리는 과정에서 정점을 부모로 옮기는 순간마다 최솟값과 최댓값을 불러 비교해주기만 하면 된다.  
