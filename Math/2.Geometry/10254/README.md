# 백준 10254 고속도로
2차원 평면 위에 n개의 도시들이 주어지면 n개의 도시 중 유클리드 거리가 가장 먼 두 도시를 찾는 문제이다.  
컨벡스 헐로 점들을 감쌌을 때 점 사이의 최대 거리는 컨벡스 헐 꼭지점 사이에서만 존재할 수 있다는 개념을 활용한 문제이다.  
  
여기서 로테이팅 캘리퍼스라는 알고리즘이 사용된다.  
컨벡스 헐 상의 점들에 대해서 가장 먼 거리는 마치 캘리퍼스를 돌리듯이 확인하는 과정을 통해 쉽게 구할 수 있다는 알고리즘이다.  
신기하게도 모든 점들간의 거리를 확인해주면 O(n<sup>2</sup>)의 시간이 걸리지만 로테이팅 캘리퍼스를 활용하면 O(n)만에 해결이 가능하다.  
핵심 아이디어는 임의의 점을 잡았을 때 가장 먼 거리는 임의의 점과 맞다는 상태로 캘리퍼스로 도형을 돌린다고 했을 때 만나게 되는 점들 중에 하나라는 점이다.  

<img width="971" alt="10254" src="https://user-images.githubusercontent.com/78075226/122667629-c441cb80-d1ee-11eb-92c0-f1e9e734c1b9.png">

위의 그림은 로테이팅 캘리퍼스를 하는 과정 중 일부이다.  
실제로 오각형 중 최하단 좌측에 위치한 점으로부터 가장 멀리있는 점의 거리는 첫번째 그림과 두번째 그림의 경우 중 하나에 해당한다.  
자세히 보면 최하단 좌측 점은 항상 캘리퍼스 양 끝 선에 맞닿은 채로 확인하고 있다는 것을 알 수 있다.  
  
최종적으로 모든 점들간의 거리를 확인해 줄 필요없이 임의의 점을 기준으로 본인과 가장 멀리있는 점들만 확인하게 된다.  
따라서 한 점당 한번씩 방문을 하게되기 때문에 O(n)의 시간이 걸리게 된다.  
  
파일의 입력이 크기때문에 fread를 해줘야 시간초과가 안난다. 관련 코드는 JCSooHwanCho님의 FileIO.swift 를 참조하였다.
<출처 : https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88>