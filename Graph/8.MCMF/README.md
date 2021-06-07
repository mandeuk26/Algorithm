# MCMF (Minimum Cost Maximum Flow)
유량 그래프에서 추가적으로 각 간선마다 비용이 존재한다고 하자.  
그렇다면 source에서 sink까지 최소의 비용으로 최대한의 유량을 흘리는 방법을 구할 때 쓰는 알고리즘이 MCMF이다.  
이 때 가장 먼저 기준이 되어야 할 요소가 flow가 아닌 cost가 된다.  
따라서 경로의 비용을 구하기 위해 우리는 앞에서 배웠던 최단 경로 알고리즘을 응용할 것이다.  
하지만 유량 그래프에서 한쪽방향으로 유량이 흐르면 반대쪽으로 -flow가 흐른다고 했던 것 기억할 것이다.  
이는 유량뿐만 아니라 비용 역시 마찬가지로  `d(u, v) = -d(v, u)` 의 식을 만족한다.  
따라서 최단 경로를 구할 때 음수의 weight가 있으므로 벨만포드를 사용해야 할 것이다.  
MCMF에서는 벨만포드를 조금 변형시켜 동작이 더 빠른 SPFA(Shortest Path Faster Algorithm)을 사용할 것이다.  
## SPFA (Shortest Path Faster Algorithm)
시작 정점부터 BFS를 하면서 모든 정점에 대한 최단 경로를 구할 것이다.  
다익스트라와 비슷하게 하나씩 가까운 점들을 업데이트 하는데 이미 방문했던 정점이라할지라도 비용이 더 짧은 경로를 발견할 시에는 다시 큐에 집어넣고 새로운 경로를 찾는다는 점에 차이점이 있다.  
이 때 큐 내부에 업데이트가 일어난 정점이 들어있을 경우 큐에 새로운 원소를 추가하지 않음으로써 시간을 단축시킨다.  
평균적으로 벨만포드보다 빠른 *O(E)* 시간 안에 동작하지만 최악의 경우 *O(VE)* 가 걸리게 된다.  
유의점으로는 mcmf를 위해서 유량을 비교하는 부분이 추가되어 있다는 것이다.  
구현 자체는 간단해서 코드 한번 읽어보면 이해가 될 것이다.  
- SPFA Function
```swift
func SPFA() -> Bool {
    var dst = Array(repeating: INF, count: n+m+2) //최단 경로 비용 저장
    var inq = Array(repeating: false, count: n+m+2) //큐 내부에 들어있는지 여부
    var queue = [Int]()
    queue.append(s)
    inq[s] = true
    dst[s] = 0
    while !queue.isEmpty {
        let curr = queue.removeFirst()
        inq[curr] = false
        for next in edge[curr] {
            if c[curr][next] - f[curr][next] <= 0 {
                continue
                //유량이 흐를 수 없는 경로에 대해서는 continue
            }
            if dst[curr] < INF && dst[next] > dst[curr]+d[curr][next] {
                dst[next] = dst[curr]+d[curr][next]
                parent[next] = curr
                if !inq[next] {
                    queue.append(next)
                    inq[next] = true
                }
            }
        }
    }
    return dst[e] != INF
    //최종적으로 sink에 도달하는 경로가 존재할 시 true, 없을시 false
}
```
## MCMF Function
자 이제 SPFA에 대해 공부했으니 해당 코드를 사용해서 경로를 구해보자.  
경로를 구했다면 앞서 사용했던 에드몬드 알고리즘과 동작이 비슷하다.  
경로를 따라서 흐를 수 있는 유량과 그 때의 비용을 계산해주면 된다.  
그 후 경로를 따라서 flow 값들을 업데이트 시켜준다.  
드는 비용은 `비용의 합 x 경로를 따라 흐를 수 있는 최대 유량` 이 될 것이다.  
최종적으로 더이상 source에서 sink로 흐르는 경로가 없을 때까지 반복해서 구해주면 된다.  
- Flow Function
```swift
func flow() -> (Int, Int) {
    var totalFlow = 0, money = 0
    while SPFA() {
    // 더이상 경로가 없을 때까지 반복
        var idx = e, cost = 0, minF = INF
        while idx != s {
            let prev = parent[idx]
            minF = min(minF, c[prev][idx]-f[prev][idx])
            cost += d[prev][idx]
            idx = prev
        }
        // min Flow, cost 계산
        idx = e
        while idx != s {
            let prev = parent[idx]
            f[prev][idx] += minF
            f[idx][prev] -= minF
            idx = prev
        }
        // flow update
        money += cost*minF
        totalFlow += minF
    }
    return (totalFlow, money)
}
```
@ 11408 11409 11493 11111 정리
