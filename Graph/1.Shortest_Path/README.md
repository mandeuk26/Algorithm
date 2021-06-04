# 최단 경로 알고리즘
가중치가 있는 그래프가 주어지면 정점 u와 정점 v로 연결하는 경로 중 간선들의 가중치 합이 최소가 되는 경로를 찾는 알고리즘이다.  
최단 경로를 구하는 알고리즘으로는 다익스트라, 벨만포드, 플로이드 와샬 3가지의 알고리즘이 존재한다.  
## 1. Dijkstra Algorithm
하나의 정점에서 다른 모든 정점들로의 최단 경로를 찾고자 할 때 사용할 수 있는 알고리즘이다.  
다익스트라를 사용하려면 간선들의 weight 값은 음의 값을 가질 수 없다는 특징이 있다.  

<img width="351" alt="shortestpath" src="https://user-images.githubusercontent.com/78075226/120755773-61dba080-c549-11eb-9500-b70283d65bf0.png">

위의 그림을 예시로 설명할 것이다.  
먼저 시작 정점으로부터 다른 정점까지 걸리는 최단 경로의 값을 dist 라고 부르는 배열에 저장해 둘 것이다.  
모든 정점으로의 최단 경로를 INF로 설정해놓고 시작 정점의 최단 경로는 0으로 설정해놓자.  
그렇다면 0을 시작 정점으로 잡은 dist 배열은 다음과 같다.  

<img width="411" alt="dijkstra1" src="https://user-images.githubusercontent.com/78075226/120755800-6c963580-c549-11eb-9d8e-a53a33d1c78c.png">

이제 다음의 방법을 반복적으로 수행해서 배열을 채워나갈 것이다.  
```
1. dist배열에서 선택하지 않은 정점 중에 가장 작은 값을 가지는 정점을 선택한다.
2. 해당 정점과 연결된 모든 정점들의 dist값을 최솟값으로 update 해준다.
3. update는 다음 식을 따른다. min(dist[v], dist[u] + weight[u][v])
```
순서대로 표를 채우면 다음과 같다.  

<img width="461" alt="dijkstra2" src="https://user-images.githubusercontent.com/78075226/120755825-7455da00-c549-11eb-98fd-818a7dcec37c.png">

만약 p라는 정점이 가장 작은 최단 경로값을 가져서 선택이 되었다고하자.  
이후에 q라는 정점이 선택이 되었을 때 p로 향하는 경로가 있다면 p의 dist값이 update될 것이다.  
하지만 q는 p보다 나중에 선택이 됬기 때문에 `dist[p] <= dist[q]` 이다.  
weight의 값은 음이 아니라고 했으므로 p의 최단 경로값이 update 될 일이 없다.  
따라서 다익스트라 알고리즘의 유효성을 확인할 수 있다.  
  
이 때 dist배열에서 가장 작은 값을 가지는 정점을 선택하는 과정을 일일히 확인하면 시간이 오래 걸린다.  
따라서 앞에서 공부한 min heap을 활용하여 가장 작은 최단 경로를 갖는 노드들을 찾아 줄 것이다.  
min heap을 활용하면 시간 복잡도는 heap에 *O(E)* 개의 점이 들어갈 수 있고 매번 heap에서 최솟값을 꺼낼때마다 *O(logE)* 의 시간이 걸리므로 *O(ElogE)* 가 걸리게 된다.  
E <= V<sup>2</sup> 이므로 최종 시간복잡도는 *O(ElogV)* 이다.  
- Dijkstra Code
```swift
var PQ = PriorityQueue()
PQ.insert((startNode,0))
Dist[startNode] = 0
while !PQ.isEmpty {
    let current = PQ.pop()!
    let currentIndex = current.0, currentDist = current.1
    for i in 0..<Edge[currentIndex].count {
        let nextIndex = Edge[currentIndex][i].0, nextWeight = Edge[currentIndex][i].1
        if Dist[nextIndex] > currentDist + nextWeight {
            Dist[nextIndex] = currentDist + nextWeight
            PQ.insert((nextIndex, currentDist + nextWeight))
        }
    }
}
```
## 2. Bellman-Ford Algorithm
다익스트라와 마찬가지로 한 정점에서 다른 모든 정점으로의 최단 경로를 찾고자 한다고하자.  
이 때 이번에는 음의 가중치를 갖는 간선이 존재한다고 하자.  
이럴 경우 다익스트라는 사용할 수 없게되고 새로운 방법이 필요하게 된다.  
```
1. 모든 dist 값을 INF로 만들고 시작 정점만 0을 입력한다.
2. 모든 간선에 대해 dist 값을 업데이트 해준다. 이 때 간선의 시작 정점의 dist값이 INF인 경우는 생략한다.
3. 2를 V-1번 반복한다.
4. 2를 1번 더 시행하는데 dist값이 하나라도 바뀐다면 음의 cycle이 존재한다는 의미이다.
```
핵심 아이디어는 사이클이 존재하지 않는다면 V개의 정점이 있을 때 최단 경로는 최대 V-1개의 정점을 거친다는 것이다.  
따라서 모든 간선을 V-1번 살펴보게 되면 최단 경로를 전부 찾을 수 있다.  
만약 음의 사이클이 존재할 경우 모든 간선을 1번 더 살펴봤을때 값이 변할 것이다.  

