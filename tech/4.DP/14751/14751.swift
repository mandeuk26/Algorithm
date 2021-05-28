struct line {
    var up: Int64
    var down: Int64
    var idx: Int
    init() {
        up = 0
        down = 0
        idx = -1
    }
    init(up: Int64, down: Int64, idx: Int) {
        self.up = up
        self.down = down
        self.idx = idx
    }
}
let Y = readLine()!.split(separator: " ").map{Int64(String($0))!}
let maxY = Y[0], minY = Y[1]
var stack:[line] = Array(repeating: line(), count: 100001)
var sz = 0

func insert(v: line) {
    stack[sz] = v
    while sz != 0 && (stack[sz].down-stack[sz].up) == (stack[sz-1].down-stack[sz-1].up) && stack[sz].up < stack[sz-1].up {
        stack[sz-1] = stack[sz]
        sz -= 1
    }
    while sz > 1 && compare3(p: sz-2, q: sz-1, r: sz){
        stack[sz-1] = stack[sz]
        sz -= 1
    }
    sz += 1
}

func compare3(p: Int, q: Int, r: Int) -> Bool {
    let a1 = stack[p], a2 = stack[q], a3 = stack[r]
    return (a2.up-a1.up)*(maxY-minY)*(a2.down-a2.up-a3.down+a3.up) > (a3.up-a2.up)*(maxY-minY)*(a1.down-a1.up-a2.down+a2.up)
}

func compareX(p: Int, q: Int, x: Double) -> Bool {
    let a1 = stack[p], a2 = stack[q]
    return Double(a2.up-a1.up)*Double(maxY-minY) < x*Double(a1.down-a1.up-a2.down+a2.up)
}

func sol(x: Double) -> Int {
    var lo = 0, hi = sz-1
    while lo < hi {
        let mid = (lo+hi)/2
        if compareX(p: mid, q: mid+1, x: x) {
            lo = mid+1
        }
        else {
            hi = mid
        }
    }
    return stack[hi].idx
}

let n = Int(readLine()!)!
var lineSet:[line] = []
for i in 1...n {
    let X = readLine()!.split(separator: " ").map{Int64(String($0))!}
    lineSet.append(line(up: X[0], down: X[1], idx: i))
}
lineSet.sort(by: {($0.down-$0.up) > ($1.down-$1.up)})
for i in lineSet {
    insert(v: i)
}
let m = Int(readLine()!)!
var str = ""
for _ in 0..<m {
    let tmp = Double(maxY) - Double(readLine()!)!
    str += "\(sol(x: tmp))\n"
}
print(str, terminator: "")

