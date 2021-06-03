# Segment Tree
배열의 구간에 대한 합이라던지 가장 큰 값이라던지를 구하려면 그동안은 매번 구간 전체를 보면서 처리해줘야 했었다. 이렇게 될 경우 *O(n)* 의 시간이 매번 걸리게 된다. segment tree는 이런 구간에 대한 작업을 *O(logn)* 만에 해낼 수 있게 도와주는 자료구조이다. 세그먼트 트리를 사용하기 위해 배열을 이진 트리의 형태로 변화를 시킬 것이다. 다음 그림을 보자.

<img width="653" alt="segment" src="https://user-images.githubusercontent.com/78075226/120502449-67c46b00-c3fd-11eb-89cb-6bf81eb7664b.png">

주어진 이진 트리의 각 노드는 배열의 각 구간을 나타내고 있다. 만약 우리가 3-7 구간을 보고 싶다면 3 과 4-7 구간에 해당하는 노드를 살펴보면 된다. 그렇다면 어떻게 구현을 해야할까? 먼저 우리는 트리의 시작 index를 0이 아닌 1로 설정해줄 것이다. 이렇게 해주는 이유는 좌측 child와 우측 child를 찾아갈 때 현재 노드의 2node 와 2node+1로 표현이 되어서 간단하기 때문이다.  
한가지 유의할 점은 segment tree의 전체 배열 길이는 넣고자 하는 원래 배열의 구간 길이보다 크거나 같은 2의 제곱수의 2배로 설정한다는 점이다. 예를들어 5~8 의 길이를 가질 수 있다고 한다면 가장 가까운 2의 제곱수는 8이 되고 그 2배인 16 만큼의 길이를 갖는 배열이 필요하게 된다. 단 기존 길이에 4배를 해서 사용해도 무방하다고 알려져있기 때문에 본인의 스타일에 맞게 구현하면 된다.  
이 앞에서부터는 구간합을 구하는 segment tree를 가지고 설명을 할 것이다. 만약 구간합이 아닌 다른 것을 구하려고 한다면 함수의 내부 구현이 달라질 수 있다는 것을 명심하고 보길 바란다.
## 1. MakeTree
이 함수는 맨처음에 호출해서 기존 배열로부터 세그먼트 트리를 만들어주는 함수이다. 각 노드에는 해당하는 구간의 구간합이 저장되어있다. 우리는 start와 end, 그리고 node라는 변수를 활용할 것이다. arr은 기존 배열, seg는 새롭게 만든 트리 배열이라는 것을 알고 다음 코드를 보길 바란다.
- makeTree Function
```swift
mutating func makeTree(start: Int, end: Int, node: Int) -> Int {
    if start == end {
        seg[node] = arr[start]
        return seg[node]
    }
    let mid = (start+end)/2
    let l = makeTree(start: start, end: mid, node: 2*node)
    let r = makeTree(start: mid+1, end: end, node: 2*node+1)
    seg[node] = l+r
    return seg[node]
}
```
먼저 start와 end에는 현재 위치한 노드의 구간을 나타내주고 node는 seg에서의 index가 들어있다. 만약 우리가 0-7 구간을 나타내주는 root node에 위치해있다면 start = 0, end = 7, node = 1인 상태일 것이다. 만약 start와 end가 같아진다면 현재 leaf 노드에 해당한다는 것이고 arr 배열에서의 값을 입력해주면 된다.  
그러나 leaf가 아닐경우 길이가 2이상인 구간에 해당한다. 위의 그림을 보면 구간의 정중앙값을 기준으로 구간이 나뉘어서 왼쪽 child와 오른쪽 child가 생성된다는 것을 알 수 있다. 따라서 mid 값을 기준으로 구간을 나눠 각 구간에 대해 재귀적으로 구간합을 설정해주고 그 결과의 합을 현재 노드에 저장시켜주도록 구현한다. 만약 구간합이 아니라 다른 것을 구하는 문제라면 그에 맞는 처리를 해주면 된다.
## 2. Find
이 함수는 구간을 주면 해당 구간의 값을 구해주는 함수이다. 위의 makeTree와 똑같이 start, end, node 변수를 쓰고 추가적으로 어떤 구간의 구간합을 구할것인지 알려주는 left, right 변수를 사용한다. 
- find Function
```swift
mutating func find(start: Int, end: Int, node: Int, left: Int, right: Int) -> Int {
    if left > end || start > right {
        return 0
    }
    if left <= start && end <= right {
        return seg[node]
    }
    let mid = (start+end)/2
    let l = find(start: start, end: mid, node: 2*node, left: left, right: right)
    let r = find(start: mid+1, end: end, node: 2*node+1, left: left, right: right)
    return l+r
}
```
이 때 찾고자 하는 구간과 현재 구간이 아예 겹치지 않는다면 0을 return하고 찾고자 하는 구간에 완벽히 포함되면 그 때의 seg[node] 값을 return 해준다. 만약 구간이 일부는 겹치고 일부는 겹치지 않는다면 왼쪽, 오른쪽으로 나눠서 각각 구해준다. 만약 3-7을 구한다고 하면 0-7 root 구간은 0-3과 4-7로 나뉘어지고 4-7은 완벽하게 일치하기 때문에 값을 return 해주고 0-3 구간은 계속 구간이 쪼개져서 3 구간을 찾아가게 되는 것이다. 탐색하는 깊이가 최대 *logn* 이기 때문에 시간 복잡도는 *O(logn)* 이 소요된다.
## 3. Update
만약 원래 배열에서 값이 변경된다고 하자. 그 경우 해당 index를 포함하는 모든 구간은 값이 변경되야 할 것이다. 여기서는 구간합이기 때문에 위에서부터 찾아 내려가면서 노드의 구간에 변경하고자하는 index가 포함되어 있다면 값을 변경해주도록 구현이 되어있다. 하지만 구간합이 아닌 다른 경우에는 형태가 달라질 수 있으므로 유의하자. 마찬가지로 탐색하는 깊이가 최대 *logn* 이기 때문에 *O(logn)* 의 시간이 소요된다.
- update Function
```swift
mutating func update(start: Int, end: Int, node: Int, index: Int, val: Int) {
    if index < start || index > end {
        return
    }
    seg[node] += val
    if start == end {
        return
    }
    let mid = (start+end)/2
    update(start: start, end: mid, node: 2*node, index: index, val: val)
    update(start: mid+1, end: end, node: 2*node+1, index: index, val: val)
}
```
## 4. Lazy Propagation
그런데 업데이트 함수를 사용해서 구간을 업데이트 했지만 해당 변경점을 단 한번도 부르지 않을 경우 update를 하기위해 모든 노드를 변경해주는 것이 낭비일 수 있다. 다른 경우로는 update함수를 굉장히 많이 호출한다고 하자. 하지만 정작 find 함수는 마지막에 단 한번 일어난다고 했을 때 그동안 모든 노드를 update마다 수정해주는 것은 연산 낭비이다.  
이를 해결하기 위해서 lazy propagation 이라는 개념이 도입되었다. 이는 update가 들어왔을 경우 update를 밑의 노드로 전파하지 않고 쌓아두는 방식이다. 만약 밑의 노드를 호출할 일이 생길 경우 그 때 누적된 update들을 한번에 전파해준다. 이렇게 될 경우 쓸모없는 구간에 대한 update로 인한 연산 낭비를 방지할 수 있게 된다. 이제 우리는 lazy라는 새로운 배열을 하나 더 쓸 것인데 이는 해당 노드로 전파되어야할 update 값들을 쌓아두는 배열이다.
- updateLazy Function
```swift
func updateLazy(start: Int, end: Int, node: Int) {
    if lazy[node] != 0 {
        seg[node] += lazy[node]*(end-start+1)
        if start != end {
            lazy[2*node] += lazy[node]
            lazy[2*node+1] += lazy[node]
        }
        lazy[node] = 0
    }
}
```
함수를 보면 알겠지만 lazy update는 update나 find 함수에서 해당 노드를 처음 방문했을 경우 쌓여있는 값을 업데이트 해주는 함수이다. 만약 노드를 업데이트 했다면 노드에 연결된 왼쪽 자식과 오른쪽 자식에게도 lazy 값을 전파해주고 본인의 lazy값은 0으로 만들어야 한다는 것을 명심하자. lazy를 적용하면 find와 update 함수도 변화한다는 것을 명심하자.

