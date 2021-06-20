# 정수론 & 조합론
## 1. 약수
약수의 갯수를 구하는 알고리즘을 알아보자.  
간단하게 표현한다면 다음과 같을 것이다.  
```swift
var divisor = [Int]()
for i in 1...n {
    if n%i == 0 {
        divisor.append(i)
    }
}
```
그런데 약수의 경우 i x i = n 이 되는 i에 대해서 i를 기준으로 절반씩 갯수가 존재한다.  
따라서 모든 i에 대해 볼 필요없이 범위를 sqrt(n)까지로 제한해 줄 수 있다.  
```swift
import Foundation
var divisor = [Int]()
let sqrtn = Int(sqrt(Double(n)))
for i in 1...sqrtn {
    if n%i == 0 {
        divisor.append(i)
        if i*i != n {
            divisor.append(n/i)
        }
    }
}
```
만약 우리가 1~n까지의 모든 수의 약수의 갯수를 구하고자 한다면 어떻게해야할까?  
위에서 사용했던 방식을 사용하면 모든 수에 대해서 sqrt(n)만큼을 확인해야하기 때문에 *O(nsqrt(n))* 의 시간이 소요된다.  
좀 더 개선을 하기위해 2부터 숫자를 늘려가며 범위내의 모든 곱에 대해서 체크를 해주는 방식을 활용할 것이다.  
```swift
import Foundation
let n = 20
var divisor = Array(repeating: 0, count: n+1)
for i in 1...n {
    for j in 1..<n/i+1 {
        divisor[i*j] += 1
    }
}
```
## 2. 최대공약수
최대공약수 알고리즘을 이해하려면 유클리드 호제법에 대해서 먼저 알아야한다.  
>유클리드 호제법  
>a를 b로 나눈 나머지가 r이라고 하고 a와 b의 최대공약수를 (a, b)라고 한다면 다음이 성립한다.  
>(a, b) = (b, r)  

따라서 예시로 1071과 1029에 대한 최대공약수를 적어보면  
(1071, 1029) = (1029, 42) = (42, 21) = (21, 0)  
최종적으로 0이 등장하면 그때의 값이 최대공약수가 된다.  
따라서 1071과 1029의 최대공약수는 21이 된다.  
이를 재귀 함수로 나타내면 다음과 같다.  
a, b의 대소관계는 중요치 않다는 것을 명심하자.  
a = 10, b = 25로 예를 들면 gcd(a: 25, b: 10%25)가 호출되어서 자동으로 a, b 값이 swap된 형태로 함수가 작동한다.  
```swift
func gcd(a: Int, b: Int) -> Int {
    if b == 0 {
        return a
    }
    return gcd(a: b, b: a%b)
}
```
## 3. 최소공배수
두 수의 최소공배수는 최대공약수를 구하면 간단히 구할 수 있다.  
예시로 1071, 1029를 예로 들자면 둘의 최대 공약수는 21이다.  
이 때 두 수는 51x21 = 1071 과 49x21 = 1029로 나타낼 수 있다.  
따라서 최소공배수는 두 수의 곱에서 최대 공약수를 한번 나누어준것과 같다.  
```swift
func LCM(a: Int, b: Int) -> Int {
    let gcdVal = gcd(a: a, b: b)
    return a*(b/gcdVal)
}
```
## 4. 이항계수
<sub>n</sub>C<sub>k</sub>로 표현되는 이항계수는 n개 중에서 k개를 택할 때의 경우의 수를 의미한다.  
일반적으로 DP를 활용하여 구하는 방법이 보편적이다.  
<sub>n</sub>C<sub>k</sub> = <sub>n-1</sub>C<sub>k-1</sub> + <sub>n-1</sub>C<sub>k</sub>의 성질과 <sub>n</sub>C<sub>0</sub> = <sub>n</sub>C<sub>n</sub> = 1 성질을 활용해 코드를 짤 것이다.  
이항계수의 경우 n이 조금만 커져도 값이 순식간에 int 범위를 벗어나기 때문에 임의의 숫자로 나눈 나머지로 표현하는 경우가 많다.  
```swift
func combo(n: Int, k: Int) -> Int {
    var arr = Array(repeating: 1, count: n+1)
    for i in 1...n {
        let tmp = arr
        for j in 1..<i {
            arr[j] = tmp[j-1] + tmp[j]
        }
    }
    return arr[k]
}
```
## 5. 소수
소수란 약수가 1과 본인 자신밖에 없는 수를 말한다.  
간단하게 구현하자면 2부터 n-1까지 모든 수를 n과 나누어서 나머지가 0이 되는 값이 존재하는지 확인해주면 된다.  
그러나 약수 알고리즘과 동일하게 모든 수는 2~sqrt(n)까지의 지점에 대해서만 확인을 하면 그 이상의 약수에 대해서는 sqrt(n)과 작거나 같은 범위를 탐색할 때 한번씩 방문을 하게 된다.  
따라서 다음과 같이 소수판별 알고리즘을 짤 수 있다.  
```swift
import Foundation
func prime(n: Int) -> Bool {
    let sqrtn = Int(sqrt(Double(n)))
    for i in 2...sqrtn {
        if n%i == 0 {
            return false
        }
    }
    return true
    // 1, 2, 3은 예외처리를 해줘야한다. 여기선 skip
}
```
만약 1~n까지의 모든 수의 소수 여부를 알고싶다고 했을 때 일일히 prime함수를 대입하는 것은 시간낭비이다.  
약수의 갯수를 셌던 알고리즘을 생각해보자.  
이를 동일하게 prime 알고리즘에도 적용할 수 있다.  
2부터 순차적으로 sqrt(n)까지 방문을 하는데 만약 이전에 방문한 적이 없다면(소수라면) 해당 숫자의 배수들은 모두. 소수가 아니라고 판명해주는 것이다.  

예시로 2는 소수가 아니므로 2의 배수들 4, 6, 8 ... 을 모두 소수가 아니라고 check배열에 표시해준다.  
3도 마찬가지로 소수가 아니므로 배수들 6, 9, 12 ... 을 모두 소수가 아니라고 check배열에 표시해준다.  
4는 check배열에 소수가 아니라고 표시되어 있기 때문에 넘어간다.  
5도 마찬가지로 소수가 아니므로 배수들 10, 15, 20 ... 을 소수가 아니라고 표시해준다.  
이런식으로 2-sqrt(n)까지 반복하면서 소수 여부를 배열에 남겨주면 된다.  
이를 에라토스테네스의 체 라고 부른다.  
```swift
import Foundation
func prime(n: Int) -> [Bool] {
    let sqrtn = Int(sqrt(Double(n)))
    var check = Array(repeating: true, count: n+1)
    check[0] = false
    check[1] = false
    for i in 0...sqrtn {
        if check[i] {
            var idx = 2*i
            while idx <= n {
                check[idx] = false
                idx += i
            }
        }
    }
    return check
}
```
