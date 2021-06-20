# 백준 1654 랜선 자르기
총 k개의 랜선이 주어지고 주어진 랜선들을 잘라서 같은 길이의 n개의 랜선을 만들때 만들 수 있는 가장 긴 랜선의 길이를 찾는 문제이다.   
포인트는 랜선들을 자를 길이를 기준으로 이분탐색을 진행해서 잘라낸 랜선 개수가 n개를 만족할 수 있는지를 확인하는 것이다. 
```swift
var end = input.max()! + 1
var start = 1
while start < end {
    let mid = (start+end)/2
    var result = 0
    for num in input {
        result += num/mid
    }
    if result >= n {
        start = mid+1
    }
    else {
        end = mid
    }
}
```
위의 코드는 이분탐색을 해주는 코드이다. input에 k개의 랜선들의 길이를 넣어놓고 매 iteration마다 mid의 길이로 몇개씩 잘라낼 수 있는지 찾아내서 n개 보다 크거나 같을 경우 mid보다 큰 길이에 대해 확인해주고 n개보다 작을 경우 mid보다 작은 길이에 대해 확인해주도록 구현했다.
