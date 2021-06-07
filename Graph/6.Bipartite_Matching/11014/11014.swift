var left:[(Int, Int)] = []
var right:[(Int, Int)] = []
var left2right:[[Int]] = []
var check:[Bool] = []
var right2left:[Int] = []

func isNear(a: (Int, Int), b: (Int, Int)) -> Bool {
    let dx = a.0 - b.0
    let dy = a.1 - b.1
    return dx*dx+dy*dy <= 2
}

func dfs(leftIdx: Int) -> Bool {
    for rightIdx in left2right[leftIdx] {
        if check[rightIdx] {
            continue
        }
        check[rightIdx] = true
        if right2left[rightIdx] == -1 || dfs(leftIdx: right2left[rightIdx]) {
            right2left[rightIdx] = leftIdx
            return true
        }
    }
    return false
}

let t = Int(readLine()!)!
var str = ""
for _ in 0..<t {
    let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n = nm[0], m = nm[1]
    var xCount = 0, result = 0
    left = []
    right = []
    for i in 0..<n {
        let line = readLine()!.map{Character(String($0))}
        for j in 0..<line.count {
            if line[j] == "." {
                if j%2 == 0 {left.append((i, j))}
                else {right.append((i, j))}
            }
            else {xCount += 1}
        }
    }
    let rcount = right.count, lcount = left.count
    left2right = Array(repeating: [], count: lcount)
    check = Array(repeating: false, count: rcount)
    right2left = Array(repeating: -1, count: rcount)
    for i in 0..<lcount {
        for j in 0..<rcount {
            if isNear(a: left[i], b: right[j]) {
                left2right[i].append(j)
            }
        }
    }
    
    for idx in 0..<lcount {
        check = Array(repeating: false, count:rcount)
        if dfs(leftIdx: idx) {
            result += 1
        }
    }
    str += "\(n*m-xCount-result)\n"
}
print(str)
