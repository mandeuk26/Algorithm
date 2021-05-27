let kn = readLine()!.split(separator: " ").map{Int($0)!}
let k = kn[0]
let n = kn[1]
var input = [Int]()
for _ in 1...k {
    input.append(Int(readLine()!)!)
}
var end = input.max()! + 1
var start = 1
while start < end {
    let mid = (start+end)/2
    var result = 0
    for num in input {
        result += num/mid
    }
    if result >= n {
        start = mid+1
    }
    else {
        end = mid
    }
}
print(end-1)