## 5. Fenwick Tree
이번에는 segment tree와 유사하게 구간에 대한 결과를 얻을 수 있는 두번째 구조인 fenwick tree에 대해서 알아볼 것이다. segment와 마찬가지로 구간 query 구하기와 update 모두 *O(logn)* 이 걸리는 효율적인 자료구조이다. segment와 차이점으로는 n개의 길이를 갖는 배열만 필요하기 때문에 seg보다 공간 복잡도가 작다는 장점이 있다.

<img width="894" alt="fenwick" src="https://user-images.githubusercontent.com/78075226/120596057-3c359500-c47e-11eb-98ac-410181b2588b.png">

위의 그림은 fenwick tree를 실제로 만든 모습이다. 파란색으로 되어있는 부분이 fenwick tree이다. 이 때 써져있는 번호는 array에서의 index를 의미한다. 예를들어 12번 index는 기존 배열에서 9-12번 구간에 대한 결과가 들어있다. 한가지 유의할 점으로는 fenwick에서의 index가 주어지면 그 구간에는 반드시 해당 index를 포함하고 있다는 것이다.
- Fenwick Find

<img width="906" alt="fenwickfind" src="https://user-images.githubusercontent.com/78075226/120596076-422b7600-c47e-11eb-84f4-d84fd7892e71.png">

