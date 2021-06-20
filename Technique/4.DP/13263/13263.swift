struct line {
    var a:Int
    var b:Int
    var x:Double
    func f(_ xx: Int) -> Int {
        return a*xx+b
    }
}

let INF:Double = 1_000_000_007
var stack:[line] = []
var ptr = 0

func intersect(a: line, b: line) -> Double {
    return Double(b.b-a.b)/Double(a.a-b.a)
}

func addLine(a: Int, b: Int) {
    var tmp = line(a: a, b: b, x: -INF)
    if stack.isEmpty {
        stack.append(tmp)
        return
    }
    while !stack.isEmpty {
        let top = stack.last!
        let x = intersect(a: top, b: tmp)
        if x <= top.x {
            stack.removeLast()
        }
        else {
            break
        }
    }
    tmp.x = intersect(a: stack.last!, b: tmp)
    stack.append(tmp)
    if ptr >= stack.count {
        ptr = stack.count-1
    }
}

func query(x: Int) -> Int {
    while ptr < stack.count-1 && stack[ptr+1].x < Double(x) {
        ptr += 1
    }
    return stack[ptr].f(x)
}

let n = Int(readLine()!)!
var a = readLine()!.split(separator: " ").map{Int(String($0))!}
var b = readLine()!.split(separator: " ").map{Int(String($0))!}
var dp = Array(repeating: 0, count: n)
addLine(a: b[0], b: dp[0])
for i in 1..<n {
    dp[i] = query(x: a[i])
    addLine(a: b[i], b: dp[i])
}
print(dp[n-1])

