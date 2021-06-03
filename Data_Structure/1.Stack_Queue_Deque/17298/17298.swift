let n = Int(readLine()!)!
var num = readLine()!.split(separator: " ").map{Int(String($0))!}
var stack:[(v:Int, i:Int)] = []
stack.append((v:num[0], i:0))
for i in 1..<n {
    let value = num[i]
    while let tmp = stack.last {
        if tmp.v < value {
            num[tmp.i] = value
            stack.removeLast()
        }
        else {
            break
        }
    }
    stack.append((v:num[i], i:i))
}
while let tmp = stack.popLast() {
    num[tmp.i] = -1
}
var str = ""
for i in num {
    str += "\(i) "
}
print(str)

