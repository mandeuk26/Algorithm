# 백준 20149 선분 교차 3
두 선분 L1, L2가 교차하는 지 아닌지, 만약 한점에서 교차한다면 그 점은 무엇인지를 파악하는 문제이다.  
## 1. 두 선분이 교차하지 않는 경우
먼저 두 선분이 교차하지 않는 경우를 생각해보자.  
두 선분 중 하나를 기반으로 평면을 둘로 나눈다고 생각해보자.  
두 선분이 교차하지 않으려면 나머지 선분이 한쪽에만 위치해 있어야 한다.  

<img width="266" alt="20149_1" src="https://user-images.githubusercontent.com/78075226/122664209-f9dcb980-d1da-11eb-863d-65e6668b9029.png">

그림을 보면 알 수 있듯이 L1을 기반으로 L2는 아래쪽에 모두 위치해 있기 때문에 두 선분은 교차하지 않는다.  
이를 만족시키려면 선분 L1과 L2상의 점에 대해서 CCW를 하면 항상 같은 부호가 나타나야한다.  
이 때 L2를 기반으로 L1상의 점을 확인하면 CCW값의 부호가 서로 다르다는 것을 주목하라.  
따라서 L1과 L2 선분 각각을 기반으로 CCW를 확인해주고 두 경우 중 하나라도 부호가 항상 같은 경우가 등장할 경우 충돌하지 않는다.  
A, B를 L1의 양 끝점 C, D를 L2의 양 끝점이라 했을 때 다음의 형태로 코드를 작성했다.  
- 두 선분이 만나지 않을 경우
```swift
let calc1 = ccw(A: A, B: B, C: C)
let calc2 = ccw(A: A, B: B, C: D)
let calc3 = ccw(A: C, B: D, C: A)
let calc4 = ccw(A: C, B: D, C: B)
var result = -1
if calc1*calc2 > 0 || calc3*calc4 > 0 {
    result = 0 //not crash
}
```
## 2. 두 선분이 교차하는 경우 

<img width="701" alt="20149_2" src="https://user-images.githubusercontent.com/78075226/122664211-fb0de680-d1da-11eb-995e-d4db655f044e.png">

그림을 보면 알 수 있듯이 크게 3가지 경우를 생각해 볼 수 있다.  
1. 서로 교차하는 경우
앞에서 적용했던 ccw를 생각해보자.  
한 선분을 기준으로 양쪽에 끝점이 위치해있기 때문에 ccw의 부호가 서로 다르다.  
따라서 CCW(A, B, C)&lowast;CCW(A, B, D) < 0 && CCW(C, D, A)&lowast;CCW(C, D, B) < 0이 된다.  
2. 한 쪽 선분의 끝이 다른 선분 위에 위치하는 경우
L2를 기준으로 ccw를 구하게 되면 ccw의 부호가 서로 다르다.  
하지만 L1을 기준으로 ccw를 구하게 되면 L2의 한 점은 선분위에 존재하기 때문에 ccw의 값이 0이 나타나게 된다.  
따라서 CCW(C, D, A)&lowast;CCW(C, D, B) < 0 이지만 CCW(A, B, C)&lowast;CCW(A, B, D) = 0 이 된다.  
3. 두 선분의 끝 중 하나가 일치하는 경우
이번에는 L1, L2 모두 ccw의 값이 0이 나타나게 된다.  
따라서 CCW(A, B, C)&lowast;CCW(A, B, D) = 0 && CCW(C, D, A)&lowast;CCW(C, D, B) = 0이 된다.  
- 두 선분이 교차하는 경우
```swift
if calc1 == 0 && calc2 == 0 && calc3 == 0 && calc4 == 0 {
    //두 선분이 한 직선위에 있는 경우로 아래에서 다룰 예정
}
else if calc1*calc2 <= 0 && calc3*calc4 <= 0 {
    result = 1 //crash
    inter = intersection(A, B, C, D)
}
```
만약 intersection을 계산해줘야 하는 경우에는 다음의 관계식을 활용해서 구해주도록 하자.  
- intersection Function
```swift
func intersection(A: (Int, Int), B: (Int, Int), C: (Int, Int), D: (Int, Int)) -> (Double, Double) {
    let x1 = A.0, y1 = A.1, x2 = B.0, y2 = B.1, x3 = C.0, y3 = C.1, x4 = D.0, y4 = D.1
    let px = (x1*y2-y1*x2)*(x3-x4) - (x1-x2)*(x3*y4 - y3*x4)
    let py = (x1*y2-y1*x2)*(y3-y4) - (y1-y2)*(x3*y4 - y3*x4)
    let p = (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4)
    return (Double(px)/Double(p), Double(py)/Double(p))
}
```

## 3. 두 선분이 같은 직선 위인 경우

<img width="896" alt="20149_3" src="https://user-images.githubusercontent.com/78075226/122664213-fba67d00-d1da-11eb-9597-688ba13be22a.png">

앞에서 다룬 두 case는 모두 두 선분이 한 직선 위에 존재하지 않는다는 가정을 하고 접근한 경우였다.  
이번에는 두 선분이 한 직선위에 있는 경우를 생각해보자.  
마찬가지로 2가지 경우를 생각해볼 수 있다.  
여기서는 L1, L2에 대해서 항상 A < B, C < D가 되도록 A, B, C, D를 설정하고 시작한다는 것을 유의하자.  
1. 두 선분이 만나는 경우
B가 C보다 크거나 같고 D가 A보다 크거나 같은 경우를 생각해보자.  
그 범위 내에서는 두 선분이 항상 만난다는 것을 생각해볼 수 있다.  
실제로 첫번째 그림과 두번째 그림을 보면 알 수 있다.  
여기에는 두 선분이 일치하는 경우도 포함된다.  
유의할 것은 우리는 한점에서 만나는 경우 그 좌표를 출력해야 한다.  
만약 B = C 혹은 A = D인 경우를 생각해보자.  
이 경우 두 선분이 끝점끼리만 만나기 때문에 그 좌표를 출력해주도록 구현해야 한다.  
2. 두 선분이 만나지 않는 경우
이 경우는 위와 반대의 조건을 가지면 된다.  
B < C 혹은 D < A인 경우가 이에 해당한다.  
- 두 선분이 한 직선 위에 있는 경우
```swift
if calc1 == 0 && calc2 == 0 && calc3 == 0 && calc4 == 0 {
    if B < A {swap(&A, &B)}
    if D < C {swap(&C, &D)}
    if C <= B && A <= D { //if crash
        result = 1
        if B == C {
            inter = B
        }
        else if A == D {
            inter = D
        }
    }
    else {
        result = 0 //not crash
    }
}
```

