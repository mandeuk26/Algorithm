# 위상 정렬
우리는 일상에서 일의 순서를 정해야 할 때가 있다.  
예를 들어 프린터에서 종이를 뽑는다하면  
`프린터를 설치한다 -> 종이를 넣는다 -> 컴퓨터에서 출력 버튼을 누른다`  
와 같이 순서를 정할 때가 많다.  
만약 어떤 일을 할 때 선제 조건이 필요하다면 그 조건들에 맞춰서 일의 순서를 짜는 것이 중요하다.  

<img width="526" alt="topology" src="https://user-images.githubusercontent.com/78075226/120776475-4085af00-c55f-11eb-9440-c418d910cca7.png">

만약 위와 같은 그래프가 주어졌을 때 화살표의 의미는 뒤의 노드를 방문하기 전에 앞의 노드를 처리해야한다는 뜻이라고 하자.  
그렇다면 우리는 어떤 순서로 노드를 방문해야 할것인가에 대해 정해주는 알고리즘이 바로 위상정렬이다.  
여기서는 큐를 활용한 위상정렬 방법에 대해 설명하겠다.  
```
1. 모든 노드에 대해 본인을 가르키는 간선이 몇개 있는지 inDegree 배열에 저장한다.
2. inDegree 배열의 값이 0인 모든 노드를 queue에 넣어둔다.
3. 큐를 하나씩 pop하면서 꺼내진 노드와 연결된 모든 간선의 inDegree 값을 1씩 뺀다.
4. 이 때 배열값이 0이 된다면 queue에 집어넣는다.
5. 3-4를 큐가 빌때까지 반복한다.
```
실제 구현도 간단하기 때문에 쉽게 이해할 수 있을 것으로 생각된다.  
위상정렬 알고리즘은 사이클이 없는 방향 그래프(DAG)에서만 사용 가능하다는 것을 명심하자.  
시간 복잡도는 모든 정점과 간선을 한번씩 살펴보므로 *O(V+E)* 에 해당한다.  
- Topological Sorting Code
```swift
var queue:[Int] = []
for i in 1...n {
    if inDegree[i] == 0 {
        queue.append(i)
    }
}

while !queue.isEmpty {
    let node = queue.removeFirst()
    print(node)
    for e in edge[node] {
        inDegree[e] -= 1
        if inDegree[e] == 0 {
            queue.append(e)
        }
    }
}
```
