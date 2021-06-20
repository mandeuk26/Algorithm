# 백준 2110 공유기 설치
n개의 집에 대한 좌표가 주어졌을 때 총 c개의 공유기를 집들 중 선택해서 설치하려고한다. 이 때 공유기간의 거리 중 최솟값이 최대가 되도록 할때 그 길이를 구하는 문제이다.
앞에서 다루었던 랜선자르기와 느낌이 비슷하다. 핵심 포인트는 공유기간의 거리의 최솟값을 이분탐색 조건으로 놓고 진행한다는 것이다.
```swift
input.sort()
for i in 0..<n-1 {
    length.append(input[i+1] - input[i])
}
```
먼저 input에는 집들의 좌표가 들어있고 length에는 이웃한 집들간의 거리를 저장한다고 해보자. 따라서 input을 sort한 후 이웃한 input간의 차를 length에 저장해주었다.
```swift
var end = length.reduce(0, +) + 1
var start = length.min()!
while start < end {
    let mid = (start+end)/2
    var result = 0, count = 0
    for num in length {
        count += num
        if count >= mid {
            result += 1
            count = 0
        }
    }
    if result >= m-1 {
        start = mid+1
    }
    else {
        end = mid
    }
}
```
위의 코드가 이분탐색을 해주는 부분이다. 여기서 주목할 것은 **count**라는 변수이다. count는 length를 앞에서부터 하나씩 더해가는데 이는 두 공유기 간의 거리를 의미하게 된다. 만약 공유기간의 거리가 우리가 설정한 mid라는 기준을 넘게되면 공유기를 설치할 수 있으므로 설치해주고 count값을 다시 0으로 만들어서 새로운 공유기와의 거리를 측정해준다.  
이렇게 설치한 공유기의 갯수 result가 m-1개보다 크거나 같으면 우측영역 탐색을, 작으면 좌측영역 탐색을 진행한다. 이 때 m-1개가 기준인 이유는 가장 왼쪽에 있는 집에는 무조건 설치하기 때문에 1을 빼줘야한다.
