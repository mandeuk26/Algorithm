let n = Int(readLine()!)!
for i in 1...n {
    let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
    var arr = Array(repeating: 1, count: 31)
    for p in 1...nm[1] {
        let tmp = arr
        for q in 1..<p {
            arr[q] = tmp[q] + tmp[q-1]
        }
    }
    print(arr[nm[0]])
}
