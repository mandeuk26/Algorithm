# 강한 결합 요소 (Strongly Connected Component)
강한 결합 요소란 서로 긴밀하게 연결된 그래프내의 집합을 의미한다.  
여기서 긴밀하게 연결되어있다는 것은 서로 도달이 가능하다는 것을 의미한다.  
즉, 같은 SCC내에 속하는 모든 두 정점은 서로를 향한 경로가 있다는 것이다.  
만약 방향이 없다면 모든 정점은 서로를 향한 경로가 있을 것이기에 방향 그래프에서만 의미가 있다는 것을 알아두자.  
SCC를 구하는 알고리즘으로는 크게 코사라주와 타잔 알고리즘이 있다.  
## 1. 코사라주 알고리즘
우리는 그래프를 정방향 그래프와 역방향 그래프 2개를 준비할 것이다.  
역방향 그래프란 기존 그래프의 간선 방향을 정반대로 만든 그래프이다.  
먼저 정방향 그래프에 대해 dfs를 해서 오일러 투어를 실행할 것이다.  
오일러 투어란 간단하게 설명하자면 dfs로 그래프를 순회할 때 정점에 대해서 방문할 때 inOrder번호를 부여하고 빠져나올 때 outOrder번호를 부여하는 것을 말한다.  
다음 그림을 보면 이해하기 쉬울 것이다.  

<img width="309" alt="eulertour" src="https://user-images.githubusercontent.com/78075226/120789886-29e65480-c56d-11eb-861c-4ac785860511.png">

실제로는 inOrder는 필요하지 않기 때문에 dfs를 빠져나올 때에만 order번호를 부여했다.  
ft라는 finish time 순으로 노드를 저장해주는 배열에 order가 작은 노드부터 저장을 시켜주었다.  
- DFS Front Function
```swift
func dfsF(n: Int) {
    check[n] = true
    for e in edgeF[n] {
        if !check[e] {
            dfsF(n: e)
        }
    }
    ft[index] = n
    index += 1
}
```
그 후 outOrder가 큰 순으로 역방향 그래프에서 dfs를 다시 시행시킨다.  
앞에서 구한 ft 배열을 끝에서부터 차례대로 방문하면 된다.  
이 때 하나의 노드에서 dfs로 방문하는 모든 노드들은 하나의 SCC가 된다.  
SCC배열은 각 노드별로 몇번째 SCC에 속하는지를 나타내주는 배열이다.  
- DFS Back Function
```swift
func dfsB(n: Int, scc: Int) {
    SCC[n] = scc
    for e in edgeB[n] {
        if SCC[e] == 0 {
            dfsB(n: e, scc: scc)
        }
    }
}
```
유의할 것은 dfsF 함수나 dfsB 함수가 한번 실행하면 모든 노드를 방문하는 것이 아니기 때문에 for문으로 아직 방문한 적이 없는 노드를 만날때마다 실행시켜줘야 한다는 것이다.  
- main 함수 중 일부
```swift
for i in 0..<n {
    if !check[i] {
        dfsF(n: i)
    }
}
//dfsF에서는 check 배열로 방문여부 확인
for i in 0..<n {
    let node = ft[n-1-i]
    if SCC[node] == 0 {
        scc += 1
        dfsB(n: node, scc: scc)
    }
}
//dfsB에서는 SCC번호가 노드에 부여되어있는지로 확인
```
위의 그래프에 SCC를 적용하면 다음과 같이 바뀐다.  

<img width="371" alt="SCC" src="https://user-images.githubusercontent.com/78075226/120789990-4edac780-c56d-11eb-8476-d37dbacf0182.png">

놀라운 것은 SCC 집합을 하나의 노드로 보면 사이클이 없는 방향 그래프가 생성된다는 것이다.  
또한 SCC 집합을 하나의 노드로 보았을 때 위상정렬에서 먼저 오는 노드는 SCC 번호 순으로도 먼저 오게된다.  
이를 활용하여 SCC와 위상정렬이 결합된 문제들이 많이 나온다.  
  
