let nk = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nk[0], k = nk[1]

func fenwickUpdate(tree: inout [Int], index: Int, val: Int) {
    var idx = index
    while idx <= n {
        tree[idx] += val
        idx += (idx & -idx)
    }
}

func fenwickFind(tree: [Int], index: Int) -> Int {
    var idx = index
    var rst = 0
    while idx > 0 {
        rst += tree[idx]
        idx -= (idx & -idx)
    }
    return rst
}

func findKth(tree: [Int], start: Int, end: Int, k: Int) -> Int {
    let rst1 = fenwickFind(tree: tree, index: start-1)
    let rst2 = fenwickFind(tree: tree, index: end)
    if rst2-rst1 >= k {
        var s = start, e = end+1
        while s < e {
            let mid = (s+e)/2
            if fenwickFind(tree: tree, index: mid)-rst1 >= k {
                e = mid
            }
            else {
                s = mid+1
            }
        }
        return e
    }
    else {
        return findKth(tree: tree, start: 1, end: n, k: k-rst2+rst1)
    }
}

var fenwick = Array(repeating: 0, count: n+1)
var str = "<"
for i in 1...n {
    fenwickUpdate(tree: &fenwick, index: i, val: 1)
}
var index = 1
for _ in 1...n {
    index = findKth(tree: fenwick, start: index, end: n, k: k)
    fenwickUpdate(tree: &fenwick, index: index, val: -1)
    str += "\(index), "
}
str.removeLast()
str.removeLast()
str += ">"
print(str)

