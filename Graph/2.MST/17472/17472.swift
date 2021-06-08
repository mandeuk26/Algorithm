struct DisjointSet {
    var arr:[Int]
    init(_ n: Int) {
        arr = [Int](0...n)
    }
    mutating func findRoot(_ n:Int) -> Int {
        if arr[n] == n {
            return n
        }
        else {
            let root = findRoot(arr[n])
            arr[n] = root
            return root
        }
    }
    mutating func union(_ n: Int, _ m: Int) -> Bool {
        let rootN = findRoot(n), rootM = findRoot(m)
        if rootN == rootM {
            return false
        }
        else if rootN < rootM {
            arr[rootM] = rootN
        }
        else {
            arr[rootN] = rootM
        }
        return true
    }
}

let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1]
var island:[[Int]] = []
var check:[[Bool]] = Array(repeating: Array(repeating: false, count: m), count: n)
for _ in 1...n {
    island.append(readLine()!.split(separator: " ").map{Int(String($0))!})
}

var islandCount = 1
for i in 0..<n {
    for j in 0..<m {
        if island[i][j] == 1 && !check[i][j] {
            dfs(x: j, y: i, islandNum: islandCount)
            islandCount += 1
        }
    }
}
islandCount -= 1

var node:[(n: Int, m: Int, d: Int)] = []
for i in 0..<n {
    for j in 0..<m {
        if island[i][j] != 0 {
            for d in 1...4 {
                bridgeAdd(x: j, y: i, count: 1, direction: d)
            }
        }
    }
}

node.sort(by: {$0.d < $1.d})
var disjoint = DisjointSet(islandCount)
var index = 0
var result = 0
var visited = 1
let count = node.count
while visited < islandCount && index < count {
    let current = node[index]
    index += 1
    if disjoint.union(current.n, current.m) {
        result += current.d
        visited += 1
    }
}
print(visited == islandCount ? result : -1)

func dfs(x: Int, y: Int, islandNum: Int) {
    check[y][x] = true
    island[y][x] = islandNum
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]
    for k in 0...3 {
        let nextX = x + dx[k], nextY = y + dy[k]
        if nextX < 0 || nextX >= m || nextY < 0 || nextY >= n {
            continue
        }
        if island[nextY][nextX] == 1 && !check[nextY][nextX] {
            dfs(x: nextX, y: nextY, islandNum: islandNum)
        }
    }
}

func bridgeAdd(x: Int, y: Int, count: Int, direction: Int) {
    var nextX = x, nextY = y
    switch direction {
    case 1:
        nextY = y-count
    case 2:
        nextY = y+count
    case 3:
        nextX = x+count
    case 4:
        nextX = x-count
    default:
        print("error")
    }
    if nextX < 0 || nextX >= m || nextY < 0 || nextY >= n {
        return
    }
    else {
        let next = island[nextY][nextX]
        if next == 0 {
            bridgeAdd(x: x, y: y, count: count+1, direction: direction)
        }
        else if next != island[y][x] && count > 2 {
            node.append((n: island[y][x], m: next, d: count-1))
        }
    }
}

