# 백준 1697 숨바꼭질
수빈이의 위치 n과 동생의 위치 k가 주어질 때 수빈이가 동생을 찾는 가장 빠른 시간을 구하는 문제이다. 수빈이의 위치가 x일 때 1초 후 수빈이는 x-1 혹은 x+1 혹은 2x로 이동이 가능하다.
가장 빠른 시간이라는 점에서 먼저 떠올라야하는 것은 바로 bfs이다. queue에 현재 위치를 기준으로 x-1, x+1, 2x 중 방문한 적이 없는 값을 집어넣고 bfs를 계속 돌리다가 위치가 k가 되면 그 때의 시간을 출력해주면 되는 간단한 문제이다. 
- BFS code
```swift
var time = -1
var index = 0
loop: while true {
    time += 1
    let k = index
    for i in k..<queue.count {
        let node = queue[i]
        if node == end {
            break loop
        }
        else {
            let a = 2*node
            let b = node-1
            let c = node+1
            if a <= 100000 && !visited[a] {
                visited[a] = true
                queue.append(a)
            }
            if b >= 0 && !visited[b]{
                visited[b] = true
                queue.append(b)
            }
            if c <= 100000 && !visited[c]{
                visited[c] = true
                queue.append(c)
            }
            index += 1
        }
    }
}
```
이 때 queue.removeFirst를 매번 해주는 것이 swift에서는 O(1)에 불가능하기 때문에 index 를 1씩 증가시켜 queue에 접근하는 방식으로 구현하였다. 메모리적으로는 더 많이 들지만 시간적으로 굉장히 절약이 되기 때문에 이 방식을 사용했다. 이 때 범위가 0-100000 이기에 해당 범위를 넘어서지 않을때만 동작하도록 하였다. 
