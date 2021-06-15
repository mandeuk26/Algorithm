# 아호 코라식 (Aho-Corasick)
앞에서 KMP알고리즘을 배우고 온 상태에서 해당 공부를 하는 것을 추천한다.  
만약 다음과 같은 두 개의 문자열이 존재한다고하자.  
A의 길이를 N, B의 길이를 M이라 표현하겠다.  
A = "hshshi"  
B = "shsh"  
A속에 B가 존재하는지 확인하는 것은 KMP알고리즘을 사용할 시 *O(N+M)* 의 시간이 소요된다.  
  
그런데 만약 A속에 존재하는지 확인하고 싶은 문자열이 여러개라고 하자.  
다음과 같이 B는 문자열 집합으로 변한다.  
A = "hshshi"  
B = "shsh, shi, hshi"  
B 문자열 집합에는 k개의 원소가 존재한다고 했을 때 KMP알고리즘을 각각 적용하면 *O(kN + M1 + M2 ... Mk)* 의 시간이 걸리게 된다.  
즉 A문자열을 매번 전부 확인해줘야하기 때문에 N이 크다면 굉장히 많은 시간이 소요되게 될 것이다.  
  
## 1. Trie Make 알고리즘
이를 해결하기 위해서 아호 코라식 알고리즘이 등장했다.  
해당 알고리즘은 KMP알고리즘의 fail함수와 Trie를 섞어 만든 기법이다.  
먼저 B의 문자열 집합에 대해 Trie를 만든다고 하자.  
그렇다면 해당 그래프는 다음과 같이 나타날 것이다.  

<img width="565" alt="aho1" src="https://user-images.githubusercontent.com/78075226/122007349-cf61b980-cdf2-11eb-8983-f7fb6349b993.png">

만약 어떤 문자열을 따라서 HSH까지 왔다고 생각해보자.  
만약 그 뒤에 SH가 등장한다면 어떻게 해야할까?  
생각해보면 HSHSH라는 경로는 앞에 H를 탈락시키고 SHSH로 볼 수도 있다.  
그렇다면 HSHSH속에는 SHSH라는 B 문자열 집합 중 하나가 존재한다고 판별이 가능하다.  
  
이를 해결하기위해 HSH 경로의 마지막 H와 SH 경로의 H를 fail 관계라고 연결시켜줘보자.  
만약 HSH 이후에 S를 만난다면 더이상 나아갈 길이 없다.  
이 때 SH 경로의 H로 fail관계를 따라 돌아가게되면 S로 나아가는 새로운 길이 보인다.  
최종적으로 HSH -> SH -> SHSH로 HSHSH 속에서 SHSH라는 문자열을 찾아낼 수 있게 된다.  
우와 놀랍게도 KMP 알고리즘에서 fail함수를 거친 것처럼 현재 찾고있는 문자열이 변하게 된다.  
그렇다면 어떻게 fail 관계들을 설정하면 좋을까?  

<img width="557" alt="aho2" src="https://user-images.githubusercontent.com/78075226/122007356-d1c41380-cdf2-11eb-9927-0e8be9fef19c.png">

우리는 root부터 순차적으로 BFS로 Trie를 훑을 것이다.  
먼저 root와 연결된 S, H 정점에 대해서는 부모가 root기 때문에 fail 경로를 root로 선택해준다.  

<img width="552" alt="aho3" src="https://user-images.githubusercontent.com/78075226/122007357-d2f54080-cdf2-11eb-9cfb-3d8fd364c015.png">

다음 S -> H의 경우 S의 fail을 따라가면 root가 나온다.  
이 때 H로의 경로가 존재하기 때문에 root -> H와 S -> H의 H를 연결해준다.  
마찬가지로 H -> S의 S도 fail을 연결해준다.  
이 것의 의미는 만약 SH다음에 E라는 문자가 등장했을 때 경로가 존재하지 않는다면 H로 살펴보고 있던 경로를 함축시키고 HE라는 문자가 Trie에 있는지 확인하라는 의미가 된다.  

<img width="574" alt="aho4" src="https://user-images.githubusercontent.com/78075226/122007368-d4266d80-cdf2-11eb-9ebb-968ec23c4f60.png">

