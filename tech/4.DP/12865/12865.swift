let nk = readLine()!.split(separator: " ").map{Int($0)!}
let n = nk[0]
let k = nk[1]
var arr = Array(repeating: 0, count: k+1)
var WV:[(w:Int, v:Int)] = []
for _ in 1...n {
    let line = readLine()!.split(separator: " ").map{Int($0)!}
    WV.append((w:line[0], v:line[1]))
}
for wv in WV {
    let w = wv.w, v = wv.v
    if w > k {continue}
    var tmp = arr
    for i in w...k {
        if arr[i] < arr[i-w] + v {
            tmp[i] = arr[i-w] + v
        }
    }
    arr = tmp
}
print(arr[k])

