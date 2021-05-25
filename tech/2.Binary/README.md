# 이분탐색 (Binary Search)
원하는 탐색범위를 두부위로 분할한 뒤 적합한 부위로 이동해 계속해서 찾는 탐색 기법을 의미한다. 일반적으로 분할하는 위치는 **start index**와 **end index**의 중앙값인 **mid**를 기점으로 분할한다. 단 이분 탐색을 할 때 값들이 정렬되어있어야 한다는 조건이 필요하다. 대표적인 이분 탐색 기법으로는 lower bound, upper bound가 있으며 그 외에도 다양한 분야에 적용되고 있다.

## 1. Lower bound
찾고자하는 key값이 주어졌을때 주어진 범위 안에서 key값보다 크거나 같은 가장 작은 index를 가진 값을 찾아주는 방법이다.  
```
1. start와 end 중앙값인 mid를 정의한다.
2. key값이 A[mid] 보다 클 경우 start를 mid+1로 이동시키고 작거나 같을 경우 end를 mid로 이동시킨다.
3. 1, 2 과정을 새로운 범위에 대해 반복한다.
4. end <= start가 될시 end index를 return한다.
```
이 때 유의할 것은 key값보다 크거나 같은 가장 작은 index를 찾는 것이기 때문에 2번과정에서 같을 경우 end를 mid로 땡겨오는 것이다. 또 맨 처음 end 값을 찾고자하는 범위의 끝이 아닌 끝+1로 해줘야 한다는 것인데 이는 주어진 배열의 모든 원소보다 key값이 클 경우 배열의 끝+1 index를 나타내줘야하기 때문에 이렇게 구현하였다.
```swift
let A = [1, 2, 3, 4, 4, 5, 6, 7]
print(lowerbound(start: 0, end: A.count, key: 4))

func lowerbound(start: Int, end: Int, key: Int) -> Int {
    var s = start, e = end
    while s < e {
        let mid = (s+e)/2
        if A[mid] < key {
            s = mid+1
        }
        else {
            e = mid
        }
    }
    return e
}
```
## 2. Upper bound
Lower bound와 동작은 비슷하지만 key값보다 큰 값을 가진 가장 작은 index를 찾는다는 점에서 차이를 갖는다. Lower bound 2번 과정에서 A[mid]보다 key값이 크거나 같을 경우 start를 mid+1로 이동시키도록 수정만 하면 구현 완료다.  

@@1654 랜선 자르기 문제와 1300 K번째 수 정리@@
