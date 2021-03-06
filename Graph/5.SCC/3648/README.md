# 백준 3648 아이돌
심사위원들이 두 사람에 대해 찬성 혹은 반대의 의견을 낸다고 했을 때 적어도 하나의 의견은 투표 결과에 영향을 미쳐야한다고 하자.  
이 때 상근이가 진출하도록 투표결과를 조작했을 때 심사위원들이 의심하지 않도록 할 수 있는지 여부를 알아내는 문제이다.  
  
두 개의 의견 중 하나가 결과에 영향을 미쳐야 한다는 소리는 2-sat에서 두 개의 의견을 하나로 묶는 것과 같다.  
즉 최소한 둘 중 하나가 참이 되도록 해야한다는 소리이다.  
따라서 모든 심사위원의 의견에 대해 2-sat 그래프를 만들어주고 상근이를 합격이 되게 했을 때 2-sat 그래프가 참이 될 수 있는지를 알아내면 된다.  
  
앞에서 쓴 2-SAT 알고리즘에 상근이가 불합격 한 경우에서 합격한 경우로 edge 하나만 추가해주자.  
`edge[NotOper(n: 0)].append(0)`  
2-sat 해를 구할 때 먼저 등장하는 케이스에 대해 false가 되도록 해를 구한다는 것을 기억할 것이다.  
따라서 탈락하는 경우가 위상상 먼저 등장하게 되면 탈락이 false가 되기 때문에 상근이를 합격시킬 수 있게 된다.  
최종적으로 그래프의 해가 존재하는지만 파악해주면 문제를 해결할 수 있다.  