이제 코사라주가 만드는 SCC의 유효성에 대해 증명을 할 것이다.  
코사라주가 만든 SCC가 유효하려면 번호가 늦게 생성된 SCC에서 먼저 생성된 SCC로 가는 edge가 존재하지 않음을 보이면 된다.  
아까 위에서 구한 SCC 그래프에서 설명해보면 SCC3에서 SCC1나 2로 가는 edge가 없어야한다는 소리이다.  
그렇다면 두 SCC간에 edge가 존재한다고 하자.  

<img width="366" alt="SCCproof" src="https://user-images.githubusercontent.com/78075226/120790044-61ed9780-c56d-11eb-9f47-5647a787ba48.png">

위 그림을 보면 back DFS를 하는 과정에서 SCC2를 먼저 방문할 것이다.  
하지만 새롭게 추가된 빨간 간선에 의해 back DFS과정에서 SCC3까지 방문하게 된다.  
따라서 SCC3이라는 집합이 존재하지 못하게 되고 가정이 모순이 되어서 SCC3에서 SCC2로 가는 간선은 존재할 수 없다는 결론이 나오게 된다.  
이로써 코사라주 알고리즘의 유효성이 증명되었다.  
## 2. 타잔 알고리즘
이번에는 코사라주와 조금 다른 타잔 알고리즘에 대해 설명하겠다.  
핵심 개념은 dfs로 하나씩 정점을 방문하면서 stack에 노드를 집어넣을 것인데 부모라는 정보를 활용해서 SCC를 구한다는 것이다.  
다음 그림을 보면서 이해해보자.  

<img width="497" alt="tarjan1" src="https://user-images.githubusercontent.com/78075226/120795085-fe1a9d00-c573-11eb-8c46-dc5686654ea3.png">

먼저 1번 정점부터 순차적으로 dfs를 해서 4번으로 이동한다.  
이 때 처음에 모든 정점은 부모로 자기 자신을 가리키도록 한다.  

<img width="488" alt="tarjan2" src="https://user-images.githubusercontent.com/78075226/120795112-07a40500-c574-11eb-87a7-4fb419b3db1f.png">

4번에서 2번을 바라봤을때 SCC그룹에 속해있지 않고 방문한 적이 있는 정점이기 때문에 해당 정점의 부모값과 본인의 부모값을 비교해서 더 작은 값을 본인의 부모로 삼아준다.  
그 후 더이상 새 경로를 탐색할 수 없으므로 가지고 있던 부모값을 return 한다.  
3번 노드는 return 받은 부모값이 본인이 갖고 있는 값보다 작으므로 부모값을 2로 바꿔준다.  

<img width="487" alt="tarjan3" src="https://user-images.githubusercontent.com/78075226/120795134-0ffc4000-c574-11eb-910e-fb6203c676cb.png">

3번은 추가적인 경로가 존재하므로 경로를 타고 들어가 7번 정점까지 방문한다.  

<img width="480" alt="tarjan4" src="https://user-images.githubusercontent.com/78075226/120795141-12f73080-c574-11eb-8195-ce055f1a0263.png">

7에서 5를 바라봤을때 위와 동일하게 부모값을 변경하고 반환해준다.  
그 결과 5까지 돌아가게 되는데 5는 부모값과 본인이 동일하기 때문에 스택에서 본인이 나올때까지 pop해준다.  

<img width="482" alt="tarjan5" src="https://user-images.githubusercontent.com/78075226/120795150-15598a80-c574-11eb-9c93-29780a8d3a0e.png">

5, 6, 7이 하나의 그룹이 되고 마찬가지로 3에서 2로 돌아간다.  
2도 부모와 본인이 동일하기 때문에 stack에서 pop해준다.  

<img width="492" alt="tarjan6" src="https://user-images.githubusercontent.com/78075226/120795155-17234e00-c574-11eb-8c00-2aa588a513f5.png">

2, 3, 4가 하나의 그룹이 되고 마찬가지로 1도 동일하게 처리해준다.  

<img width="427" alt="tarjan7" src="https://user-images.githubusercontent.com/78075226/120795161-18547b00-c574-11eb-831d-0295920b584c.png">

