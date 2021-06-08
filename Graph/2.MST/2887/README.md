# 백준 2887 행성 터널
3차원 상의 행성들의 좌표들이 주어졌을 때 행성간 연결을 통해 MST를 구축하려고 한다.  
이 때 행성을 터널로 연결할 때의 비용은 `min(X값의 차, Y값의 차, Z 값의 차)`이다.  
모든 행성에 대해 서로를 연결하는 간선 비용을 구하게 되면 n이 최대 100000이므로 대략 10<sup>10</sup>의 시간이 걸리게 된다.  
따라서 주어진 시간 안에 edge설정조차 할 수 없게된다.  

터널간의 연결 비용은 자세히 보면 각 축에 따른 길이 차이로 되어 있다.  
만약 A, B, C라는 행성이 순서대로 x축을 따라 존재한다고 하자.  
A - C 를 연결하고 B - C 를 연결하는 것보다 A - B 와 B - C 를 연결하는 것이 길이가 더 짧을 것이다.  
따라서 모든 행성들의 경우 본인 바로 옆에 있는 행성끼리만 edge를 고려해주면 된다.  
이 때 x, y, z 각각에 대해 행성들을 정렬시켜 edge를 만들어주면 된다.  
- Edge 설정 코드
```swift
X.sort(by: {$0.1 < $1.1})
Y.sort(by: {$0.1 < $1.1})
Z.sort(by: {$0.1 < $1.1})
for i in 0..<n-1 {
    let currX = X[i], nextX = X[i+1]
    let currY = Y[i], nextY = Y[i+1]
    let currZ = Z[i], nextZ = Z[i+1]
    edge.append((n: currX.n, m: nextX.n, d: abs(currX.x - nextX.x)))
    edge.append((n: currY.n, m: nextY.n, d: abs(currY.y - nextY.y)))
    edge.append((n: currZ.n, m: nextZ.n, d: abs(currZ.z - nextZ.z)))
}
```
최종적으로 edge를 d 순으로 정렬해서 크루스칼 알고리즘을 적용시키면 해답을 구할 수 있다.
