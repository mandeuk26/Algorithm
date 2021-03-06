# 백준 1956 운동
각 마을간 도로의 길이가 주어졌을 때 시작점에서 다시 시작점으로 돌아오는 사이클의 최소 비용을 찾는 문제이다.  
여지껏은 사이클을 최대한 배척하면서 문제를 풀었다면 이번 문제는 오히려 사이클을 구하는 문제이다.  
만약 시작지점에서 a라는 정점을 거쳐 오는 최단 사이클은 s -> a 로 가는 최단 경로에 a -> s로 가는 최단 경로를 합친 것과 같다.  
따라서 모든 정점에 대해서 이를 반복해주면 모든 사이클 중에서 최단 경로를 찾을 수 있을 것이다.  
플로이드 와샬 알고리즘을 활용하면 이를 효과적으로 구할 수 있다.  
- 플로이드 와샬 코드
```swift
for i in 1...V {
    for j in 1...V {
        for k in 1...V {
        //j와 k가 같은 경우도 고려해주도록 해서 cycle을 찾는다!!
            DP[j][k] = min(DP[j][k], DP[j][i] + DP[i][k])
        }
    }
}
```
만약 자기 자신으로의 최단 경로를 INF로 설정해놓고 시작과 끝이 같은 경우에도 플로이드 와샬 알고리즘이 동작하도록 구현한다면 손쉽게 구할 수 있다.  
시작 지점은 정해져있지 않으므로 모든 사이클 중에서 최솟값을 출력해주면 된다.  

