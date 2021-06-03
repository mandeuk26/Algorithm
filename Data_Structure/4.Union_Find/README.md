# Union-Find
Disjoint Set을 구현할 때 사용하는 자료구조로 두 집합을 하나로 합쳐주는 것을 용이하게 해주는 자료구조이다. 두 집합이 한 집합이 된다면 한 집합의 root 노드가 다른 집합의 child로 들어가게되는 형태이다.  
크게 union 함수와 find 함수 구현으로 이루어져있다. Array를 이용하여 구현할 것인데 본인의 parent의 array index가 무엇인지를 저장해주는 parent array 하나를 이용할 것이다. 초기값으로는 자기 자신이 본인의 부모가 되도록 구현한다. 
## 1. Find 함수
먼저 find 함수를 알아보자. 만약 어떤 노드에 find를 하게된다면 본인이 속한 집합의 root node가 나올때까지 재귀적으로 반복해서 find함수를 호출한다. 그 후 해당 root node를 return 해준다. 이 때 시간 단축을 위해 path compression 이라는 기법을 사용한다.
- Path Compression

<img width="469" alt="pathcompression" src="https://user-images.githubusercontent.com/78075226/120497790-a9ebad80-c3f9-11eb-9b91-adbda1b7d615.png">

Path Compression이란 find함수를 거쳐 재귀적으로 root를 찾았을 경우 거쳐온 경로의 노드들이 root를 바로 가르키도록 경로를 압축시켜주는 것을 의미한다. 이렇게 될 경우 한번이라도 find 함수를 거친 노드들은 parent 배열에 root를 저장하고 있기 때문에 후에 find 함수가 일어날 경우 *O(1)* 만에 root를 찾아줄 수 있다.

- Find Function
```swift
mutating func find(_ n: Int) -> Int {
    if n == parent[n] {
        return n
    }
    else {
        let root = find(parent[n])
        parent[n] = root
        return root
    }
}
```

## 2. Union 함수
두 집합을 하나로 합쳐주는 방법으로 한 집합의 root가 다른 집합의 일부분이 되도록 구현한다. 이 때 union by rank 라는 기법을 사용해서 집합을 합친다. 여기서는 node index가 작은 root에 큰 root가 child로 합쳐지도록 union을 구현했다.
- Union by Rank

<img width="746" alt="unionbyrank" src="https://user-images.githubusercontent.com/78075226/120497745-a1937280-c3f9-11eb-9d65-a2e099f91422.png">

Union by Rank란 두 집합을 합칠 때 rank의 값이 작은 집합이 rank가 큰 집합 root의 자식으로 들어가는 방식이다. 이렇게 구현할 경우 계속해서 집합을 합칠 때 전체 rank가 logN 이상 길어지지 않도록 조절해주는 역할을 한다. rank가 길어지는 것은 후에 find 함수에서 성능 저하를 불러일으키기 때문에 중요한 부분이다. 
- Union Function
```swift
mutating func union(_ a: Int, _ b: Int) {
    let findA = find(a), findB = find(b)
    if findA < findB {
        parent[findB] = findA
    }
    else {
        parent[findA] = findB
    }
}
```

- 전체 코드
```swift
struct DisjointSet {
    var parent:[Int]
    init(_ n: Int) {
        parent = [Int](0...n)
    }
    mutating func find(_ n: Int) -> Int {
        if n == parent[n] {
            return n
        }
        else {
            let root = find(parent[n])
            parent[n] = root
            return root
        }
    }
    mutating func union(_ a: Int, _ b: Int) {
        let findA = find(a), findB = find(b)
        if findA < findB {
            parent[findB] = findA
        }
        else {
            parent[findA] = findB
        }
    }
}
```
@@ 4195, 20040 정리
