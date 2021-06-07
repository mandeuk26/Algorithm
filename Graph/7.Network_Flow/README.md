# Network Flow
유량 그래프란 파이프와 같이 되어있는 그래프로 각 간선마다 최대 흐를 수 있는 양이 정해져있는 그래프를 의미한다.  
이 때 그래프에는 시작(source)와 끝(sink) 노드가 존재한다.  
예시로 다음 그래프를 보자.

<img width="463" alt="networkflow1" src="https://user-images.githubusercontent.com/78075226/120992935-08c87280-c7be-11eb-9626-27fc5d3e5e02.png">

유량 그래프에는 다음과 같은 요소가 있다.
```
소스(source)   : 시작 위치
싱크(sink)     : 끝 위치
용량(capacity) : 유량이 흐를 수 있는 크기
유량(flow)     : 간선을 따라 흐르는 양
```
이 때 유량 그래프에서는 다음 3가지 속성이 항상 성립한다.
```
1. f(u, v) <= c(u, v)
2. f(u, v) = -f(v, u)
3. in Flow = out Flow
```
1, 3은 생각해보면 당연한 것인데 2라는 개념이 헤깔릴 수 있다.  
다음 예시를 보고 이해해보자.  

<img width="447" alt="networkflow2" src="https://user-images.githubusercontent.com/78075226/120992946-0b2acc80-c7be-11eb-8308-eb4255158ffb.png">

먼저 Source -> A -> B -> Sink의 경로로 1만큼의 유량이 흘렀다고 해보자.  
이어서 Source를 통해 B로 유량을 보내려고 했는데 B가 갈 수 있는 간선이 꽉 차 더이상 흐를수가 없게 되었다.  

<img width="423" alt="networkflow3" src="https://user-images.githubusercontent.com/78075226/120992949-0bc36300-c7be-11eb-8bad-e93230d3f738.png">

그런데 2의 개념을 적용해서 그래프를 다시 그려보면 위와 같다.  
자세히 보면 한쪽 방향으로 유량이 흐르면 반대편 방향으로 - 값이 흐르게 된다는 것을 알 수 있다.  
이제 B -> A 경로의 Capacity - Flow 를 해보면 1 만큼의 유량이 흐를 수 있게 된다는 것을 의미한다.  
이렇게 되면 Source -> B -> A -> Sink 로의 새로운 경로가 생기게 된다.  

<img width="425" alt="networkflow4" src="https://user-images.githubusercontent.com/78075226/120992952-0c5bf980-c7be-11eb-9efa-d04bab0b9742.png">

따라서 최종적으로 흐르게 되는 유량 그래프는 위와 같다.  
어떻게 보면 Source -> A -> Sink 와 Source -> B -> Sink 두개의 길을 통해 유량이 흐른 것처럼 보인다.  
2번 속성에 의해 유량이 최적의 해가되는 길로 흐르지 않더라도 언제든지 거슬러 올라 최적의 해를 찾아주게 된다.  
  
그렇다면 어떻게 최적의 해를 찾을 수 있을까?  
DFS를 이용하는 포드 풀커슨 알고리즘와 BFS를 이용하는 에드몬드 카프 알고리즘, 그리고 디닉 알고리즘이 존재한다.  
포드 풀커슨의 경우 한번에 1 만큼의 유량만 흘려주는 방식인데 *O(EF)* 의 시간이 걸려 F가 큰 문제에서는 굉장히 오랜 시간이 걸리게 된다.  
따라서 일반적으로 *O(VE^2)* 의 시간이 걸리는 에드몬드 카프 알고리즘이 많이 사용되어서 에드몬드 카프 알고리즘에 대해 먼저 정리하겠다.  
## Edmonds-Karp Algorithm
BFS 기반의 알고리즘으로 flow가 흐를 수 있는 경로를 BFS로 찾아 해당 경로를 따라 flow를 흘려준다.  
이 때 parent 라는 배열을 이용하여 지나온 경로를 저장해준다.  
이 때 flow는 경로상 간선마다 흐를 수 있는 flow 중에서 가장 작은 값이 흐르게 된다는 점을 이용한다.  
즉 `c[u][v]-f[u][v] 의 최솟값`이 흐르게 된다는 것을 의미한다.  
- Find Path's Minimum Flow Code
```swift
var idx = e
var minF = 1_000_000_000
while idx != s {
    let prev = parent[idx]
    minF = min(minF, c[prev][idx]-f[prev][idx])
    idx = prev
}
```
한편 minimum flow를 찾았다면 다시한번 경로를 따라가면서 flow 배열에 저장된 값을 변경해준다.  
이 때 u -> v 로 흘렀다면 v -> u 에도 -minimum flow를 더해줌을 잊지말자.
- Update Flow Array
```swift
idx = e
while idx != s {
    let prev = parent[idx]
    f[prev][idx] += minF
    f[idx][prev] -= minF
    idx = prev
}
```
한번 bfs로 경로를 찾을 때 걸리는 시간은 *O(E)* 이고 찾는 횟수는 총 *O(VE)* 에 해당한다.  
따라서 전체 걸리는 시간은 *O(VE^2)* 가 된다.  
## Dinic Algorithm
그런데 문제의 조건이 열약하여 *O(VE^2)* 의 시간에도 못 구하는 경우가 있다.  
이럴 경우 디닉 알고리즘이 하나의 해법이 될 수 있는데 걸리는 시간은 *O(EV^2)* 로 에드몬드보다 빠르다.  
디닉은 레벨 그래프라는 개념이 추가되어서 dfs를 활용하여 경로를 찾는 방식이다.  
먼저 우리는 level 그래프를 그릴 것이다.  
다음과 같은 그래프가 주어진다고 해보자.

