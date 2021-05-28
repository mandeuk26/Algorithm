# 백준 1086 박성원
정수로 이루어진 집합이 주어질 때 정수들을 앞뒤로 배치시켜서 큰 정수를 만들었을 때 해당 정수가 K로 나누어 떨어질 확률을 구하는 문제이다. 
나머지의 원리를 이용하는 문제이다. 5221 이라는 숫자 뒤에 40 이라는 숫자가 온다고 생각해보자.
```
522140 % k = ((5221*100)%k + 40%k)%k = ((5221%k * 100%k)%k + 40%k)%k
```
식이 굉장히 복잡해보이지만 간단히 설명하면 새로운 숫자를 붙이려고 한다면 다음 세가지의 수의 곱으로 표현된다는 것이다.
1. (기존의 만들어진 큰 수)%k
2. (새로운 숫자의 길이*10)%k
3. (새로운 숫자)%k

따라서 우리는 각 배열의 숫자마다 길이를 저장해둘 것이고 각 배열의 수를 k로 나눈 값들을 저장해 둘 것이다. 여기에 배열에서 어떤 정수들을 사용했는지를 bitmask를 활용해서 표시해줄 것이고 그렇게 만들어진 큰 정수를 k로 나눴을때 나머지가 몇인지에 따라서 dp값을 저장해 줄 것이다.
- DP code (bottom up)
```swift
var dp:[[CLongLong]] = Array(repeating: Array(repeating: 0, count: k), count: (1<<n))
dp[0][0] = 1
for i in 0..<(1<<n) {
    for j in 0..<k {
        if dp[i][j] == 0 {
            continue
        }
        for idx in 0..<n {
            if (i & (1<<idx)) == 0 {
                let next = ((j*ten[len[idx]])%k + modnum[idx]) % k
                dp[i|(1<<idx)][next] += dp[i][j]
            }
        }
    }
}
```
ten은 10의 제곱들의 mod k이고 modnum은 기존 정수값의 mod k 이다. 이 때 아무것도 없는 상태를 dp[0][0] = 1로 초기값을 준 후 바텀업으로 dp를 구성해나갈 것이다.  
i와 j의 역할이 뭔가 헤깔릴 수도 있는데 예를들어 1번, 2번, 3번을 사용해서 만든 큰 수가 나머지가 0일때와 2일때 3일때가 존재한다고 했을 때 1,2,3번을 사용했다는 정보는 i로 나타내줄것이고 나머지가 0, 2, 3이라는 정보는 j로 나타내줄 수 있다. 그 때의 dp[i][j]는 경우의수가 있으므로 0이 아닌 값이 저장되어 있어 continue 구문을 통과해 다음 구문을 수행한다.  
해당 정수 뒤에 다음 정수를 붙이고자 할 때 idx라는 변수를 활용하여 만약 아직 사용한 적이 없는 정수라면 그 정수를 붙여 만든 큰 수의 mod k는 next에 저장되고 `dp[i|(1<<idx)][next] += dp[i][j]` 코드를 통해서 경우의 수를 업데이트 시켜준다.  
최종적으로 `dp[(1<<n)-1][0]` 에 우리가 구하고자 하는 값이 들어있을 것이고 이것을 전체 경우의 수와 최대 공약수를 찾아 분수형태로 출력해주면 된다.