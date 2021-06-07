# 백준 1017 소수 쌍
수의 리스트가 주어졌을 때 각 쌍의 합이 소수가 되게 하려고한다.  
이 때 모든 수를 다 짝지을 수 있는 경우 중에서 첫번째 원소가 짝지은 수를 오름차순으로 나타내는 문제이다.  
두 수의 합이 소수가 되려면 2를 제외하고는 모두 소수가 홀수라는 점을 이용해야한다.  
리스트 내의 수는 중복이 될 수 없으므로 2가 소수 쌍으로 나타날 수는 없다.  
따라서 모든 소수 쌍은 짝수 1개와 홀수 1개의 합으로 이루어져야 한다.  
이렇게 되니 주어지는 수들을 홀수 짝수 그룹으로 나누는데 첫번째 원소가 A 그룹의 첫번째 원소가 되도록 그룹을 나누자.  
- Group Divide Code
```swift
for i in num {
    if num[0]%2 == i%2 {
        numA.append(i)
    }
    else {
        numB.append(i)
    }
}
```
이제 A그룹과 B그룹 간의 이분 매칭을 해서 전체의 절반에 해당하는 매칭이 이루어지는지 확인하면 된다.  
이 때 유의할 점으로는 A그룹의 첫번째 원소의 매칭은 dfs 함수 내에서 고정시켜주고 진행해야 한다.  
또한 두 수의 합이 소수인 경우에만 간선이 존재한다고 생각하고 진행해야한다.  
- DFS Function
```swift
func dfs(nodeA: Int) -> Bool {
    for nodeB in 0..<n/2 where nodeB != pick { 
    // pick은 첫번째 원소와 매칭된 정점을 의미한다.
        if visited[nodeB] {
            continue
        }
        if Prime[numA[nodeA] + numB[nodeB]] {
        // 두 수의 합이 소수인 경우에만 진행
            visited[nodeB] = true
            if matchB[nodeB] == -1 || dfs(nodeA: matchB[nodeB]) {
                matchB[nodeB] = nodeA
                return true
            }
        }
    }
    return false
}
```