<img width="664" alt="bellman" src="https://user-images.githubusercontent.com/78075226/120762548-54c2af80-c551-11eb-8954-888db0473155.png">

실제 예시를 들어 벨만포드를 사용한 결과이다.  
간선의 업데이트 순서는 항상 5 -> 4 -> -3 -> 7 -> 2 -> 6 의 가중치를 가진 간선을 사용한다고 하자.  
추가로 다익스트라 알고리즘을 사용하면 다른 결과가 나온다는 것을 직접 확인해보면 좋다.  
  
전체 시간 복잡도는 E개의 간선을 V-1번 봐야하므로 *O(VE)* 가 된다.  
따라서 속도는 다익스트라가 더 빠르기 때문에 상황에 맞게 알고리즘을 선택하는 것이 중요하다.  
- Bellman-Ford Code
```swift
Dist[1] = 0
for _ in 1..<n {
    for i in 1...n {
        if Dist[i] == INF {
            continue
        }
        for e in Edge[i] {
            Dist[e.0] = min(Dist[e.0], Dist[i] + e.1)
        }
    }
}

//음의 cycle 확인
var cycle = false
for i in 1...n {
    if Dist[i] == INF {
        continue
    }
    for e in Edge[i] {
        if Dist[e.0] > Dist[i] + e.1 {
            cycle = true
            break
        }
    }
}
```
## 3. Floyd Warshall Algorithm
우리는 여지껏 한개의 정점에서 다른 모든 정점으로의 최단 경로를 구하는 알고리즘을 살펴보았다.  
만약 모든 정점에 대해서 모든 정점으로의 최단 경로를 알고 싶다면 모든 정점에 대해 다익스트라 알고리즘을 적용할 수도 있겠다.  
하지만 그렇게 될 경우 *O(VElogV)* 의 많은 시간이 소요된다.  
그보다 적은 시간인 O(V<sup>3</sup>) 만에 최단 경로를 구할 수 있는 알고리즘이 바로 플로이드 와샬이다.  

이번에는 앞에와 다르게 2차원 배열을 만들 것이다.  
2차원 배열의 arr[1][2] 의 의미는 1번 정점에서 2번 정점으로 가는 최단 경로를 의미한다.  
이 때 1 -> 2 로 이동하는 최단경로가 1 -> 3 -> 2 라고 해보자.  
그렇다면 1 -> 2로 가는 최단 경로는 1 -> 3으로 가는 최단경로에 3 -> 2로가는 최단경로를 합친것과 같다.  
이를 응용하여 모든 두 정점간에 최단 경로를 구하는 문제를 중간 경로를 거쳐 가는 문제로 나누어 구하는 것이다.  
핵심 알고리즘은 다음과 같다.
```
1. 배열의 모든 값을 INF로 설정한 뒤 알고있는 간선 값을 이용해 배열을 업데이트 한다.
2. 자기 자신으로의 최단 경로는 0으로 설정한다.
3. 모든 두 정점쌍에 대해 최단 경로를 구해줄 것인데 중간경로로 다른 모든 정점을 설정하고 최솟값을 찾아준다.
```
예시를 들어보면 다음과 같다.  

<img width="662" alt="floyd" src="https://user-images.githubusercontent.com/78075226/120768455-1fb95b80-c557-11eb-8f8a-3f459a0da2af.png">

이 때 1 -> 3으로 가는 최단 경로를 구하는 방법은 2와 4를 각각 중간경로로 하는 방법이 존재한다.

<img width="656" alt="floyd2" src="https://user-images.githubusercontent.com/78075226/120768478-28119680-c557-11eb-831f-c6950d50ec66.png">

이렇게 모든 정점쌍에 대해서 최솟값을 구해주면 모든 정점쌍의 최단 경로를 구해낼 수 있다.  
플로이드 와샬은 벨만 포드와 마찬가지로 음의 가중치를 가지는 간선이 있어도 값을 구해낼 수 있다.  
만약 음의 사이클이 존재한다면 자기 자신으로의 경로가 음의 값이 존재하게 되므로 쉽게 파악할 수 있다.  
양의 사이클을 알아내고 싶다면 자기 자신으로의 최단 경로를 INF로 설정하면 쉽게 파악할 수 있다.
시간 복잡도는 V<sup>2</sup>개의 정점 쌍에 대해서  V개의 중간 경로를 확인해야 하므로 O(V<sup>3</sup>)이 된다.  
- Floyd Warshall Code
```swift
for i in 1...n {
    for j in 1...n {
        for k in 1...n {
            if k == i || k == j {continue}
            Edge[j][k] = min(Edge[j][k], Edge[j][i] + Edge[i][k])
        }
    }
}
```
@ 9370 11657 11404 10217 1956 정리
