# 백준 4013 ATM
어떤 출발장소에서 레스토랑 정점을 가려고 하는데 그래프 상의 모든 정점마다 현금 액수가 적혀있다고 하자.  
레스토랑은 여러 곳의 정점에 위치해 있으며 그 중 어떤 것을 가든 상관이 없다.  
이 때 정점에서 두번 이상 현금을 얻어낼 수 없다고 했을 때 레스토랑으로 이동하면서 얻어낼 수 있는 현금의 최대 액수를 구하는 문제이다.  
입력도 엄청나게 많고 문제 조건도 많아서 복잡하지만 하나하나 살펴보도록하자.  
먼저 그래프 상에는 사이클이 존재할 수 있기 때문에 사이클에 속하는 정점이라면 해당 사이클을 방문하면 사이클 내의 모든 돈을 챙길 수 있다.  
그렇다면 사이클을 나타내기 위해서 SCC 알고리즘을 사용해 표현해보자.  
하나의 SCC 집합에는 다음과 같은 정보들이 들어있다.  
```swift
var SCCTotalCash:[Int] = Array(repeating: 0, count: n+1) 
//해당 SCC집합의 모든 현금 액수
var SCCRestExist:[Bool] = Array(repeating: false, count: n+1) 
//SCC 집합 내에 레스토랑 존재여부
var SCCEdge:[Set<Int>] = Array(repeating: [], count: n+1) 
//SCC 집합 간의 edge관계
var SCCDP:[Int] = Array(repeating: -1, count: n+1) 
//현재 SCC집합에서 임의의 레스토랑을 방문할 떄 얻어낼 수 있는 현금의 최댓값
```
그렇다면 우리는 이제 이를 이용하여 문제를 풀어낼 것이다.  
SCC 집합을 구하고 해당 정보를 활용하기 위해 코사라주 알고리즘을 사용했다.  
이때 dfsBack 함수를 다음과 같이 수정하도록 하자.  
- DFSBack Function
```swift
func dfsB(n: Int, sNum: Int) {
    SCC[n] = sNum
    SCCTotalCash[sNum] += atm[n]
    if rest[n] {
        SCCRestExist[sNum] = true
    }
    for e in edgeB[n] {
        if SCC[e] == 0 {
            dfsB(n: e, sNum: sNum)
        }
        else if SCC[e] != sNum {
            SCCEdge[SCC[e]].insert(sNum)
        }
    }
}
```
먼저 SCCTotalCash는 dfs 과정중 방문하는 정점의 현금 액수를 더해주고 방문 정점 중 하나라도 레스토랑에 해당한다면 SCCRestExist 값을 true로 설정해준다.  
위상 관계상 먼저 와야 하는 SCC를 먼저 방문할 것이기 때문에 본인의 SCC와 SCC번호가 다른 집합을 발견한다면 본인의 SCC집합으로 들어오는 edge를 만들어준다.  
- DFS DP Function
```swift
func dfsSCC(n: Int) -> Int {
    if SCCDP[n] != -1 {
        return SCCDP[n]
    }
    else {
        var tmp = 0
        for e in SCCEdge[n] {
            tmp = max(tmp, dfsSCC(n: e))
        }
        if tmp != 0 || SCCRestExist[n] {
            tmp += SCCTotalCash[n]
        }
        SCCDP[n] = tmp
        return tmp
    }
}
```
이제 해당 정보들을 가지고 SCCDP 배열을 채워 줄 것이다.  
유의할 것은 dp과정에서 restaurant 존재여부를 고려해주는 부분이다.  
본인의 영역에 레스토랑이 존재한다면 본인의 영역의 total cash를 더해준다.  
만약 edge로 이동해 다른 영역에서 구해낸 tmp값이 0이 아니라면 해당 경로로 이동하면 무조건 레스토랑에 도달할 수 있기 때문에 본인 영역의 total cash 값을 더해줄 수 있다.  
SCCDP의 의미는 현재 SCC집합에서 임의의 레스토랑을 방문할 떄 얻어낼 수 있는 현금의 최댓값이기 때문에 시작 정점이 포함된 SCC의 DP값을 알아내면 원하는 답을 구할 수 있게 된다.  
