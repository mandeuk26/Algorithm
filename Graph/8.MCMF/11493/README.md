# 백준 11493 동전 교환
정점이 주어지고 정점간의 간선들이 주어진다고 하자.  
각 정점마다 B/W 색깔이 존재하고 각 정점마다 동전이 하나씩 존재한다고 했을 때 동전 역시 색깔이 B/W로 존재한다고 하자.  
만약 동전과 정점의 색깔이 일치하지 않을 경우 동전을 주위 정점과 바꾸어가면서 모든 정점과 동전의 색깔을 일치하게 만든다고 할 때 최소 동전 교환 횟수를 구하는 문제이다.  
  
굉장히 풀기 어려운 문제....  
동전 교환 문제를 MCMF 그래프로 전환시키기 매우 어려운 문제이다.  
먼저 우리는 동전을 교환하는 최솟값을 구해야하기 때문에 cost값이 동전 교환 횟수가 되야함을 알 수 있다.  
따라서 각 간선마다 cost 비용을 1로 설정해주면 해당 간선을 따라 동전을 교환할 시 횟수만큼 cost 값이 증가함을 알 수 있다.  
`cost[u][v] = 1`  
  
그렇다면 간선을 따라서 동전을 교환하는 행위를 flow라고 했을 때 동일한 간선에서 몇번이고 일어날 수 있기 때문에 capacity를 INF로 설정해줘야 함을 짐작할 수 있다.  
`capacity[u][v] = INF`  
  
최종적으로 동전과 정점의 색깔이 다른 정점들만을 골라내서 동전이 흑색일 경우 source와 capacity = 1, cost = 0의 연결을 하고 백색일 경우 sink와 동일하게 연결해 준다.  
생각해보면 흑색 동전이 백색 동전의 위치로 이동하는 문제이기 때문에 이렇게 설정해 주었다.  
Flow/Capacity를 표기해서 문제에 주어진 예시의 그래프를 다시 그려보면 다음과 같다.  

<img width="636" alt="11493" src="https://user-images.githubusercontent.com/78075226/121222610-a9ec2180-c8c1-11eb-9a92-645379e7cb5a.png">

따라서 흑색 동전을 따라 flow가 흐르면 그래프 내부에서 여러 정점을 돌아다니면서 flow가 흘러가고 그 때 최소 횟수만에 백색 동전의 위치에 도착하는 경우는 MCMF 알고리즘으로 minimum cost를 구해내는 것과 같다는 것을 알 수 있다.  
