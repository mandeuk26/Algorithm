
func ccw(a: (Int, Int), b: (Int, Int), c: (Int, Int)) -> Int {
    let result = (b.0-a.0)*(c.1-a.1) - (b.1-a.1)*(c.0-a.0)
    return result > 0 ? 1 : (result == 0 ? 0 : -1)
}

func dist(a: (Int, Int), b: (Int, Int)) -> Int {
    let dx = a.0 - b.0, dy = a.1-b.1
    return dx*dx + dy*dy
}

func check(a: (Int, Int), set: [(Int, Int)]) -> Bool {
    let count = set.count
    for i in 0..<count {
        if ccw(a: set[i], b: set[(i+1)%count], c: a) <= 0 {
            return false
        }
    }
    return true
}

func notCrash(a1: (Int, Int), a2: (Int, Int), b1: (Int, Int), b2: (Int, Int)) -> Bool {
    var A = a1, B = a2, C = b1, D = b2
    if A > B {
        swap(&A, &B)
    }
    if C > D {
        swap(&C, &D)
    }
    let abc = ccw(a: A, b: B, c: C)
    let abd = ccw(a: A, b: B, c: D)
    let cda = ccw(a: C, b: D, c: A)
    let cdb = ccw(a: C, b: D, c: B)
    if abc == 0 && abd == 0 && cda == 0 && cdb == 0 {
         return B < C || D < A
    }
    return !(abc*abd <= 0 && cda*cdb <= 0)
}

func makeHul(input: [(Int, Int)]) -> [(Int, Int)] {
    var arr = input
    arr.sort(by: {$0.1 < $1.1})
    arr.sort(by: {$0.0 < $1.0})
    let S = arr[0]
    arr[1..<arr.count].sort(by: {
        ccw(a: S, b: $0, c: $1) == 0 && (dist(a: S, b: $0) < dist(a: S, b: $1))
    })
    arr[1..<arr.count].sort(by: {
        ccw(a: S, b: $0, c: $1) > 0
    })
    var stack:[(Int, Int)] = []
    for next in arr {
        while stack.count >= 2 && (ccw(a: stack[stack.count-2], b: stack[stack.count-1], c: next) <= 0) {
            stack.removeLast()
        }
        stack.append(next)
    }
    return stack
}

let t = Int(readLine()!)!
var str = ""
for _ in 0..<t {
    let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n = nm[0], m = nm[1]
    var black:[(Int, Int)] = Array(repeating: (0, 0), count: n)
    var white:[(Int, Int)] = Array(repeating: (0, 0), count: m)
    for i in 0..<n {
        let line = readLine()!.split(separator: " ").map{Int(String($0))!}
        black[i] = (line[0], line[1])
    }
    for i in 0..<m {
        let line = readLine()!.split(separator: " ").map{Int(String($0))!}
        white[i] = (line[0], line[1])
    }
    let blackHul = makeHul(input: black)
    let whiteHul = makeHul(input: white)
    let p = blackHul.count, q = whiteHul.count
    var result = true
    for i in blackHul {
        if check(a: i, set: whiteHul) {
            result = false
            break
        }
    }
    for i in whiteHul {
        if check(a: i, set: blackHul) {
            result = false
            break
        }
    }
    loop: for i in 0..<p {
        for j in 0..<q {
            if !notCrash(a1: blackHul[i], a2: blackHul[(i+1)%p], b1: whiteHul[j], b2: whiteHul[(j+1)%q]) {
                result = false
                break loop
            }
        }
    }
    str += result ? "YES\n" : "NO\n"
}
print(str)

