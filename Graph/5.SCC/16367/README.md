# 백준 16367 TV Show Game
문제를 간략히 해석해보자면 k 개의 램프와 n 명의 참가자가 있을 때 각 참가자는 최대 3개 까지 램프의 색깔을 예측한다.  
이 때 램프의 색깔은 R, B 2가지로 각 참가자는 정답을 모른 채 예측을 해야한다.  
만약 한 참가자가 2개 이상의 정답을 맞춘다면 경품을 받을 수 있을 때 모든 참가자가 경품을 받는 k 개의 램프 색깔을 순서대로 출력하는 문제이다.  
  
3-SAT을 사용해야 하나 하고 착각할 수 있으나 2-SAT만으로 해결이 가능한 문제이다.  
만약 참가자가 예측한 것을 각각 A B C 라고 하자.  
이 때 2개 이상 예측 결과가 맞기 위해서는 (AVB), (BVC), (CVA) 세 묶음이 모두 참이 되야한다.  
따라서 모든 사람에 대해 2-SAT 간선 연결을 해주고 2-SAT 알고리즘을 사용해 구해주면 된다.  
- Edge Set Code
```swift
N1 = (C1 == "R" ? 2*N1-1 : 2*N1-2)
N2 = (C2 == "R" ? 2*N2-1 : 2*N2-2)
N3 = (C3 == "R" ? 2*N3-1 : 2*N3-2)
edge[NotOper(n: N1)].append(N2)
edge[NotOper(n: N2)].append(N1)
edge[NotOper(n: N2)].append(N3)
edge[NotOper(n: N3)].append(N2)
edge[NotOper(n: N1)].append(N3)
edge[NotOper(n: N3)].append(N1)
```
