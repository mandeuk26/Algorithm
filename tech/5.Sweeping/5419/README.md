# 백준 5419 북서풍
이 문제를 풀기 위해서는 총 3개의 개념을 알아야한다. 첫번째로는 스위핑이고 두번째로는 세그먼트트리 (여기서는 팬윅트리로 구현했지만 세그먼트로도 가능하다), 마지막으로는 좌표압축이다. 좌표압축은 간단하지만 세그먼트 트리는 모르면 힘들기 때문에 세그먼트 트리 파트를 가서 공부하고 다시 푸는 것을 추천드린다.
먼저 문제는 간단하다. 좌표상에 수많은 점이 주어지면 본인보다 x값은 같거나 작고 y값은 크거나 같은 점들의 갯수를 모든 점에 대해서 세어주면 된다.  
- 스위핑
```swift
island.sort(by: {$0.0 < $1.0})
island.sort(by: {$0.1 > $1.1})
```
우리는 x축, y축 두가지에 대해 모두 고려를 해줘야하기 때문에 앞선 문제들과는 다르게 쉽사리 접근하기가 어렵다. 먼저 스위핑을 사용하여 sort를 2번 사용하여 y축에 대해서 큰 값부터 작은 값이 오도록 정렬하되 y값이 같다면 x값이 작은 점이 먼저 오도록 정렬을 하자. 그러면 y축에 대해서는 고려를 이제 안해줘도 된다는 것이 보일 것이다.  
- 세그먼트(펜윅) 트리
```swift
var result:CLongLong = 0
for s in islandX {
    result += CLongLong(fenwickFind(fwk: tree, index: s))
    fenwickUpdate(fwk: &tree, index: s, val: 1, n: n)
}
```
그렇다면 x축 값이 본인보다 작은 녀석들의 갯수를 모두 세줘야하는데 이 때 생각나는 것이 세그먼트 트리이다. 세그먼트를 활용하여 본인보다 작거나 같은 범위에 있는 점들의 갯수를 구해주면 된다. 그 후 점이 1개 추가되었으므로 본인 위치에 1만큼 값을 update해준다. 이 때 정렬된 순서로 확인하기 때문에 1을 업데이트 해줘야 나중에 살펴볼 점들이 본인을 count한다는 것을 알 수 있다.  
그런데 여기서 fenwick트리를 사용하려고 하니 x좌표 범위가 음수까지 있어서 어떻게 배열로 나타내야 할지 당황할 수 있다. 이 때 사용하는 것이 좌표압축이다.
```swift
func arrMapedX(arr: [(Int, Int)]) -> [Int] {
    let arr_sorted = arr.sorted(by: {$0.0 < $1.0})
    var index = 1
    var dict = Dictionary<Int, Int>()
    for i in arr_sorted {
        guard dict[i.0] != nil else {
            dict[i.0] = index
            index += 1
            continue
        }
    }
    var tmp = [Int]()
    for i in arr {
        tmp.append(dict[i.0]!)
    }
    return tmp
}
```
좌표압축은 그렇게 어려운 코드가 아니니까 한번 읽어보면 이해가 갈 것이다. dictionary 구조체를 활용하여 가장 작은 값부터 1부터 증가하는 번호를 매긴 후 원래 배열의 값들을 바뀐 번호로 압축시키는 형태이다. 이렇게 되면 넓은 범위를 가지거나 음수의 범위가 나타나도 팬윅트리를 활용할 수 있는 범위로 바뀐다. (좌표간의 대소관계가 중요한 것이지 그 차이가 중요한 것이 아니기 때문에 좌표압축을 사용할 수 있다)  
  
파일의 입력이 크기때문에 fread를 해줘야 시간초과가 안난다. 관련 코드는 JCSooHwanCho님의 FileIO.swift 를 참조하였다.  
<출처 : https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88>