마찬가지로 다음 depth를 설정해준다.  
만약 부모의 fail을 따라갔을 때 여전히 경로가 존재하지 않는다면 경로가 존재할때까지 반복해서 거슬러내려가줘야한다는 것을 명심하자.  
I의 fail을 설정할 때 SH -> H -> root로 2번 반복해서 fail경로를 탐색했다.  
최종적으로 root에서도 경로가 없다면 root로 fail을 연결시킨다.  

<img width="605" alt="aho5" src="https://user-images.githubusercontent.com/78075226/122007371-d5579a80-cdf2-11eb-8ded-68ee76a89b57.png">

최종적으로 완성한 Trie는 위와 같다.  
Trie Class에 대한 코드와 Trie fail 관계를 설정해주는 ahocorasick 함수는 다음과 같다.  
- Trie Class
```swift
class Trie {
    var go:[Trie?] = Array(repeating: nil, count: 26)
    var fail:Trie?
    var output = false
    var isRoot = false
    
    func delete() {
        fail = nil
        for i in 0..<26 {
            if go[i] != nil {
                go[i]!.delete()
            }
            go[i] = nil
        }
    }
    
    func insert(key: String) {
        if key == "" {
            output = true
            return
        }
        let next = Int(key.first!.asciiValue!-97)
        if go[next] == nil {
            go[next] = Trie()
        }
        var tmp = key
        tmp.removeFirst()
        go[next]!.insert(key: tmp)
    }
}
```
- ahocorasick Function
```swift
func ahocorasick(root: Trie) {
    var q = [Trie]()
    q.append(root)
    while !q.isEmpty {
        let curr = q.removeFirst()
        for i in 0..<26 {
            if curr.go[i] == nil {continue}
            let next = curr.go[i]!
            if curr.isRoot {next.fail = root}
            else {
                var failure:Trie? = curr.fail
                while !(failure!.isRoot) && failure!.go[i] == nil {
                    failure = failure!.fail
                }
                if failure!.go[i] != nil {
                    failure = failure!.go[i]
                }
                next.fail = failure
            }
            if next.fail!.output {
                next.output = true
            }
            q.append(next)
        }
    }
}
```
root를 설정해주고 root에 여러 문자열들을 insert시키면 Trie 구조체를 만들 수 있다.  
그 후 root에 대해 ahocorasick 함수를 동작시켜 모든 fail관계를 구축해주면 된다.  
- Aho-Corasick Trie Make Code
```swift
var root = Trie()
root.isRoot = true
for s in StringSet {
    root.insert(key: s)
}
ahocorasick(root: root)
```
## 2. Find 알고리즘
이제 우리는 찾고자하는 문자열 집합에 대해 Trie를 완성시켰다.  
그러면 A라는 문자열을 쭉 훑으면서 B라는 집합 속의 문자열들이 등장하는지 확인할 것이다.  
방법으로는 KMP알고리즘처럼 쭉 훑다가 해당 문자로 나아갈 경로가 없다면 fail함수를 거쳐 새로운 경로를 찾는 것이다.  
방법 자체는 간단하니 한번 코드를 읽고 확인해주면 될 것 같다.  
여기서는 B 집합속의 원소를 하나라도 발견할 시 true를 리턴시켜주도록 구현이 되어있는데 문제 형태에 맞게 변형시켜주면 된다.  
- KMP Function
```swift
func KMP(root: Trie, str: String) -> Bool {
    var isFind = false
    var current:Trie? = root
    for c in str {
        let idx = Int(c.asciiValue!-97)
        while !(current!.isRoot) && current!.go[idx] == nil {
            current = current!.fail
        }
        if current!.go[idx] != nil {
            current = current!.go[idx]
        }
        if current!.output {
            isFind = true
            break
        }
    }
    return isFind
}
```
최종적으로 걸리는 시간은 Trie를 만드는데 *O(M1 + M2 + ... + Mk )* 문자열을 쭉 훑으면서 Trie속의 문자열들이 등장하는지 확인하는데 *O(N)* 이 걸리게 되어 총 *O(N + M1 + M2 + ... + Mk)* 이 소요된다.  

