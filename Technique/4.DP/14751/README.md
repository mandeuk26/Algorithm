# 백준 14751 Leftmost Segment
최하단과 최상단의 y좌표가 주어졌을 때 h<sub>upper</sub>와 h<sub>lower</sub> 상에 점이 있어 두 점을 이은 직선들이 주어진다고 하자. 이 때 h<sub>upper</sub>와 h<sub>lower</sub> 사이의 y값이 주어질 때 만나게 되는 가장 왼쪽의 선분의 h<sub>upper</sub>상의 값을 출력하는 문제이다.  
먼저 컨벡스 헐 트릭을 적용시키면 가장 왼쪽의 선분을 구하는데 용이할 것이다. 컨벡스 헐을 적용시키기 위해 그림을 90도 반시계 방향으로 회전시켜 h<sub>upper</sub>를 x = 0 선분으로 생각하고 시작하였다. 그 후 수많은 입력 선분들을 기울기가 감소하는 순서로 정렬시킨 후 컨벡스 헐 트릭을 적용했다. 직선의 `up 좌표`는 **절편**이 될 것이고 **기울기**는 `(down-up)/(Ymax-Ymin)`으로 표현될 것이다.
- line insert 함수
```swift
var stack:[line] = Array(repeating: line(), count: 100001)
var sz = 0
func insert(v: line) {
    stack[sz] = v
    while sz != 0 && (stack[sz].down-stack[sz].up) == (stack[sz-1].down-stack[sz-1].up) && stack[sz].up < stack[sz-1].up {
        stack[sz-1] = stack[sz]
        sz -= 1
    }
    while sz > 1 && compare3(p: sz-2, q: sz-1, r: sz){
        stack[sz-1] = stack[sz]
        sz -= 1
    }
    sz += 1
}
```
먼저 컨벡스 헐 트릭의 핵심이 되는 line insert 함수이다. 앞에서 설명했듯이 이전 직선이 필요없어지면 sz를 감소시켜 해당 위치에 새로운 직선을 배치하는 방식으로 구현했다. 단 기울기가 같으면 절편값을 이용해 비교해 주었다. compare3함수는 세 직선을 비교해 가운데 직선을 삭제해도 될지 결정해주는 함수이다.  
- query 처리 함수
```swift
func sol(x: Double) -> Int {
    var lo = 0, hi = sz-1
    while lo < hi {
        let mid = (lo+hi)/2
        if compareX(p: mid, q: mid+1, x: x) {
            lo = mid+1
        }
        else {
            hi = mid
        }
    }
    return stack[hi].idx
}
```
유의해야할 것은 입력으로 들어오는 쿼리가 Q[i] < Q[i+1]을 만족하지 않는다는 것이다. 따라서 이분탐색을 통해서 적합한 직선을 찾아주고 직선의 index값을 출력해주어야한다. 
