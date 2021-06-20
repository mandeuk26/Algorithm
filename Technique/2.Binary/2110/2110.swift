let nm = readLine()!.split(separator: " ").map{Int($0)!}
let n = nm[0], m = nm[1]
var input = [Int]()
var length = [Int]()
for _ in 1...n {
    input.append(Int(readLine()!)!)
}
input.sort()
for i in 0..<n-1 {
    length.append(input[i+1] - input[i])
}
var end = length.reduce(0, +) + 1
var start = length.min()!
while start < end {
    let mid = (start+end)/2
    var result = 0, count = 0
    for num in length {
        count += num
        if count >= mid {
            result += 1
            count = 0
        }
    }
    if result >= m-1 {
        start = mid+1
    }
    else {
        end = mid
    }
}
print(end-1)
