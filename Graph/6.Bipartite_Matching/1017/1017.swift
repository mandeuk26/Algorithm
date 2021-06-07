let n = Int(readLine()!)!
let num = readLine()!.split(separator: " ").map{Int(String($0))!}
var matchB:[Int] = Array(repeating: -1, count: n/2)
var visited:[Bool] = Array(repeating: false, count: n/2)
var numA:[Int] = []
var numB:[Int] = []
var Prime:[Bool] = Array(repeating: true, count: 2001)
var pick = 0

func dfs(nodeA: Int) -> Bool {
    for nodeB in 0..<n/2 where nodeB != pick {
        if visited[nodeB] {
            continue
        }
        if Prime[numA[nodeA] + numB[nodeB]] {
            visited[nodeB] = true
            if matchB[nodeB] == -1 || dfs(nodeA: matchB[nodeB]) {
                matchB[nodeB] = nodeA
                return true
            }
        }
    }
    return false
}


for i in 2...50 {
    if Prime[i] {
        var idx = 2*i
        while idx <= 2000 {
            Prime[idx] = false
            idx += i
        }
    }
}

for i in num {
    if num[0]%2 == i%2 {
        numA.append(i)
    }
    else {
        numB.append(i)
    }
}

if numA.count != numB.count {
    print(-1)
}
else {
    var success:[Int] = []
    for j in 0..<n/2 {
        if Prime[numA[0] + numB[j]] {
            pick = j
            matchB = Array(repeating: -1, count: n/2)
            var count = 1
            for i in 1..<n/2 {
                visited = Array(repeating: false, count: n/2)
                if dfs(nodeA: i) {
                    count += 1
                }
            }
            if count == n/2 {
                success.append(numB[j])
            }
        }
    }
    success.sort{$0 < $1}
    var str = ""
    for i in success {
        str += "\(i) "
    }
    print(success.count > 0 ? str : "-1")
}

