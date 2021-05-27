# 백준 2170 선 긋기
선분의 시작과 끝이 주어지고 그러한 선들이 n개 있다고 할 때 그려지는 선들의 총 길이를 구하는 문제이다. 이 때 겹치는 부분은 1번만 계산한다.  
스위핑에 대해 감을 익히기 좋은 문제인것 같다. 선들을 시작점을 기준으로 sort한다고 생각하자. 그렇다면 연속된 두 선분의 관계는 다음 세 경우로 나뉜다.
```
1. line[i].end <= line[i+1].start
2. line[i].end > line[i+1].start && line[i].end >= line[1+1].end
3. line[i].end > line[i+1].start && line[i].end < line[i+1].end
```
1) 1번의 경우에는 두개의 선분이 겹치는 부분이 없을때이므로 새로운 선분의 길이를 더해주면 된다.  
2) 2, 3번의 경우에는 두개의 선분이 겹치는 부분이 생긴다. 이 때 뒷 선분이 앞 선분에 포함되는 경우가 2번에 해당한다. 새로운 선분의 길이는 이 때 전부 겹치기 때문에 더해줄 필요가 없이 넘어간다.  
3) 3번의 경우에는 뒷 선분의 end와 앞 선분의 end의 차만큼을 더해줘야 한다.
```swift
var left = -1_000_000_000, right = -1_000_000_000, result = 0
for l in line {
    if right < l.0 {
        left = l.0
        right = l.1
        result += right-left
    }
    //case 1
    else if l.1 > right {
        result += l.1-right
        right = l.1
    }
    //case 3
}
```
이 때 단순히 앞 선분과 비교를 하는 것이 아니라 여지껏 누적해온 선분들의 가장 오른쪽 좌표와 비교를 해야하기 때문에 right라는 변수를 활용하여 이를 비교해주었다.  
파일의 입력이 크기때문에 fread를 해줘야 시간초과가 안난다. 관련 코드는 JCSooHwanCho님의 FileIO.swift 를 참조하였다. <출처 : https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88>  
