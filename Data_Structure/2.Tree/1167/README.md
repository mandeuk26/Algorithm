# 백준 1167 트리의 지름
트리의 지름이란 트리에서 임의의 두 점 사이의 거리 중 가장 긴 것을 구하는 문제이다. 트리의 루트가 무엇인지 알려주지 않았지만 트리는 어떤 노드를 루트로 잡더라도 새롭게 트리를 구성할 수 있기 때문에 큰 상관이 없다.  
  
먼저 임의의 점으로부터 가장 먼 노드를 먼저 찾는다. 그 후 해당 노드로부터 가장 먼 지점을 찾으면 된다. 이것이 가능한 이유는 어떤 점을 시작점으로 잡더라도 가장 먼 노드를 찾았을 때 트리의 지름에 해당하는 두 노드 중 하나를 가장 먼 노드로 찾게될 것이기 때문이다. 트리 탐색은 dfs로 구현을 하였다.
