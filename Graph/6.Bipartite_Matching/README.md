# 이분 매칭 (Bipartite Matching)
정점을 두 그룹으로 나누었을 때 모든 간선에 연결된 두 정점이 서로 다른 그룹에 속하는 그래프를 이분 그래프라고 부른다.  
이분 그래프에서 각 그룹의 정점이 1번씩만 연결될 수 있다고 했을 때 선택 할 수 있는 최대 간선의 수를 구하는 문제를 이분 매칭 문제라고 부른다.  
  
예를 들어 4명의 사람이 있고 4종류의 사탕이 1개씩 있다고 했을 때 각 사람마다 선호하는 사탕이 있다고 하자.  
그렇다면 최대한 많은 사람에게 선호하는 사탕을 나눠준다고 했을 때 몇 명이 선호하는 사탕을 받을 수 있는지를 구하는 문제를 생각해보자.  
```
A : 1, 2, 3번 사탕을 먹고 싶어
B : 1, 2번 사탕을 먹고 싶어
C : 1번 사탕을 먹고 싶어
D : 4번 사탕을 먹고 싶어
```
먼저 문제를 이분 그래프로 표현하면 다음과 같다.   

<img width="335" alt="bipartite" src="https://user-images.githubusercontent.com/78075226/120968873-6c45a680-c7a4-11eb-939d-ae5fbe19cc1d.png">


우리는 이를 구하기 위해 dfs를 활용한 풀이를 사용할 것이다.  
핵심 아이디어는 왼쪽 그룹에서 하나씩 매칭할 수 있는 정점을 찾는데 매칭하고자 하는 정점이 이미 매칭되어 있다면 앞서 매칭을 마친 정점들을 다른 매칭으로 옮길 수 있다면 옮기고 매칭하고자 했던 정점끼리 연결시켜준다는 것이다.  
만약 옮길 수 없다면 다른 정점을 찾아보고 연결 가능한 모든 정점에 대해 불가능하다면 왼쪽 그룹에서 해당 정점 순서를 넘어간다.  
그림을 보며 이해해보자.  

<img width="328" alt="bipartite1" src="https://user-images.githubusercontent.com/78075226/120969878-a95e6880-c7a5-11eb-913c-d5e7f90281a3.png">

먼저 A를 매칭 시킬 수 있는 정점을 찾고 매칭시켜준다.  

<img width="328" alt="bipartite2" src="https://user-images.githubusercontent.com/78075226/120969870-a794a500-c7a5-11eb-88d7-def46aea56e0.png">

이제 B를 매칭 시킬 정점을 찾을 것이다.  
그런데 첫번째로 확인한 정점이 1번 정점이다.  
이는 이미 A와 매칭되어 있기 때문에 A로 돌아가서 A가 매칭시킬 수 있는 새로운 정점을 찾는다.  

<img width="344" alt="bipartite3" src="https://user-images.githubusercontent.com/78075226/120969890-acf1ef80-c7a5-11eb-80ae-4e4df38b8d78.png">

다행히 A는 2번과 매칭이 가능하기 때문에 A와 2번을 매칭시켜주고 B와 1번을 매칭 시켜준다.  

<img width="333" alt="bipartite4" src="https://user-images.githubusercontent.com/78075226/120969889-ac595900-c7a5-11eb-9520-768ced6db70c.png">

이번에는 C차례인데 마찬가지로 이미 B가 매칭이 되어있다.  

<img width="335" alt="bipartite5" src="https://user-images.githubusercontent.com/78075226/120969886-ab282c00-c7a5-11eb-8f69-e09e8859353f.png">

따라서 B를 2번과 매칭시켜주려하는데 이미 A와 매칭되어 있기 때문에 A와 다른 정점 매칭이 가능한지를 확인한다.  

<img width="335" alt="bipartite6" src="https://user-images.githubusercontent.com/78075226/120969887-abc0c280-c7a5-11eb-908f-ca992112ece6.png">

다행히 A와 3이 매칭이 가능하기 때문에 A와 3, B와 2, C와 1를 매칭시켜준다.  

<img width="328" alt="bipartite7" src="https://user-images.githubusercontent.com/78075226/120969884-aa8f9580-c7a5-11eb-9cfc-8911a6ec4118.png">

D의 경우 4번과 바로 매치가 가능하기 때문에 연결시켜주고 마무리 시킨다.  
전체 매칭의 갯수는 4개로 문제의 답을 구할 수 있게 된다.  
코드로 나타내면 다음과 같고 생각보다 간단하기 때문에 금방 이해할 수 있을 것이다.  
```swift
let n = 4, m = 4
var visited:[Bool] = Array(repeating: false, count: m+1)
var match:[Int] = Array(repeating: -1, count: m+1)
var edge:[[Int]] = Array(repeating: [], count: n+1)
var maxMatch = 0

func dfs(indexA: Int) -> Bool {
    for e in edge[indexA] {
        if visited[e] {
            continue
        }
        visited[e] = true
        //visited란 이전 노드들을 새롭게 매칭시킬 때 피해야할 노드들을 가르킨다.
        
        if match[e] == -1 || dfs(indexA: match[e]) {
        //이미 match된 정점이 없거나 이미 match된 정점들이 다른 매칭을 선택할 수 있을 때
            match[e] = indexA
            return true
        }
    }
    return false
}

//edge에 대해서 따로 설정 필요

for i in 1...n {
    visited = Array(repeating: false, count: m+1)
    //visited는 매번 초기화 시켜줘야한다. (그래야 이전 정점들이 새로운 정점을 선택할 수 있다.)
    if dfs(indexA: i) {
        maxMatch += 1
    }
}
```
