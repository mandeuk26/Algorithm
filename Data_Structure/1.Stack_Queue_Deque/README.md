# Stack&Queue&Deque
## 1. Stack
스택이란 LIFO(Last In First Out)의 자료구조로 가장 나중에 들어온 데이터가 가장 먼저 나갈 수 있는 자료구조를 의미한다. LinkedList나 Array로 주로 구현을 한다. 주 기능으로는 push와 pop이 있으며 push는 값을 stack의 top에 데이터를 추가하는 행동을 의미하고 pop은 stack의 top에 존재하는 데이터를 꺼내는 행동을 의미한다. 모두 *O(1)* 의 시간이 걸리며 스위프트에서는 Array로 구현할 예정이다.

<img width="431" alt="Stack" src="https://user-images.githubusercontent.com/78075226/120431154-10011200-c3b3-11eb-98cc-3047528b1377.png">

- Stack 구현
```swift
struct Stack <T> {
    var stack:[T] = []
    mutating func push(_ a: T) {
        stack.append(a)
    }
    mutating func pop() -> T? {
        return stack.popLast()
    }
}
```

## 2. Queue
큐는 FIFO(First In First Out)의 자료구조로 가장 먼저 들어온 데이터가 가장 먼저 나갈 수 있는 자료구조를 의미한다. 스택과 마찬가지로 Linked List나 Array로 주로 구현을 하지만 두 경우의 성능차이가 존재한다. push는 값을 queue의 제일 끝쪽에 추가하는 행동을 의미하고 pop은 queue의 제일 앞쪽에 존재하는 원소를 제거하고 꺼내는 행동을 의미한다. 이 때 Array로 구현을 할 경우 pop시 모든 원소를 한칸씩 앞쪽으로 이동시켜야하기 때문에 stack때와는 다르게 *O(n)* 의 pop 시간이 걸리게 된다. Linked List의 경우 *O(1)* 만에 해결할 수 있어 성능 차이가 난다. 여기서는 구현이 간편하도록 Array로 구현을 했다.

<img width="232" alt="Queue" src="https://user-images.githubusercontent.com/78075226/120432862-79822000-c3b5-11eb-9664-fadb2583d13a.png">

- Queue 구현
```swift
struct Queue <T> {
    var queue:[T] = []
    mutating func push(_ a: T) {
        queue.append(a)
    }
    mutating func pop() -> T? {
        if queue.isEmpty {
            return nil
        }
        else {
            return queue.removeFirst()
        }
    }
}
```

## 3. Deque
큐와 스택을 합친거 같은 자료구조로 맨 앞과 맨 뒤 모두에서 push와 pop이 가능한 구조이다. 마찬가지로 맨 앞에서 push와 pop을 하는것이 Array에서는 *O(n)* 이 걸리기 때문에 LinkedList로 구현하는 것이 좋다. 여기서는 구현이 편하도록 array로 구현하였다.

```swift
struct Deque <T> {
    var deque:[T] = []
    mutating func pushFront(_ a: T) {
        deque = [a] + deque
    }
    mutating func popFront() -> T? {
        if deque.isEmpty {
            return nil
        }
        else {
            return deque.removeFirst()
        }
    }
    mutating func pushBack(_ a: T) {
        deque.append(a)
    }
    mutating func popBack() -> T? {
        return deque.popLast()
    }
}
```

@ Stack 17298 6549 정리
@ queue 11866
@ deque 5430
