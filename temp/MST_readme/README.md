# MST (Minimum Spanning Tree)
Spanning Tree (신장 트리) 란 원래 그래프 중 모든 노드가 연결되어 있으면서 트리의 속성을 만족하는 그래프이다. 1개의 그래프에 대해서 여러개의 신장 트리가 나올 수 있다. 만약 간선에 가중치가 있을 때 가중치의 합이 최소가 되는 spanning tree를 의미한다. 구하는 방법으로는 크게 크루스칼 알고리즘과 프림 알고리즘이 존재한다.
## 1. 크루스칼 알고리즘
그리디 알고리즘의 하나로 union-find을 사용해 트리를 만드는 기법이다.
```
1. 모든 정점을 하나의 독립적인 집합으로 만든다.
2. 모든 간선을 비용 순으로 정렬한다. 
3. 작은 비용부터 간선을 보는데 간선의 양 끝 점이 서로 다른 집합에 속할 경우 두 집합을 union 시킨다.
```

<img width="462" alt="cruskal" src="https://user-images.githubusercontent.com/78075226/120482598-3b542300-c3ec-11eb-89c6-935def0ae52b.png">

그림을 보면 알겠지만 4번째 순서로 D와 E를 잇는 가중치 5의 간선은 이미 D와 E가 같은 집합에 속해있어서 skip이 되었다. 

- 크루스칼 code
```swift
edge.sort(by: {$0.d < $1.d})
var i = 0, totalCost = 0
while i < edge.count {
    let current = edge[i]
    i += 1
    if !disjoint.union(current.0, current.1) { //두 점이 같은 집합에 속할 시
        continue
    }
    else {
        totalCost += current.d
    }
}
```

## 2. 프림 알고리즘
그리디 알고리즘의 하나로 하나의 정점으로부터 시작해 가장 작은 비용을 갖는 간선을 확장해나가는 방식이다.
```
1. 임의의 정점을 선택하여 리스트에 넣은 후 연결된 모든 간선을 min heap에 삽입
2. 가장 가중치가 작은 간선을 꺼내고 간선 set에서 제거
3. 간선의 인접 점이 list에 들어있지 않다면 해당 점을 list에 추가하고 연결된 모든 간선을 min heap에 삽입.
4. 살펴볼 간선이 없을때까지 2-3 반복
```

<img width="448" alt="prim" src="https://user-images.githubusercontent.com/78075226/120482623-41e29a80-c3ec-11eb-9ec7-127979e0b08c.png">

- 프림 code
```swift
minHeap.insert((node: 0, cost: 0))
var totalCost = 0
while !minHeap.isEmpty {
    let current = minHeap.pop()!
    if check[current.node] {
        continue
    }
    totalCost += current.cost
    check[current.node] = true
    for e in edge[current.node] {
        if check[e] {
            continue
        }
        else {
            minHeap.insert((e, cost[current.node][e]))
        }
    }
}
```
@@ 1774, 2887, 17472 정리
