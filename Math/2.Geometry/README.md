# 기하학
## 1. CCW(Counter Clock Wise)
수학에서 외적의 개념을 적용한 알고리즘을 CCW 알고리즘이라고 종종 부른다.  
벡터의 외적은 두 벡터 u = (x1, y1, z1), v = (x2, y2, z2)가 주어진다면 다음과 같이 정의된다.  
`u x v = (y1z2 - z1y2, z1x2 - x1z2, x1y2 - y1x2)`  
외적을 함수로 구현하면 다음과 같다.  
여기서는 벡터를 받은 것이 아니라 임의의 세 점 P (x1, y1, z1), Q (x2, y2, z2), R (x3, y3, z3)을 입력으로 받는다.  
```swift
func ccw(x1: Int, x2: Int, x3: Int, y1: Int, y2: Int, y3: Int, z1: Int, z2: Int, z3:Int) -> (Int, Int, Int){
    let A = (x:x2-x1, y:y2-y1, z:z2-z1)
    let B = (x:x3-x1, y:y3-y1, z:z3-z1)
    let AxB = (A.y*B.z - A.z*B.y, A.z*B.x - A.x*B.z, A.x*B.y - A.y*B.x)
    return AxB
}
```
놀랍게도 외적을 2차원상에서 정의하면 외적은 z값은 모두 0이되고 AxB의 3번째 항만이 의미를 갖는다.  
2차원 상에서 세점이 주어졌을 때 외적은 다음과 같은 2가지 경우로 구분된다.  

<img width="673" alt="ccw" src="https://user-images.githubusercontent.com/78075226/122367012-096bc080-cf97-11eb-835f-e03b404e8b14.png">

첫번째 케이스의 경우 외적의 결과값이 양이 나오고 두번째 케이스의 경우 외적의 결과값이 음이 나오게 된다.  
따라서 외적의 부호에 따라서 세 점의 위치관계를 알 수 있다.  
만약 외적값이 양수라면 P, Q, R을 순서대로 이은 선분이 반시계 방향이고 음수라면 시계 방향이 되고 0 이라면 일직선을 이룬다.  
## 2. 컨벡스 헐
2차원 평면에 많은 점들이 주어졌을 때 해당 점들을 모두 포함하는 다각형을 그리려한다 생각해보자.  
그 중 다각형의 모든 내각이 180도 이하인 것을 볼록 다각형이라 부른다.  
그러면 몇 개의 점을 골라 볼록 다각형을 만들었을 때 나머지 모든 점들이 다각형 내부에 포함되도록 만들 수 있다.  
이를 컨벡스 헐 알고리즘이라 부른다.  
볼록다각형은 다음의 특징을 갖는다.  
```
1. 모든 내각이 180도 미만이기에 볼록다각형의 선분들을 반시계 방향으로 살펴볼 때 연속된 두 선분은 ccw 값이 항상 양수이다.
2. 가장 좌측 하단의 점을 기준으로 나머지 점들을 이은 선분들은 기울기가 점차 증가하는 형태이다.
```
이를 활용해서 컨벡스 헐을 만들기 위해 먼저 모든 점들중에서 가장 좌측 하단에 위치한 점을 선택한다.  

<img width="507" alt="convecs1" src="https://user-images.githubusercontent.com/78075226/122379680-0a561f80-cfa2-11eb-9ed5-5b6fd59aac2c.png">

그 점을 기준으로 나머지 점들을 기울기 순으로 정렬한다.  

<img width="510" alt="convecs2" src="https://user-images.githubusercontent.com/78075226/122379707-1215c400-cfa2-11eb-9dc9-9bd58e2f2baf.png">

이제 기울기가 작은 점부터 하나씩 살펴볼 것이다.  
stack에 점들을 하나씩 넣어둘것인데 만약 stack에 점이 2개 미만이라면 점을 무조건 추가해준다.  
만약 stack에 점이 2개 이상 들어있다면 stack의 top과 stack의 두번째 top, 새로운 점에 대해서 ccw를 해준다.  
볼록다각형의 조건을 만족한다면 해당 각은 180도 미만으로 외적의 값이 양수가 나타날 것이다.  

<img width="493" alt="convecs3" src="https://user-images.githubusercontent.com/78075226/122379710-1215c400-cfa2-11eb-9106-26ffd66c60f4.png">

