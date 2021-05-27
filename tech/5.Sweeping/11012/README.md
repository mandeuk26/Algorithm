# 백준 11012 Egg
총 n개의 점들의 위치가 주어질 때 사각형의 왼쪽과 오른쪽, 아래와 위의 좌표를 나타내주는 쿼리가 주어지면 해당 쿼리의 사각형 안에 총 몇개의 점들이 포함되어있는지 세는 문제이다. 
다른 방법도 있는 것 같지만 스위핑으로 풀 수 있다고 되어있어서 스위핑과 세그먼트 트리 개념만을 이용해서 풀었다.  
먼저 y좌표마다 점이 있는 x좌표를 표시해준다. 그 후 쿼리들을 저장시켜주는데 이 때 트릭이 필요하다. 다음 그림을 한번 보자.

<img width="157" alt="11012" src="https://user-images.githubusercontent.com/78075226/119868002-758b7380-bf59-11eb-8333-892784225344.png">

각 column마다 점이 등장하면 값에 1을 더해주는 형태로 좌표를 구성해보자. 이 때 우리가 빨갛게 칠한 영역내의 점들의 갯수를 구하고 싶다면 영역 최상단의 `1 + 1 + 2` 에서 영역 바로 아래에 해당하는 `1 + 0 + 1`을 빼주면 된다. 해당 영역에서 점이 나타났다면 그만큼 값이 증가했을 것이기 때문이다. 
```swift
for i in 0..<m {
    let parade = readLine()!.split(separator: " ").map{Int(String($0))!}
    arr.append((parade[0]+1, parade[1]+1, parade[2], i))
    arr.append((parade[0]+1, parade[1]+1, parade[3]+1, i))
}
arr.sort(by: {$0.2 < $1.2})
```
이 개념을 활용하여 영역 바로 아랫부분과 영역의 제일 윗부분으로 쿼리를 나눠서 각각 저장시켜준다. 그 후 array를 y좌표를 기준으로 정렬시켜준다. 이 때 쿼리를 나눠서 저장시킬 때 몇번째 쿼리인지를 같이 저장시켜줘야한다.
```swift
var index = 0
var result = 0
for p in arr {
    while index <= p.2 {
        for i in ydp[index] {
            updateTree(tree: &tree, start: 1, end: 100001, node: 1, index: i, val: 1)
        }
        index += 1
    }
    //index를 증가시키며 해당 라인에 있는 점들을 모두 업데이트
    let findresult = findTree(tree: tree, start: 1, end: 100001, node: 1, left: p.0, right: p.1)
    
    if paradeResult[p.3] == -1 {
        paradeResult[p.3] = findresult 
        //처음 만나는 쿼리라면 그냥 값을 저장
    }
    else {
        result += findresult - paradeResult[p.3] 
        //두번째 만나는 쿼리라면 차이만큼 결과에 더함 
    }
}
```
여기서부터는 세그먼트 트리만 알면 쉽다. y값이 작은 놈부터 쿼리가 저장되어있을텐데 해당 y값까지 index를 하나씩 증가시키면서 ydp[index] 위의 점들을 세그먼트 트리에 추가시켜준다. 그 후 우리가 원하는 구간에 대해 값을 구해준다.  
위에서 몇번째 쿼리인지 같이 저장한 이유가 여기서 나온다. 만약 처음 만나는 쿼리라면 쿼리의 아랫부분에 해당할 것이고 일단 그 값을 저장시킨다. 그 후 이미 만난적이 있는 쿼리라면 쿼리의 윗부분에 해당할 것이고 기존에 저장되어있던 값과의 차가 우리가 구하고자 하는 결과일 것이다.  

