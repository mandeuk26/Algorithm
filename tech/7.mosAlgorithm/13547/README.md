# 백준 13547 수열과 쿼리 5
길이 N의 수열이 주어졌을때 쿼리 i j 가 주어지면 A[i] - A[j] 에 존재하는 서로 다른 수의 개수를 출력하는 문제이다. 쿼리의 수가 많고 입력 수열에 변화가 없는 오프라인 쿼리이기 때문에 mo's 알고리즘을 사용하였다. 앞에서 배운 개념에 약간의 변화를 줘야하는데 서로 다른 수의 개수를 세줘야 하기 때문이다. 그 외에는 평방 분할을 한 후 정렬해 쿼리를 처리해주면 된다는 것만 신경쓰면 된다.
- 구간 변화 작업 함수
```swift
func minus(s: Int, e: Int, val: inout Int) {
    for i in s...e {
        count[A[i]] -= 1
        if count[A[i]] == 0 {val -= 1}
    }
}

func plus(s: Int, e: Int, val: inout Int) {
    for i in s...e {
        if count[A[i]] == 0 {val += 1}
        count[A[i]] += 1
    }
}
```
구간이 변할때마다 구간이 증가하면 plus함수를 감소하면 minus함수를 호출할 것인데 각각의 함수는 서로 다른 수의 갯수이기 때문에 새롭게 수가 0에서 1로 증가할 경우와 기존의 수가 1에서 0으로 감소하는 경우 두가지가 발생하면 전체 result에 값을 1 변동되게 하였다. 그 외에는 count라는 배열을 통해서 각 수가 세어진 횟수를 저장해두는 방식으로 구현했다.  
  
파일의 입력이 크기때문에 fread를 해줘야 시간초과가 안난다. 관련 코드는 JCSooHwanCho님의 FileIO.swift 를 참조하였다.  
<출처 : https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88>
