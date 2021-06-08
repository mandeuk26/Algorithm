# 백준 9370 미확인 도착지
출발지가 주어지고 목적지가 여러개 주어진다고 하자.  
이 때 목적지로 향하는 최단 경로의 일부인 간선 하나가 주어졌다고 했을 때 후보로 가능한 목적지들을 오름차순으로 출력하는 문제이다.  
일단 도로의 가중치는 양의 값을 가진다고 나와있기 때문에 다익스트라를 사용하면 좋을 것이라는 생각이 든다.  
만약에 어떤 중간 간선 (g - h)이 주어진다고 했을 때 `s -> d` åç로의 최단경로는 `s -> g -> h -> d` 혹은 `s -> h -> g -> d` 가 될 것이다.  
이를 응용하여 우리는 s, g, h로부터 모든 점으로의 최단경로를 찾고 이를 이용해서 정답을 찾을 것이다.  
```swift
var PQ = PriorityQueue()
calculateMin(start: g, PQ: &PQ, Dist: &Dist, Edge: Edge)
calculateMin(start: h, PQ: &PQ, Dist: &Dist2, Edge: Edge)
calculateMin(start: s, PQ: &PQ, Dist: &Dist3, Edge: Edge)
var str = ""
for goal in Destination {
    let result = min(Dist[s] + Dist[h] + Dist2[goal], Dist2[s] + Dist2[g] + Dist[goal])
    if result == Dist3[goal] {
        str += "\(goal) "
    }
}
```
코드를 보면 알 수 있듯이 g, h, s 각각에 대해 모든 정점에 대한 최단 경로를 서로 다른 dist 배열에 저장시켜주었다.  
최종적으로 모든 destination 후보들에 대해서 `s -> g -> h -> d` 와 `s -> h -> g -> d` 최단거리의 최솟값과 `s -> d` 경로의 최단 거리를 비교해주어서 일치할 시 정답에 추가시켜준다.  
