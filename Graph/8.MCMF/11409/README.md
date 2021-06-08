# 백준 11409 열혈강호 6
열혈강호 문제의 6번째 확장판.  
MCMF에서는 그동안 최소 비용 최대 플로우를 구했다면 최대 비용 최대 플로우를 구하는 문제이다.  
생각해보면 flow를 구하는 과정은 동일할 것이기 때문에 최소 비용이 아닌 최대 비용으로 경로를 구하는 것이 핵심이다.  
  
따라서 SPFA 알고리즘을 다음과 같이 수정해야 한다.  
- SPFA 알고리즘 일부
```swift
while !queue.isEmpty {
    let curr = queue.removeFirst()
    inq[curr] = false
    for next in edge[curr] {
        if c[curr][next] - f[curr][next] <= 0 {
            continue
            // flow가 흐를 수 없는 경로는 continue
        }
        if dst[curr] < INF && (dst[next] == INF || dst[next] < dst[curr]+d[curr][next]) {
            dst[next] = dst[curr]+d[curr][next]
            parent[next] = curr
            if !inq[next] {
                queue.append(next)
                inq[next] = true
            }
        }
    }
}
```
그동안은 값이 작다면 업데이트를 시켜주고 queue에 집어넣었다면 이번에는 값이 클 경우에만 업데이트를 시켜주고 queue에 집어넣는 방식으로 구현했다.  
dst[next]에 값이 입력된 적이 없는 default 상태일 경우 예외처리를 해줘야 함을 확인하자.  
나머지 코드는 열혈강호 5의 코드와 동일하게 MCMF 알고리즘을 그대로 동작시키면 된다.  