따라서 세번째 점을 추가하고 다음 순서의 점에 대해서 과정을 반복해준다.  
순서대로 반복한다면 다섯번째 점까지 stack에 추가할 수 있게 된다.  

<img width="494" alt="convecs4" src="https://user-images.githubusercontent.com/78075226/122379712-12ae5a80-cfa2-11eb-990c-b34613b72ce7.png">

<img width="497" alt="convecs5" src="https://user-images.githubusercontent.com/78075226/122379713-1346f100-cfa2-11eb-8153-f73ada838643.png">

여섯번째 점과 stack top의 두 점에 대해서 ccw를 하였더니 이번에는 음수가 나타났다.  
실제로도 내각이 180도 이상인 형태로 점이 등장했다.  
컨벡스 헐은 내각이 180도 이하여야하기 때문에 뭔가 조치가 필요하다는 것을 알 수 있다.  
만약 ccw값이 음수가 나온다면 stack의 top을 pop해준다.  

<img width="506" alt="convecs6" src="https://user-images.githubusercontent.com/78075226/122379715-1346f100-cfa2-11eb-9e26-4c831762c580.png">

다시한번 스택의 top의 두 점과 여섯번째 점에 대해서 ccw를 해준다.  
마찬가지로 음수가 등장하기 때문에 stack의 top을 pop해준다.  

<img width="487" alt="convecs7" src="https://user-images.githubusercontent.com/78075226/122379717-13df8780-cfa2-11eb-8f3f-7d816c0fc9ee.png">

드디어 ccw값이 양수가 나타나 점을 stack에 push해준다.  
놀랍게도 삭제한 두 점은 현재 stack에 있는 점들로 다각형을 만들었을 때 그 내부에 위치한다.  
기울기가 증가하는 형태로 점들을 살펴보고 있기 때문에 새롭게 등장하는 점이 이전의 점들을 cover할 수 있게 된다.  

<img width="494" alt="convecs8" src="https://user-images.githubusercontent.com/78075226/122379721-14781e00-cfa2-11eb-8ab1-712c26e5cc80.png">

<img width="501" alt="convecs9" src="https://user-images.githubusercontent.com/78075226/122379723-1510b480-cfa2-11eb-9e57-ac3d5482089e.png">

최종적으로 마지막 점까지 과정을 반복해주면 다음과 같은 컨벡스 헐이 등장한다.

<img width="491" alt="convecs10" src="https://user-images.githubusercontent.com/78075226/122379725-1510b480-cfa2-11eb-99fd-2f53202708d0.png">

이를 코드로 나타내주면 다음과 같다.  
컨벡스 헐의 선분 위에 여러 점이 존재할 경우 가장 끝의 점만 나타내도록 구현하였다.  
```swift
func ccw(a: (Int, Int), b: (Int, Int), c: (Int, Int)) -> Int {
    let result = (b.0-a.0)*(c.1-a.1) - (b.1-a.1)*(c.0-a.0)
    return result > 0 ? 1 : (result == 0 ? 0 : -1)
}

func dist(a: (Int, Int), b: (Int, Int)) -> Int {
    let dx = a.0 - b.0, dy = a.1-b.1
    return dx*dx + dy*dy
}

func makeHul(input: [(Int, Int)]) -> [(Int, Int)] {
    var arr = input
    arr.sort(by: {$0.1 < $1.1})
    arr.sort(by: {$0.0 < $1.0})
    let S = arr[0]
    arr[1..<arr.count].sort(by: {
        ccw(a: S, b: $0, c: $1) == 0 && (dist(a: S, b: $0) < dist(a: S, b: $1))
        //기울기가 같을 경우 거리가 짧은 점부터 보도록 한다.
    })
    arr[1..<arr.count].sort(by: {
        ccw(a: S, b: $0, c: $1) > 0
    })
    var stack:[(Int, Int)] = []
    for next in arr {
        while stack.count >= 2 && (ccw(a: stack[stack.count-2], b: stack[stack.count-1], c: next) <= 0) {
        // 기울기가 같은 점을 마주쳤을 때도 마지막 점을 pop한다.
            stack.removeLast()
        }
        stack.append(next)
    }
    return stack
}
```
