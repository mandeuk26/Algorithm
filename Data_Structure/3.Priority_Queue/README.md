# 우선순위 큐
우선순위 큐란 데이터들이 우선순위를 가지고 있고 높은 우선순위를 가진 데이터가 먼저 나가는 자료구조이다.  그렇다면 이런 구조를 어떻게 구성해야 할까? 우리는 heap이라는 구조를 사용할 예정이다. 
# Heap
완전 이진 트리로 부모의 값이 자식의 값보다 우선순위가 높은 형태로 되어있는 자료구조이다. heap에서의 push와 pop은 모두 *O(logn)* 이 걸리게 되서 굉장히 빠른 연산이 가능해진다. 우리는 Array를 활용해서 구현할 예정이다. pop의 경우 항상 heap에서 root에 있는 값을 꺼내오게 되는데 이는 전체 데이터 중에서 우선순위가 가장 높은 값을 반환하므로 우선순위 큐를 구현할 수 있게 된다. 
## 1. ShiftUp 함수
만약 배열의 끝에 새로운 원소를 집어넣는다 생각해보자. 어떻게하면 새로운 원소가 heap의 우선순위 규칙을 따르는 위치로 가게 될까? 우리는 노드와 부모를 비교해서 부모보다 현재의 노드가 우선순위가 높다면 부모와 위치를 바꿔주는 일을 반복적으로 할 것이다. 이 때 부모와 자식을 바꿔가며 만들어지는 새로운 subtree는 heap의 조건을 만족한다고 가정하자. 그렇다면 다음과같이 부모와 두 subtree가 있다고 하자.

<img width="425" alt="shiftup1" src="https://user-images.githubusercontent.com/78075226/120439583-a5090880-c3bd-11eb-8599-0188a39f853c.png">

이 때 한쪽 subtree에 새로운 원소가 집어넣어져서 shiftup 연산을 거쳐서 새로운 subtree가 되었다고 하자. 이 때 회색의 의미는 새로운 원소가 포함되어있다는 의미이다. 만약 새로운 원소가 오른쪽 subtree의 root에 도달했다고 하자. 부모와 오른쪽 subtree의 root는 서로를 비교해서 우선순위가 높은 것을 위로 보낼 것이다. 

<img width="420" alt="shiftup2" src="https://user-images.githubusercontent.com/78075226/120440282-5740d000-c3be-11eb-9caf-5c0e926561b4.png">

만약 부모 노드가 우선순위가 더 높아서 새로운 노드와 자리를 바꿀 필요가 없을 경우는 어떻게 될까? subtree는 heap의 조건을 만족한다고 가정했었기 때문에 새롭게 형성된 오른쪽 subtree의 모든 원소보다 부모 노드의 우선순위가 높게된다. 따라서 전체 tree는 heap의 조건을 만족하게 된다.

<img width="438" alt="shiftup3" src="https://user-images.githubusercontent.com/78075226/120439628-b05c3400-c3bd-11eb-94ca-2ab57779c483.png">

새로운 노드가 부모보다 우선순위가 더 높다면 둘의 위치가 바뀔 것이다. 그렇게 될 경우 왼쪽 subtree는 기존의 부모보다 우선순위가 전부 낮았기 때문에 새롭게 바뀐 부모보다도 전부 우선순위가 낮을 것이다. 그렇다면 오른쪽 subtree를 보자. 기존의 부모 노드는 새로운 원소가 들어오기 전에 오른쪽 subtree의 모든 원소보다 우선순위가 높았었다. 따라서 새롭게 형성된 오른쪽 subtree도 heap조건을 만족하게 되고 전체 트리는 heap조건을 만족하게 된다.  

<img width="434" alt="shiftup4" src="https://user-images.githubusercontent.com/78075226/120446871-efda4e80-c3c4-11eb-8db9-2bd998f2653d.png">

이렇게 새로운 원소부터 하나씩 subtree를 만들어간다면 ShiftUp 함수를 통해 새로운 heap을 만들 수 있다는 것을 알 수 있다. 이 때 최대 shiftup 하는 횟수는 이진트리의 높이와 같고 이는 최대 *O(logn)* 이다.
- ShiftUp Function
```swift
mutating func shiftUp(_ a: Int) {
    var now = a
    while now > 0 {
        let parent = (now-1)/2
        if compare(pq[now], pq[parent]) {
            pq.swapAt(now, parent)
            now = parent
        }
        else {
            break
        }
    }
}
```
## 2. Push 함수

