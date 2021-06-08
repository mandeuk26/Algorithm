# 백준 10217 KCM Travel
도시 간의 이동 비용과 이동 시간이 주어진다고 하자.  
만약 시작 도시에서 목적지 도시까지 최단 시간을 구하려고 하는데 비용이 주어진 상한선을 넘으면 안되는 문제이다.  
기존의 최단 경로는 항상 고려할 요소가 1개였는데 이번에는 2가지로 늘었다.  
하지만 이동 비용은 어디까지나 제한 요소일뿐 구하고자하는 최단 경로 값은 시간이기 때문에 시간에 대해서 최단 경로를 진행해줄 것이다.  
음의 가중치는 존재하지 않기 때문에 다익스트라를 활용해서 접근할 것이다.  
  
먼저 모든 edge는 비용과 시간을 같이 저장하고 있는 형태로 저장한다.  
또한 dist에 대해서 2차원으로 설정해서 도시의 번호와 비용이 주어지면 해당 비용 안에서 최단 시간을 반환하도록 설정하였다.  
```swift
var PQ = PriorityQueue()
PQ.insert((1, 0, 0))
Dist[1][0] = 0
while !PQ.isEmpty {
    let current = PQ.pop()!
    let currentIndex = current.0, currentCost = current.1, currentTime = current.2
    if currentIndex == N {break}
    for i in 1...N {
        let nextIndex = i
        for edge in Edge[currentIndex][nextIndex] {
        // 현재index에서 다음index로 가는 모든 간선에 대해서
            let nextCost = currentCost + edge.0
            if nextCost > M {continue} // 비용이 M을 넘어서는 경우 continue
            let nextTime = currentTime + edge.1
            if Dist[nextIndex][nextCost] <= nextTime {continue}
            for k in nextCost...M {
            // k 이후에 모든 cost에 대해서도 시간 비교를 해줘 반복 연산을 줄인다.
                if Dist[nextIndex][k] > nextTime {
                    Dist[nextIndex][k] = nextTime
                }
                else {
                    break
                }
            }
            PQ.insert((nextIndex, nextCost, nextTime))
        }
    }
}
```
기본적으로는 다익스트라의 동작과 동일하기 때문에 어려울 것이 없다.  
유의할 점으로는 u -> v로 가는 간선이 여러개가 존재할 수 있다는 것이다.  
따라서 Edge 배열이 3차원으로 이루어져 있다는 것을 유의하자.  
  
또 한가지로 현재 index에서 다음 index로 가는 최단 시간이 기존의 배열에 저장된 최단 시간보다 작다면 update가 일어날 것이다.  
이 때 Dist배열에서 해당 비용에 대해서만 업데이트를 하는 것이 아니라 그 이후의 모든 비용에 대해서 업데이트를 해준다.  
만약 i라는 index를 가지는 도시에 k라는 비용을 써서 최단 시간 d을 찾았다고 하자.  
후에 어떤 경로를 거쳐서 다시 i를 방문했는데 k+1의 비용을 써서 최단 시간 d+1이 걸렸다고 하자.  
이 소리는 더 많은 비용을 쓰고 더 많은 시간이 걸려서 해당 도시에 도착했다는 소리이고 무조건 k 비용을 써서 d 시간에 도착한 경우가 유효할 것임을 알 수 있다.  
따라서 k 이후의 모든 비용에 대해 업데이트를 해주면 쓸데 없는 연산을 줄일 수 있게 된다.  
최종적으로는 N번 도시에 대해서 M 이하의 모든 비용값에 대해 최단 시간을 찾아주면 된다.