fenwick 함수는 find와 update로 구성이 된다. find에 대해서 먼저 알아보자. 만약 우리가 1-13 구간에 대해서 알고 싶다고 하자. 그렇다면 우리는 8번과 12번과 13번 노드를 택하면 된다. 이 때 13 -> 12 -> 8 으로 넘어갈때 이진법으로 표현하면 1101 -> 1100 -> 1000 이 된다. 그런데 유심히 보면 맨 끝에 존재하는 1값이 하나씩 사라지는 것을 확인할 수 있다. 맨 우측에 존재하는 1을 나타내기 위해서는 (index & -index)로 표현하는데 이는 signed bit를 고려해서 이진법으로 숫자를 나타내보면 간단하니 한번 생각해보길 바란다. 
```swift
func fenwick_find(tree: [Int], idx: Int) -> Int {
    var res = 0
    var index = idx
    while index > 0 {
        res += tree[index]
        index -= (index & -index)
    }
    return res
}
```
따라서 fenwick find 함수는 위와 같다. 만약 구간 7-11을 구하고 싶다면 11에 대한 find를 구한 후 6에 대한 find를 빼주면 7-11 구간에 대해 구할 수 있다.
- Fenwick Update

<img width="910" alt="fenwickupdate" src="https://user-images.githubusercontent.com/78075226/120596092-46f02a00-c47e-11eb-9ba9-d3c5368d3002.png">

이번에는 값을 업데이트 해줄 것이다. 만약 우리가 index 9에 값을 변경했다고하자. 그렇다면 해당 정보는 9를 구간으로 포함하는 모든 노드에 대해서 업데이트가 이루어져야 할 것이다. 예시를 보면 9 -> 10 -> 12 -> 16에 해당하고 이진법으로 나타내면 1001 -> 1010 -> 1100 -> 10000 이 된다. 그런데 자세히 보면 find와 비슷하게 맨 마지막 1이 존재하는 자리에 1을 더해준 형태로 증가하고 있다는 것을 확인할 수 있다. 따라서 간단하게 코드를 짜보면 다음과 같다.
```swift
func fenwick_update(tree: inout [Int], idx: Int, val: Int) {
    var index = idx
    while index <= n {
        tree[index] += val
        index += (index & -index)
    }
}
```
- fenwick : 시간복잡도 O(logn) / 공간복잡도 O(n)  
- segment : 시간복잡도 O(logn) / 공간복잡도 O(4n)  

위의 결과를 보면 fenwick이 메모리도 덜 잡아먹고 구현 자체도 간단하기 때문에 fenwick을 쓰는게 무조건 좋다고 생각할 수 있다. 하지만 fenwick은 구간내 최댓값, 최솟값을 구하기 등 몇몇 문제의 경우 사용할 수가 없다. 즉 다양한 case에 적용하기가 segment보다 어렵다는 것이다. 둘 다 장단점이 있으므로 우리는 상황에 맞는 자료구조를 선택하는 것이 중요하다.  
