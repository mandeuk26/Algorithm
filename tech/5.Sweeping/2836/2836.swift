let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1]
var line:[(Int, Int)] = []
for _ in 0..<n {
    let xy = readLine()!.split(separator: " ").map{Int(String($0))!}
    let x = xy[0], y = xy[1]
    if x > y {
        line.append((y, x))
    }
}

line.sort(by: {$0.0 < $1.0})
var r = -1, l = -1
var result:CLongLong = 0
for m in line {
    if r < m.0 {
        l = m.0
        r = m.1
        result += CLongLong(r-l)
    }
    else if r < m.1 {
        result += CLongLong(m.1-r)
        r = m.1
    }
}
result *= 2
result += CLongLong(m)
print(result)

