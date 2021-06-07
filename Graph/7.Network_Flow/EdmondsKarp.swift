let n = 10
var c:[[Int]] = Array(repeating: Array(repeating: 0, count: n+1), count: n+1)
var f:[[Int]] = Array(repeating: Array(repeating: 0, count: n+1), count: n+1)

// 함수를 쓰기 전에 꼭 capacity 배열을 조건에 맞게 설정해준다.

func edward(s: Int, e: Int) -> Int {
    var result = 0
    while true {
        var parent:[Int] = Array(repeating: -1, count: n+1)
        var q = [Int]()
        parent[s] = s
        q.append(s)
        // BFS로 경로를 찾을때마다 parent배열과 q배열을 초기화시켜줘야한다.
        while !q.isEmpty && (parent[e] == -1) {
            let curr = q.removeFirst()
            for i in 1...n {
                if c[curr][i] - f[curr][i] > 0 && parent[i] == -1 {
                //flow가 흐를 수 있는 경로에 대해서만 흘려준다.
                    parent[i] = curr
                    q.append(i)
                }
            }
        }
        if parent[e] == -1 {
            break
        // 흐를 수 있는 경로가 더이상 없으면 break!
        }
        var idx = e
        var minF = 1_000_000_000
        while idx != s {
            let prev = parent[idx]
            minF = min(minF, c[prev][idx]-f[prev][idx])
            idx = prev
        }
        // minimum Flow 찾는 과정
        idx = e
        while idx != s {
            let prev = parent[idx]
            f[prev][idx] += minF
            f[idx][prev] -= minF
            idx = prev
        }
        // flow 배열 update
        result += minF
    }
    return result
}

print(edward(s: 1, e: 2))
