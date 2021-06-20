# 2206 벽 부수고 이동하기
NxM으로 되어있는 맵이 있을 때 0은 이동가능한 곳, 1은 벽이 있는 곳이다. 이 때 벽을 한개까지 부수고 이동할 수 있다고 할 때 (1, 1)에서 (N, M)까지 최단경로를 찾아내는 문제이다. 불가능할 경우 -1을 출력한다.
앞에서 다룬 2178 미로탐색의 확장버전이다. 벽을 1개까지 부술 수 있다는 점이 특징이다. 따라서 벽을 부순 후인지 벽을 부수기 전인지를 같이 나타내서 해결해야 한다.
```swift
var board:[[(Int, Bool)]] = []
var queue:[(y:Int, x:Int, broken:Bool)] = [(0, 0, false)]
```
자 이제 우리는 board와 queue에 bool 변수를 함께 포함해서 나타낼 예정이다. 여기서 bool 변수는 현재 경로로 올 때 벽 부수기를 실행했는지 아닌지를 나타내는 변수이다. 그리고 board의 int값에는 -1, 0, 1, 2 네가지의 값이 올 것이다. 2는 정상적으로 길을 방문했을 경우, 1은 벽이 있는 경우, 0은 아직 방문한적 없는 길, -1은 벽을 부숴서 길이 된 경우를 나타낸다.
- BFS code
```swift
            let X = node.x + dx[i]
            let Y = node.y + dy[i]
            if X < 0 || Y < 0 || X == m || Y == n {continue}
            let visited = board[Y][X].0
            let brokenSpace = board[Y][X].1
            if visited == 0 {
                board[Y][X] = (2, node.broken)
                queue.append((y: Y, x: X, broken: node.broken))
            }
            else if visited == 1 && !node.broken {
                board[Y][X] = (-1, true)
                queue.append((y: Y, x: X, broken: true))
            }
            else if visited == 2 && !node.broken && brokenSpace {
                board[Y][X] = (2, false)
                queue.append((y: Y, x: X, broken: false))
            }
```
자 이제 bfs내부의 동작을 살펴보자. 현재지점에서 다음지점을 바라봤을 때 4가지의 경우가 있을 것이다. 
```
1) 방문한적 없는 길 :  
  현재 지점의 bool 변수를 그대로 이용하고 board에 방문했다고 2라고 표시해준다.  
2) 벽일 경우 && 벽뚫기 가능 :  
  해당 벽을 부수고 bool 변수를 true로 바꾸어 저장해준다. 
  이 때 -1로 표시해주는 이유는 다음에 방문했을때 벽인줄 알고 부수고 이동할 필요가 없기 때문이다. 
  (이미 해당 벽을 부수고 이동하는 최단 경로는 -1을 표시할 때이다)
3) 방문한 적이 있는 길이지만 벽뚫기를 사용해서 방문했었던 경우 : 
  벽뚫기를 안쓰고 방문이 가능하다고 새롭게 표시해준다.
4) 그 외에는 이미 최단경로로 방문을 했었기 때문에 아무것도 하지 않고 넘어간다.  
```
3번 경우에 대해 자세히 설명하겠다. 이 부분이 중요하다.  
만약 벽뚫기를 해서 방문을 하면 다음 경로가 (3,5) 지점에 방문하는 최단 경로일 것이다.

<img width="182" alt="2206fail" src="https://user-images.githubusercontent.com/78075226/119798093-cb3e2c80-bf15-11eb-9271-7b3529b6ab13.png">  

하지만 이렇게 방문을 하면 벽뚫기를 이미 사용해서 최종 목적지로 이동이 불가능하다.

<img width="181" alt="2206success" src="https://user-images.githubusercontent.com/78075226/119798147-d42efe00-bf15-11eb-9359-f53f12c9bdc2.png">  

위의 경로로 방문을 할 경우 벽을 뚫고 최종 목적지로 이동이 가능하다.  
따라서 우리는 벽뚫기를 해서 먼저 방문한 지점의 경우 board에 벽뚫기를 하지 않고 방문이 가능하다고 나타내주고 다시 queue에 추가해 bfs를 계속한다.  
