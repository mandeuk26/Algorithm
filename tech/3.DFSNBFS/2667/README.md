# 백준 2667 단지번호붙이기
NxN의 행렬이 주어졌을 때 1은 집이 있는 곳을 0은 집이 없는 곳을 의미한다. 붙어있는 집들간에는 같은 단지 번호를 매긴다고 했을 때 각 단지별 집의 수를 오름차순으로 출력하는 문제이다.
전형적인 DFS, BFS 연습문제로 어느 것을 사용하든 상관이 없다. 나는 DFS로 문제를 구현하였다.
- DFS function
```swift
func DFS(result: inout Int, x: Int, y: Int) {
    let dx = [0, 0, -1, 1]
    let dy = [-1, 1, 0, 0]
    for i in 0...3 {
        let calcX = x+dx[i]
        let calcY = y+dy[i]
        if calcX < 0 || calcX == n || calcY < 0 || calcY == n || isVisited[calcX][calcY] {continue}
        else {
            result += 1
            isVisited[calcX][calcY] = true
            DFS(result: &result, x: calcX, y: calcY)
        }
    }
}
```
자 앞에서 배운 dfs코드와는 조금 다른 형태임을 알 수 있다. 그래프의 경우 node간의 edge들이 모두 구현된 상태에서 진행했었지만 2차원 array를 이용한 문제이기때문에 본인 기준 상하좌우만 확인하면 되서 따로 edge들이 구현되어있지않다. 따라서 calcX와 calcY라는 변수를 이용해서 상하좌우를 확인할 것이다.  
isVisited라는 방문여부를 확인해주는 배열이 있다. 이 때 집이 없는 곳들의 isVisited 값을 true로 해주어 해당 단지와 연결되어 있지 않으면 방문하지 않도록 구현해주었다.
- main 코드
```swift
var town:[Int] = []
for i in 0..<n {
    for j in 0..<n {
        if isVisited[i][j] {continue}
        else {
            var result = 1
            isVisited[i][j] = true
            DFS(result: &result, x: i, y: j)
            town.append(result)
        }
    }
}
```
이제 모든 위치에 대해서 탐색을 해줄 것이다. 만약 본인이 포함된 단지가 한번이라도 DFS가 실행되었다면 isVisited 값이 true로 나와 같은 단지를 두번 탐색하지 않는다. 단지별 아파트 수는 town이라는 변수에 매번 저장을 해주어 최종적으로 결과를 뽑아낼 것이다.
