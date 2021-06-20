func ccw(x1: Int, x2: Int, x3: Int, y1: Int, y2: Int, y3: Int) -> Int {
    let result = (x2-x1)*(y3-y1) - (y2-y1)*(x3-x1)
    if result > 0 {
        return 1
    }
    else if result == 0 {
        return 0
    }
    else {
        return -1
    }
}

func meet(x1: Int, x2: Int, x3: Int, x4: Int, y1: Int, y2: Int, y3: Int, y4: Int) -> Bool {
    var A = (x1, y1), B = (x2, y2), C = (x3, y3), D = (x4, y4)
    let ABC = ccw(x1: x1, x2: x2, x3: x3, y1: y1, y2: y2, y3: y3)
    let ABD = ccw(x1: x1, x2: x2, x3: x4, y1: y1, y2: y2, y3: y4)
    let CDA = ccw(x1: x3, x2: x4, x3: x1, y1: y3, y2: y4, y3: y1)
    let CDB = ccw(x1: x3, x2: x4, x3: x2, y1: y3, y2: y4, y3: y2)
    if ABC == 0 && ABD == 0 {
        if A > B {
            swap(&A, &B)
        }
        if C > D {
            swap(&C, &D)
        }
        if B >= C && D >= A {
            return true
        }
        else {
            return false
        }
    }
    else if ABC*ABD <= 0 && CDA*CDB <= 0 {
        return true
    }
    else {
        return false
    }
}

struct DisjointSet {
    var arr:[Int]
    var child:[Int]
    var isRoot:[Bool]
    var setCount:Int {
        get {
            var tmp = 0
            for i in 1...isRoot.count-1 {
                if isRoot[i] {
                    tmp += 1
                }
            }
            return tmp
        }
    }
    var maxSet:Int? {
        return child.max()
    }
    init(_ n: Int) {
        arr = [Int](0...n)
        child = Array(repeating: 1, count: n+1)
        isRoot = Array(repeating: true, count: n+1)
    }
    mutating func findRoot(_ n: Int) -> Int {
        if arr[n] == n {
            return n
        }
        else {
            let root = findRoot(arr[n])
            arr[n] = root
            return root
        }
    }
    mutating func union(_ a: Int, _ b: Int) {
        let rootA = findRoot(a), rootB = findRoot(b)
        if rootA == rootB {
            return
        }
        else if rootB > rootA {
            arr[rootB] = rootA
            child[rootA] += child[rootB]
            isRoot[rootB] = false
        }
        else {
            arr[rootA] = rootB
            child[rootB] += child[rootA]
            isRoot[rootA] = false
        }
    }
}

let n = Int(readLine()!)!
var line:[(x1:Int, y1:Int, x2:Int, y2:Int)] = [(0, 0, 0, 0)]
var disjoint = DisjointSet(n)
for _ in 1...n {
    let l = readLine()!.split(separator: " ").map{Int(String($0))!}
    line.append((x1:l[0], y1:l[1], x2:l[2], y2:l[3]))
}
for i in 1..<n {
    for j in i+1...n {
        let line1 = line[i], line2 = line[j]
        if meet(x1: line1.x1, x2: line1.x2, x3: line2.x1, x4: line2.x2, y1: line1.y1, y2: line1.y2, y3: line2.y1, y4: line2.y2) {
            disjoint.union(i, j)
        }
    }
}

print(disjoint.setCount)
print(disjoint.maxSet!)

