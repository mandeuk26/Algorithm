# 백준 14725 개미굴
trie의 구조를 root부터 leaf 노드까지 하나씩 나열한 결과들이 주어진다고 했을 때 trie를 시각화된 구조로 출력하는 문제이다.  
유의할 것은 앞에서 했던 trie와는 다르게 문자열이 하나의 노드가 될 수 있다는 점이다.  
따라서 trie의 노드별로 Dictionary<String, Int> 구조체를 갖고있도록 설정해주었다.  
만약 해당 String이 현재 노드에서 자식 노드로 연결되어 있다면 현재 노드의 Dictionary에서 자식 노드의 Trie index을 return 해주도록 설정했다.  
```swift
var trie = Array(repeating: Dictionary<String, Int>(), count: 1)
//trie는 딕셔너리의 배열로 나타내주었다.
func maketrie(str: [String], trie: inout [Dictionary<String, Int>], check: inout [Bool]) {
    var node = 0
    for i in 1...Int(str[0])! {
        let tmp = str[i]
        if trie[node][tmp] == nil {
        // 현재 trie 노드에서 tmp 문자열로의 경로가 없을 때
            trie[node][tmp] = trie.count
            node = trie.count
            trie.append(Dictionary<String, Int>())
            check.append(false)
        }
        else {
        // 경로가 있다면 노드를 자식 노드로 이동!
            node = trie[node][tmp]!
        }
    }
    check[node] = true
}
```
위의 코드는 maketrie 함수의 일부로 만약 현재 node에 tmp라는 문자열이 입력된 적이 없다면 dictionary는 nil을 return해 줄 것이고 trie 배열에 새롭게 노드를 추가시켜주도록 구현했다.  
이 때 각 노드의 index 번호는 생성되는 순서로 매겨주어 부모 노드의 dictinary에 해당 index 번호를 저장시켜두는 형태로 구현했다.  

최종적으로 모든 입력에 대해 trie를 구축하고 나면 dfs를 통해 출력해주면 된다.  
유의할 점은 사전 순으로 먼저 나오게 해야하기 때문에 dictionary를 정렬시켜서 dfs를 적용시키자.  
출력 형태에 맞게 depth에 맞게 --를 반복적으로 사용해야 하는 것도 잊지말자.  


