# 백준 13161 분단의 슬픔
n 명의 사람이 A진영과 B진영으로 나뉘어 들어갈 때 각 사람이 서로 다른 진영에 들어갈 때 슬픔 정도 w가 주어진다고 하자.  
슬픔 정도의 합이 최소가 되도록 사람들을 A진영과 B진영으로 나누는 방법을 구하는 문제이다.  
문제를 풀기전에 다음 이론 하나만 보고 가자.  
## Max Flow Min Cut
> 그래프의 선분들을 잘라내어 정점들을 2개의 서로 다른 집합으로 나누는 방법 중 가중치의 합이 최소일 때를 min cut이라고 하면 그 값은 max flow와 같다.

생각해보면 min cut에 포함된 간선들을 따라서 유량이 흐른다고 했을 때 min cut의 값은 간선들의 capacity의 합과 같다.  
모든 유량은 결국 min cut에 포함된 간선들의 capacity합을 넘을 수 없게 된다.  
따라서 해당 그래프의 최대 유량은 min cut과 같은 값을 갖게 되는 것이다.  
  
## 문제 풀이
다시 문제로 돌아와서 우리는 A진영에 속한 사람과 B진영에 속한 사람들의 슬픔 정도의 합의 최소를 찾고싶다.  
모든 사람들을 하나의 정점으로 보고 서로간의 슬픔 정도를 capacity로 갖는 간선을 그린다고 하자.  
이 경우 최대 유량을 구하면 capacity의 최소컷을 구할 수 있게 되고 이는 사람들을 A진영과 B진영으로 나누는 슬픔정도의 합과 같게 된다.  
  
source와 sink는 어떻게 처리해야 할지에 대해 고민이 될 수 있다.  
만약 A진영에 속한 사람과 source간에 capacity를 INF로 주고 B진영에 속한 사람과 sink간에 capacity를 INF로 준다고 하자.  
그러면 A진영에 속해야 하는 사람은 INF를 min cut에 포함시킬 순 없기 때문에 무조건 A진영에 속하게 되고 B진영에 속해야 하는 사람은 무조건 B진영에 속할 수 있게 된다.  
  
모든 V간에 edge가 연결되어 있는 형태이기 때문에 E의 갯수가 굉장히 크게 된다.  
따라서 edmond 알고리즘을 쓰면 시간 초과가 나타나서 dinic 알고리즘을 활용하였다.  
파일의 입력이 크기때문에 fread를 해줘야 시간초과가 안난다. 관련 코드는 JCSooHwanCho님의 FileIO.swift 를 참조하였다.  
<출처 : https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88>

