# 백준 2178 미로 탐색
NxM의 배열이 주어진다. 1은 이동할 수 있는 칸, 0은 이동할 수 없는 칸을 나타낼 때 (1, 1) 위치에서 (NxM) 위치로 이동하는 최단 거리를 구하는 문제이다.
이 문제는 BFS를 활용해서 푸는 문제이다. BFS의 특징은 시작지점으로부터 같은 거리만큼 떨어진 곳을 모두 방문한 후에 다음 거리를 방문한다는 점이다. 즉 최단거리 찾는 문제에 종종 사용된다.
- BFS function
```swift
func BFS() {
    var queue:[(y:Int, x:Int)] = [(0, 0)]
    let dx = [1, -1, 0, 0]
    let dy = [0, 0, 1, -1]
    
    while !queue.isEmpty {
        let node = queue.removeFirst()
        for i in 0...3 {
            let nextX = node.x + dx[i]
            let nextY = node.y + dy[i]
            if nextX < 0 || nextY < 0 || nextX == m || nextY == n {continue}
            else if board[nextY][nextX] == 1 {
                board[nextY][nextX] = board[node.y][node.x] + 1
                queue.append((y:nextY, x:nextX))
            }
        }
    }
}
```
2667문제의 DFS와 마찬가지로 상하좌우만 확인해주면 되기 때문에 edge가 따로 구현되어있지 않다. 따라서 nextX&nextY를 통해 네 지점을 확인해 줄 것이다. 여기서는 check함수가 없이 구현이 되어있는데 기존 미로의 구성을 저장한 board 배열이 check함수의 역할까지 함께 하고 있다. 현재 지점으로부터 길이 있다면 `현재지점 최단거리+1` 이 다음 지점까지의 최단거리가 될 것이고 이미 방문한 적이 있다면 board 배열 값이 1이 아닐 것이기 때문에 check배열 없이 구현이 가능하다.  
최종적으로는 **board[n-1][m-1]** 에 저장된 값이 최단 경로이다.
