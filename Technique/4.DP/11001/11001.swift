let nd = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nd[0], d = nd[1]
let t = readLine()!.split(separator: " ").map{Int(String($0))!}
let v = readLine()!.split(separator: " ").map{Int(String($0))!}
var result:Int64 = 0
dnc(s: 0, e: n-1, l: 0, r: n-1)
print(result)

func c(i: Int, j: Int) -> Int64 {
    return Int64(j-i)*Int64(t[j])+Int64(v[i])
}

func dnc(s: Int, e: Int, l: Int, r: Int) {
    if s > e {
        return
    }
    let m = (s+e)/2
    var k = max(l, m-d)
    for i in k...min(r, m) {
        if c(i: k, j: m) < c(i: i, j: m) {
            k = i
        }
    }
    result = max(result, c(i: k, j: m))
    dnc(s: s, e: m-1, l: l, r: k)
    dnc(s: m+1, e: e, l: k, r: r)
}

