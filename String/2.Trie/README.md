# Trie
문자열을 효율적으로 저장하기위해 고안된 일종의 자료구조이다.  
사전 속에 수많은 단어가 저장되어있고 그 중에서 특정 단어를 찾고자 한다고 하자.  
만약 사전 속에 수많은 단어가 하나씩 저장되어 있다면 특정 단어를 찾고자한다면 모든 사전 속의 단어를 살펴봐야할 수 도 있다.  
이 때 이를 해결하고자 등장한 것이 Trie이다.  
먼저 알파벳의 단어들을 다 쪼개서 트리 형태로 저장시킬 것이다.  
ban, bee, be, cat, cash라는 단어들이 사전에 저장되어 있다고 하자.  

<img width="510" alt="Trie" src="https://user-images.githubusercontent.com/78075226/121799500-84676b00-cc67-11eb-9466-32470b18eee4.png">

이 때 주황색으로 표시된 부분은 해당 위치에서 끝나는 단어가 존재한다는 의미이다.  
위처럼 단어들을 저장하게 되면 중복해서 등장하는 부분을 생략할 수 있기 때문에 탐색시 드는 시간소요가 줄어들게 된다.  
따라서 사전 속 가장 긴 단어가 L의 길이를 갖고있다고 했을 때 탐색하는 과정은 *O(L)* 의 시간이 걸리게 된다.  
탐색이 훨씬 빠르다는 장점이 있으나 각 노드별로 자식들에 대한 정보를 갖고 있어야하기 때문에 저장공간이 많이 필요하다는 단점이 존재한다.  
탐색 알고리즘은 dfs를 이용해서 단어를 한 문자씩 트리에서 찾아 내려가주면 된다.  
  
생성시 시간복잡도는 단어 하나를 insert 하는데 *O(L)* 이 걸리고 총 M개의 단어를 저장한다고 하면 *O(ML)* 이 걸리게 된다.  
탐색시 시간복잡도는 단어 하나를 찾을 때마다 최대 L의 길이를 탐색하게 될 것이므로 *O(L)* 이 소요된다.  
- Trie Code
```swift
var trie = Array(repeating: Array(repeating: 0, count: 26), count: 5000001)
var check = Array(repeating: false, count: 5000001)
var nextNode = 1
func maketrie(str: String) {
    var node = 0
    for i in str {
        let idx = Int(i.asciiValue!) - 97
        if trie[node][idx] == 0 {
            trie[node][idx] = nextNode
            node = nextNode
            nextNode += 1
        }
        else {
            node = trie[node][idx]
        }
    }
    check[node] = true
}
```
