# 백준 2261 가장 가까운 두 점
2차원 좌표평면상의 여러 점들 중에서 가장 가까운 두 점 사이의 거리를 출력하는 문제이다. 대학교 시절에도 과제로 나왔었을 정도로 유명한 문제이다. 핵심 포인트는 스위핑과 분할정복이 사용된다. 스위핑이 뭔지 모르더라도 특정 좌표순으로 정렬한 후에 좌표값이 작은놈부터 하나씩 확인한다고 알고있으면 된다.
- findMin함수 (비교대상수 4 미만)
```swift
func findMin(start:Int, end:Int) -> Int {
    if end - start < 3 {
        var result = 1_000_000_000
        for i in start...end {
            for j in start...i {
                if i == j {continue}
                let xdis = arr[j].x-arr[i].x
                let ydis = arr[j].y-arr[i].y
                result = min(result, xdis*xdis + ydis*ydis)
            }
        }
        return result
    }
```
이번 코드의 핵심이 되는 findMin 함수이다. 좌표상의 좌표들을 x좌표가 작은 것 순으로 0번부터 n-1번까지 번호를 매겼을때 시작 번호와 끝 번호를 주면 해당 번호 사이에서 가장 작은 거리를 출력해주는 기능을 한다. 먼저 두 번호 차이가 2이하일 경우 해당 점들간의 거리를 일일히 계산해준 후 가장 작은 값을 넘겨주도로 구현했다. 이 때 d<sup>2</sup> 을 구하도록해서 소수점 문제를 무시하도록 구현했다.
- findMin함수 (비교대상수 4 이상)
```swift
else {
        let d = min(findMin(start: start, end: (start+end)/2-1), findMin(start: (start+end)/2+1, end: end))
        if d == 0 {return 0}
        let sqrtD = Int(sqrt(Double(d))) + 1
        var result = d
        let xdis = arr[(start+end)/2]
        var list:[(x:Int, y:Int)] = []
        //왼쪽구역 list 추가
        for i in 0...(end-start)/2 {
            let idis = arr[(start+end)/2 - i]
            if xdis.x - idis.x >= sqrtD {
                break
            }
            list.append(idis)
        }
        //오른쪽 구역 list 추가
        for i in 1...(end-(start+end)/2) {
            let idis = arr[(start+end)/2 + i]
            if idis.x - xdis.x >= sqrtD {
                break
            }
            list.append(idis)
        }
        //y좌표순으로 정렬 후 거리비교
        list.sort(by: {$0.y < $1.y})
        for i in 0..<list.count {
            for j in i+1..<list.count {
                if list[j].y - list[i].y >= sqrtD {
                    break
                }
                else {
                    let xdis = list[j].x-list[i].x
                    let ydis = list[j].y-list[i].y
                    result = min(result, xdis*xdis + ydis*ydis)
                }
            }
        }
        return result
    }
}
```
이어서 확인해야할 좌표수가 4개 이상일 경우 else 구문에서 처리하도록 하였다. 핵심 아이디어는 정중앙 인덱스를 기준으로 좌측과 우측 각각에 대해서 분할정복을 실시한다는 것이다. 하지만 왼쪽 구역, 오른쪽 구역의 최솟값을 각각 구해 전체 최솟값인 d를 구했다하더라도 이것이 정답이 되지는 않는다. 왼쪽 구역과 오른쪽 구역의 점 간에 d보다 작은 거리가 나타날수도 있기 때문이다. 따라서 정중앙 점을 기준으로 해당 점으로부터 x축으로 d만큼 떨어진 녀석들간의 거리를 추가로 비교해줘야한다. 이 때 x좌표 기준으로 오름차순 정렬을 했기 때문에 어떤 점이 정중앙 점과 d보다 더 멀리 떨어져있다면 반대측 영역과도 d보다 멀리 떨어져있기 때문에 고려해줄 필요가 없다.  

<img width="272" alt="1130" src="https://user-images.githubusercontent.com/78075226/119613749-68c32e80-be38-11eb-8e73-f8ae1adf6682.png">  

mid의 x좌표를 정중앙으로 하는 2d의 영역을 생각해보자. mid index로부터 1씩 감소시키면서 mid 좌표와 해당 좌표간의 거리가 d이하인 좌표들을 모두 list에 추가시켜준다. 마찬가지로 mid부터 1씩 증가시키면서 오른쪽 구간도 모두 추가해준다. 위의 사진에서 두 선 사이의 있는 영역에 있는 점들은 모두 list에 추가가 된 것이다.  
이제 list안의 점들중에서 d보다 작은 거리를 찾아주기만 하면 끝이다. 하지만 단순히 모든 점을 비교하면 너무 많은 계산을 하게 된다. 그렇기 때문에 앞서 사용했던 개념을 y좌표에 대해서도 적용시킨다. list를 y좌표 순으로 다시 정렬을 한 후 두 점 사이의 y거리가 d이하인 녀석들간의 거리를 비교해줄 것이다. 즉 list의 모든 점들에 대해서 사진의 주황색 영역처럼 일정 범위내의 점들과만 비교해주는 것이다.
- 메인코드
```swift
import Foundation
let n = Int(readLine()!)!
var arr:[(x:Int, y:Int)] = []
for _ in 1...n {
    let l = readLine()!.split(separator: " ").map{Int($0)!}
    arr.append((x:l[0], y:l[1]))
}
arr.sort(by: {$0.x < $1.x})
print(findMin(start: 0, end: n-1))
```

