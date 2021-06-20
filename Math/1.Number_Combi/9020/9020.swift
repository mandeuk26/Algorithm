readLine()
var arr = [Bool](repeating: true, count: 10001)
for i in 2...10000 {
    if !arr[i] {continue}
    for j in stride(from: 2*i, through: 10000, by: i) {arr[j] = false}
}
while let line = readLine() {
    var compare1 = Int(line)!/2
    var compare2 = Int(line)!/2
    while compare1 > 1 {
        if arr[compare1] && arr[compare2] {
            print("\(compare1) \(compare2)")
            break
        }
        else {
            compare1 -= 1
            compare2 += 1
        }
    }
}
