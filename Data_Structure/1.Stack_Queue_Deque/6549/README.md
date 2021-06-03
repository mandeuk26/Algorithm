# 백준 6549 히스토그램에서 가장 큰 직사각형
풀이방법으로는 세그먼트트리와 분할정복을 사용하는 것과 스택을 사용하는 것 2가지가 존재하는 문제이다. 여기서는 스택을 사용한 풀이방법을 소개할 것이다. 히스토그램이 주어질 때 히스토그램에서 가장 넓이가 큰 직사각형을 구하는 문제이다. 스택에는 각 직사각형의 길이와 그때의 index를 같이 저장시켜줄 것이다. 

<img width="572" alt="6549" src="https://user-images.githubusercontent.com/78075226/120605684-5032c400-c489-11eb-8f25-26d5ddce4009.png">

만약 그림처럼 점점 증가하는 직사각형이 주어지다가 길이가 이전꺼보다 짧은 직사각형이 왔다고 하자. 그렇다면 현재 스택에는 [2, 3, 7] 이 저장되어 있고 1이 들어갈 차례이다. 이제 스택에 저장되어있는 원소들은 직사각형들의 높이라고 했을 때 7을 높이로 갖는 직사각형은 1이 등장했기 때문에 더이상 오른쪽으로 너비를 증가시킬 수 없다. 따라서 stack에서 꺼내 가능한 너비를 계산 후 직사각형 넓이를 구해준다. 마찬가지로 3과 2역시 동일하게 수행한다. 
- 직사각형 너비 계산 코드
```swift
let lastElement = stack.removeLast()
if stack.isEmpty {
    result = max(result, (i-1)*lastElement.0)
    stack.append((line[i], i))
    break
}
else {
    let beforeLast = stack.last!
    result = max(result, (i - beforeLast.1 - 1)*lastElement.0)
}
```
이 때 코드를 보면 너비를 계산해줄 때 새로운 index인 i 로부터 stack에서 pop한 사각형의 index를 빼주는 것이 아닌 stack의 top의 index를 빼주는 것을 볼 수 있는데 좌측으로의 너비를 고려해주기 위함이다.  
