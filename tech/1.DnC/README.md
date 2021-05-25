# 분할정복 (Divide & Conquer)
분할정복이란 어떤 결과를 얻고자할때 이를 여러개의 작은 문제들로 **나누고(divide)** 그 결과들을 **결합시켜(conquer)** 해답을 찾는 방법을 말한다. 얼핏보면 동적계획법과 동일해보이지만 분할정복은 쪼개지는 작은 문제가 중복되지 않는다는 차이점이 있다. 분할정복을 적용하는 문제로는 쿼드트리, 거듭제곱, 머지소트 등 다양하지만 여기서는 거듭제곱을 위주로 설명하겠다.   
## 1. 거듭제곱
A라는 행렬을 1024번 곱한다고 생각하자. A<sup>1024</sup>를 구하기 위해서 A를 하나씩 곱하게 되면 1024번의 연산을 하게 된다. 하지만 A<sup>512</sup>를 구하고 이를 제곱해주면 A<sup>1024</sup>를 구할수 있다. 이렇게 주어진 행렬을 두개로 쪼개어 계산해주게되면 총 *logN*의 시간만에 계산을 완료할 수 있게된다. 1024라는 숫자는 작아서 큰 차이가 안나보이겠지만 만약 n이 100,000,000과 같이 큰 수가 된다면 그 차이는 엄청나다는 것을 깨닫게 될 것이다. 이처럼 주어진 문제를 작은 문제로 나누어 다시 결합하는 방식을 분할 정복이라고 하고 다양한 분야에서 사용된다.

다음은 2x2 A행렬의 거듭제곱을 구하는 코드이다. 크게 A와 B 행렬을 곱해주는 multA함수와 A행렬을 m번 제곱하는 powA함수로 이루어져 있다.
- multA함수
```swift
func multA(A: [[Int]], B: [[Int]], n: Int) -> [[Int]] {
    var resultArr = Array(repeating: Array(repeating: 0, count: n), count: n)
    for i in 0..<n {
        for j in 0..<n {
            var result = 0
            for k in 0..<n {
                result += (A[i][k] * B[k][j])
            }
            resultArr[i][j] = result
        }
    }
    return resultArr
}
```
- powA함수
```swift
func powA(A: [[Int]], n: Int, m: Int) -> [[Int]] {
    if m == 0{
        return I
    }
    else if m == 1 {
        return A
    }
    else {
        let p1 = powA(A: A, n: n, m: m/2)
        let p2 = powA(A: A, n: n, m: m%2)
        return multA(A: mulA(A: p1, B: p1, n: n), B: p2, n: n)
    }
}
```
- 메인코드
```swift
let n = 2, m = 10
var I = [[1, 0], [0, 1]]
var A = [[3, 3], [4, 4]]
let result = powA(A: A, n: n, m: m)
print(result)
```

## 2. 점화식 분할정복
위에서 구한 분할정복을 활용하여 피보나치를 *O(n)* 이 아닌. *O(logN)* 만에 가능하다는 사실을 안 후 굉장히 충격을 받았다. 피보나치는 동적계획법에서 봤겠지만 다음과 같은 식을 갖는다.  
- **F<sub>0</sub> = 0, F<sub>1</sub> = 1, F<sub>n+2</sub> = F<sub>n+1</sub> + F<sub>n</sub>**  

이 때 주어진 식을 행렬로 표현하게되면 다음과 같다.  

![equationFibo](https://user-images.githubusercontent.com/78075226/119501838-32d46a80-bda4-11eb-9eeb-60e6be03524f.png)

이 식을 활용하면 (1 1)(1 0) 으로 이루어진 행렬의 곱으로 피보나치 행렬을 표현할 수 있게되고 위에서 사용한 분할정복 행렬곱셈을 사용하게 되면 *O(logN)* 만에 피보나치 행렬을 구할 수 있게된다. 피보나치 점화식 뿐만 아니라 다른 점화식도 행렬로 표현만 한다면 적용가능하므로 다른 문제에서도 종종 쓰이는 기법이다.  
@@10830 행렬 제곱, 11444 피보나치수6, 6549 히스토그램 가장 큰 직사각형, 2261 가장 가까운 두점 정리@@

  
  
  
