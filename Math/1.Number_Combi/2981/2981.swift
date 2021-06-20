let n = Int(readLine()!)!
var num:[Int] = []
for _ in 1...n {
    num.append(Int(readLine()!)!)
}
num.sort()

var bm = num[1]-num[0]
for i in 2..<n {
    bm = gcd(a: bm, b: num[i]-num[i-1])
}

var index = 2
var result:[Int] = [bm]
while index*index <= bm {
    if bm%index == 0 {
        result.append(index)
        if index*index != bm {
            result.append(bm/index)
        }
    }
    index += 1
}
result.sort()
var str = ""
for i in result {
    str += "\(i) "
}
print(str)

func gcd(a: Int, b: Int) -> Int {
    if a%b == 0 {return b}
    else {return gcd(a: b, b: a%b)}
}