배열의 맨 끝에 새로운 원소를 집어넣고 ShiftUp 연산을 거치면 새로운 heap이 생기는 것을 위에서 확인했다. 따라서 간단하게 다음과 같이 구현할 수 있다. 전체 걸리는 시간은 ShiftUp에 걸리는 *O(logn)* 만큼이다.
- Push Function
```swift
mutating func push(_ a: T) {
    pq.append(a)
    shiftUp(pq.count-1)
}
```
## 3. ShiftDown 함수

그렇다면 shift up과 반대로 heap의 root가 임의의 값으로 변경된다고 하자. 그렇다면 해당 root는 적절한 위치를 찾아서 내려가야 할 것이다. 이 때 사용되는 연산이 shift down 함수이다. 새롭게 바뀐 노드를 제외한 양쪽 subtree는 heap의 조건을 만족하고 있다. 

<img width="445" alt="shiftdown1" src="https://user-images.githubusercontent.com/78075226/120444333-7e999c00-c3c2-11eb-9d7f-e3c2acc3d19c.png">

양쪽 subtree의 root보다 현재의 노드가 우선순위가 높다면 그대로 두면 전체 tree는 heap의 조건을 만족하게 된다. 만약 그렇지 않다면? 양쪽 subtree의 root중 현재의 노드보다 우선순위가 작은 노드가 존재한다고 하자. 둘의 위치를 바꾸게 된다면 새롭게 형성되는 subtree는 똑같은 형태가 반복될 것이고 양쪽 subtree의 root보다 현재의 노드의 우선순위가 높을때까지 반복적으로 계산하면 된다. 

<img width="432" alt="shiftdown2" src="https://user-images.githubusercontent.com/78075226/120444360-85281380-c3c2-11eb-9515-cfa301398d53.png">

이 때 두 subtree의 root가 모두 새롭게 바뀐 노드보다 우선순위가 높다면 두 subtree 중 우선순위가 더 높은 것을 바꾸도록 한다. 그렇게 할 시 한쪽 subtree보다 새로운 부모 노드가 우선순위가 높기 때문에 heap의 조건을 만족하면서 tree를 구성해 나갈 수 있게 된다.
- ShiftDown Function
```swift
mutating func shiftDown(_ a: Int) {
    var now = a
    var child = 2*a+1
    while child < pq.count {
        if child+1 < pq.count && compare(pq[child+1], pq[child]) {
            child += 1
        }
        if compare(pq[child], pq[now]) {
            pq.swapAt(child, now)
            now = child
            child = 2*now+1
        }
        else {
            break
        }
    }
}
```
## 4. Pop 함수

위에서 설명한 ShiftDown을 활용한다. 먼저 root에 있는 원소를 배열의 맨 끝 원소와 swap한다. 그 후 배열에서 removeLast를 수행한다. 이렇게 할 경우 *O(1)* 만에 원소 제거가 가능해져 효과적이다. 그 후 새롭게 바뀐 root 원소를 적절한 위치를 찾아 ShiftDown 시켜준다. 전체 걸리는 시간은 ShiftDown에서 소요되는 *O(logn)* 만큼 걸리게 된다.
- Pop Function
```swift
mutating func pop() -> T? {
    if pq.isEmpty {
        return nil
    }
    else {
        pq.swapAt(0, pq.count-1)
        let result = pq.removeLast()
        shiftDown(0)
        return result
    }
}
```
- 전체 코드
```swift
struct PriorityQueue <T> {
    var pq:[T]
    var compare:(T, T) -> Bool
    mutating func shiftUp(_ a: Int) {
        var now = a
        while now > 0 {
            let parent = (now-1)/2
            if compare(pq[now], pq[parent]) {
                pq.swapAt(now, parent)
                now = parent
            }
            else {
                break
            }
        }
    }
    mutating func shiftDown(_ a: Int) {
        var now = a
        var child = 2*a+1
        while child < pq.count {
            if child+1 < pq.count && compare(pq[child+1], pq[child]) {
                child += 1
            }
            if compare(pq[child], pq[now]) {
                pq.swapAt(child, now)
                now = child
                child = 2*now+1
            }
            else {
                break
            }
        }
    }
    mutating func push(_ a: T) {
        pq.append(a)
        shiftUp(pq.count-1)
    }
    mutating func pop() -> T? {
        if pq.isEmpty {
            return nil
        }
        else {
            pq.swapAt(0, pq.count-1)
            let result = pq.removeLast()
            shiftDown(0)
            return result
        }
    }
    init(pq: [T] = [], compare: @escaping (T, T) -> Bool) {
        self.pq = pq
        self.compare = compare
    }
}
```
