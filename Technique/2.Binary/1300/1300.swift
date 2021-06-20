let n = Int(readLine()!)!
let k = Int(readLine()!)!
var end = k+1
var start = 1
while start < end {
    let mid = (start+end)/2
    var count = 0
    for i in 1...n {
        let tmp = min(mid/i, n)
        if tmp == 0 {break}
        count += tmp
    }
    if count < k {
        start = mid+1
    }
    else {
        end = mid
    }
}
print(end)
