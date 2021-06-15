# Z Algorithm
문자열 S가 S<sub>1</sub>S<sub>2</sub>...S<sub>n</sub> 으로 구성된다고 했을 때 Z[i]를 S와 S<sub>i</sub> ~ S<sub>n</sub>의 가장 긴 공통 접두사의 길이라고 하자.  
이 때 이를 쉽게 구하는 알고리즘이 Z 알고리즘으로 Manacher와 비슷한 방식으로 동작해서 *O(n)* 의 시간 복잡도가 걸리는 효율적인 알고리즘이다.  
Z 알고리즘에서는 l과 r이라는 변수를 사용한다.  
i보다 작은 index k에 대해서 Z값을 알고 있을 때 r은 그중에서 k+Z[k]가 가장 큰 값에 해당하고 그 때의 k를 l이라고 한다고 하자.  
그렇다면 r보다 i가 큰 경우와 작거나 같은 경우로 나누어서 접근할 것이다.  
## 1. i > r

<img width="676" alt="Z1" src="https://user-images.githubusercontent.com/78075226/121802815-63a81100-cc79-11eb-8683-98d32f24d826.png">

이전의 정보가 아무런 도움이 안되는 경우로 i부터 새롭게 맨처음과 비교를 해나간다.  
`if S[z[i]+1] == S[i+z[i]+1] {z[i] += 1}`  
최종적으로 Z[i]의 값은 r-l과 같아진다.  
## 2. i &le; r

<img width="686" alt="Z2" src="https://user-images.githubusercontent.com/78075226/121802818-6571d480-cc79-11eb-925d-6c419f51a390.png">

S[l]~S[r]은 S[0]~S[r-l]와 같다는 정보를 이미 알고 있다.  
따라서 S[i]부터 시작하는 공통 접두사는 S[i-l]의 공통 접두사와 같을 수 밖에 없다.  
`Z[i] = min(Z[i-l], r-i)`  
Manacher와 마찬가지로 Z[i] = Z[i-l]로 선언할 수 없는데 r를 넘어서는 범위에 대해서는 보장을 할 수 없게되기 때문이다.  
이 후 1번과 동일하게 비교를 해나가면서 Z값을 구해준다.  
- Z Function
```swift
func Z(str: [Character]) -> [Int] {
    let n = str.count
    var l = -1, r = -1
    var z = Array(repeating: -1, count: n)
    for i in 1..<n {
        if i <= r {
            z[i] = min(z[i-l], r-i)
        }
        while i+z[i]+1 < n && str[z[i]+1] == str[i+z[i]+1] {
            z[i] += 1
        }
        if i+z[i] > r {
            r = i+z[i]
            l = i
        }
    }
    return z
}
```
시간 복잡도를 생각해보면 마찬가지로 z[i]의 증가 횟수에 달려있다는 것을 알 수 있는데 이는 r의 증가 횟수와도 같다.  
따라서 최대 *O(n)* 이 걸림을 알 수 있다.  
@13713 정리