<img width="561" alt="dinic1" src="https://user-images.githubusercontent.com/78075226/121008332-d9216680-c7cd-11eb-86ae-765546ce4c73.png">

이 때 bfs를 이용하여 레벨을 그리면 다음과 같이 된다.  
그리고 dfs를 이용하여 level차이가 1이 나고 유량이 흐를 수 있는 경우 해당 간선을 통해서 유량을 흘려준다.  
한번의 dfs를 통해 1번의 경로에 대해서만 유량을 흘려줄 수 있기 때문에 더이상 추가적인 유량이 흐르지 않을 때까지 반복해서 dfs를 실행시킨다.  

<img width="569" alt="dinic2" src="https://user-images.githubusercontent.com/78075226/121008343-daeb2a00-c7cd-11eb-9334-abe508f2d5f2.png">

자 이번엔 다시 bfs를 돌려 level그래프를 새롭게 형성해준다.  
이 때 유의사항으로 파란색 간선이 보일텐데 유량이 한쪽 방향으로 흐르면 반대쪽으로도 -한 값이 흐르게 된다는 것을 항상 기억하자.  
따라서 해당 간선을 고려해서 level을 마킹해주었다.  
이 경우 빨간색 간선들을 따라 5만큼의 유량이 새롭게 흐를 수 있게 되었다.  

<img width="572" alt="dinic3" src="https://user-images.githubusercontent.com/78075226/121008346-dc1c5700-c7cd-11eb-856f-f3672cfdaba6.png">

이번에도 마찬가지로 bfs로 level을 마킹해주려했다.  
그러나 어떤 경로를 통해서라도 sink에 level을 줄 수 없기 때문에 더이상의 작업은 필요없다고 판단하고 실행을 종료시킨다.  

<img width="567" alt="dinic4" src="https://user-images.githubusercontent.com/78075226/121008349-dcb4ed80-c7cd-11eb-902c-a5abdba91d83.png">

쉬워보이지만 몇가지 테크닉이 들어가 복잡할 수 있다.  
코드를 하나씩 살펴보자.  
- BFS Function
```swift
func bfs() -> Bool {
    level = Array(repeating: -1, count: 555)
    var q = [Int]()
    level[s] = 1
    q.append(s)
    while !q.isEmpty {
        let curr = q.removeFirst()
        for i in edge[curr] {
            if level[i] == -1 && c[curr][i] - f[curr][i] > 0 {
                level[i] = level[curr] + 1
                q.append(i)
            }
        }
    }
    return level[e] != -1
}
```
레벨을 매겨주는 bfs 함수이고 동작은 앞서 했던 에드몬드의 bfs와 비슷하다.  
유량이 흐를 수 있는 경로가 존재할 시 parent가 아닌 level함수를 이전 level에 1씩 증가시키면서 매겨준다.  
최종적으로 sink에 level이 매겨진다면 true, 아닐시 false가 반환된다.  
- DFS Function
```swift
func dfs(curr: Int, flow: Int) -> Int {
    if curr == e {
        return flow
    }
    let nextVertex = work[curr]
    for i in nextVertex..<edge[curr].count {
        let next = edge[curr][i]
        if level[next] == level[curr] + 1 && c[curr][next] - f[curr][next] > 0 {
            let tmp = dfs(curr: next, flow: min(flow, c[curr][next] - f[curr][next]))
            if tmp > 0 {
                f[curr][next] += tmp
                f[next][curr] -= tmp
                return tmp
            }
        }
        work[curr] += 1
    }
    return 0
}
```
level 배열을 정했을 때 최대로 흘려줄 수 있는 유량을 계산하는 함수이다.  
이 때 work 배열이 등장하는데 이번 차례에 봐야할 edge 번호를 알려주는 배열이다.  
예를 들어 어떤 정점에 연결된 3번 edge를 통해 유량을 흘려줬지만 dfs로 반환받은 결과는 0이라고하자.  
즉 해당 edge로 유량을 흘려줘도 더이상 유량이 흐르지 않는다는 것을 의미한다.  
그렇다면 dfs를 반복적으로 실행하는 과정에서 다시 해당 정점에 도착했다고 하자.  
이미 3번 edge를 통해 유량을 흘리는 것은 의미가 없다는 것을 알기 때문에 반복 과정에서 4번 edge부터 살펴보라고 할 수 있다.  
이를 위한 역할이 바로 work 배열이고 시간을 줄이는데 큰 도움을 준다.  
  
만약 유량이 흘렀다면 그 반환값을 가지고 flow 값을 변경시켜줘야 함을 유의하자.  
이 때 역방향으로 -flow를 해주는 것도 잊지말자.  
- Dinic Function
```swift
func dinic() -> Int {
    var totalFlow = 0
    while bfs() {
        work = Array(repeating: 0, count: 555)
        while true {
            let tmpflow  = dfs(curr: s, flow: INF)
            if tmpflow == 0 {
                break
            }
            totalFlow += tmpflow
        }
    }
    return totalFlow
}
```
최종적인 dinic 함수로 bfs로 레벨 매칭에 성공할시 반복적으로 동작하도록 되어있다.  
이 때 매번 level을 새로 매길 때마다 work 함수는 초기화를 시켜주어 모든 간선을 살펴볼 수 있도록 해야한다.  
만일 더이상 flow가 흐르지 않는다면 다음번 level로 넘어가도록 되어있다.  