최종적으로 코사라주와 동일한 SCC 그래프를 얻게된다.  
다만 코사라주와 반대로 위상 정렬에서 마지막에 처리해야 할 SCC가 먼저 얻어진다.  
유효성을 증명해보자면 코사라주와 동일하게 7 -> 4로 가는 선분이 있다고 생각했을 때 알고리즘을 계산해보면 두 SCC 그룹이 결국에는 하나가 되야하고 서로다른 SCC 그룹이라는 가정에 어긋나기 때문에 타잔의 알고리즘이 유효하다는 것을 증명할 수 있다.  
## 3. 2-SAT
다음과 같은 논리식이 주어진다고 했을 때  
  
f = (x<sub>1</sub> V x<sub>2</sub>) &Lambda; (x<sub>1</sub> V ~x<sub>2</sub>) &Lambda; (~x<sub>1</sub> V x<sub>3</sub>) &Lambda; (~x<sub>1</sub> V ~x<sub>3</sub>)   
  
해당 논리식이 참이되는 해가 존재하는지, 그렇다면 그 해는 무엇인지 구할 때 2-SAT 문제를 푼다고 한다.  
여기서 각 원소는 bool 값을 가지며 V는 or를 의미하고  &Lambda;은 and를 의미한다.  
`(x1 V x2)`라는 원소의 의미는 전체 식이 참이 되기 위해서 x<sub>1</sub>이 false라면 x<sub>2</sub>가 true가 되거나 x<sub>2</sub>가 false라면 x<sub>1</sub>이 참이 되어야 함을 의미한다.  
따라서 두 x값 간에 선행조건이 생기게 되고 이는 위상정렬 문제로 생각할 수 있다.  
false를 표현하기 위해서 우리는 등장하는 모든 x<sub>n</sub>에 대해 true node와 false node 2개를 생성해준다.  
예를 들자면 ~x<sub>1</sub> -> x<sub>2</sub> 로 간선을 긋고 ~x<sub>2</sub> -> x<sub>1</sub>로 간선을 그어준다.  
이를 식에 등장하는 모든 관계에 대해 간선을 그어준다.  
- 간선 설정 코드
```swift
for _ in 0..<m {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    var N1 = line[0], N2 = line[1]
    N1 = (N1 < 0 ? -(2*N1) : 2*N1-1)
    N2 = (N2 < 0 ? -(2*N2) : 2*N2-1)
    edge[makeNot(n: N1)].append(N2)
    edge[makeNot(n: N2)].append(N1)
}
//makeNot은 x값에 대해서 다른 부호를 갖는 노드로 바꿔주는 역할을 한다. true -> false / false -> true
```
그래프를 성공적으로 만들었다면 주어진 논리그래프에 대해 SCC를 구한다.  
만약 하나의 SCC에 x<sub>1</sub>와 ~x<sub>1</sub>가 모두 속한다고 생각해보자.  
그럴 경우 x<sub>1</sub>은 true도 되야하고 false도 되야한다.  
따라서 모든 x값에 대해서 true 노드와 false 노드가 한 SCC에 속하지 않는지를 확인하면 f라는 식을 참으로 만드는 해가 존재하는지 확인할 수 있다.  
  
실제 해를 구하고자 한다면 위상정렬 상에서 앞에 오는 SCC부터 차례대로 그 해를 구하면 된다.  
각 x에 대해서 true 노드가 먼저 등장하면 그 해를 false로 false 노드가 먼저오면 x값을 true로 설정한다.  
이 부분이 참 중요한데 선행 조건이 없다면 bool식을 false로 만들도록 해야한다.  
`(x1 V x2)`라는 조건과 ~x<sub>1</sub> -> x<sub>2</sub>라는 간선을 다시 생각해보자.  
이 간선의 의미는 x<sub>1</sub>이 false가 되버린다면 x<sub>2</sub>는 무조건 참이여야 한다는 것을 의미한다고 했다.  
그렇다면 x<sub>1</sub>이 true가 되버린다면? x<sub>2</sub>가 무엇이 오든 아무 문제가 없는 것이다.  
따라서 그래프 상에서 선행 조건이 없는 노드를 만난다면 해당 노드를 false가 되도록 설정해주면 뒤에 등장하는 조건식에 아무런 영향을 미치지 않기 때문에 적합한 해를 찾을 수 있다.  
