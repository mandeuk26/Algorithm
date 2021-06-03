struct Segment {
    var arr:[Int]
    var tree:[(Int, Int)]
    mutating func update(start: Int, end: Int, node: Int, index: Int, val: Int) {
        if index < start || index > end {
            return
        }
        if start == end {
            tree[node] = (val, val)
            return
        }
        let mid = (start+end)/2
        update(start: start, end: mid, node: 2*node, index: index, val: val)
        update(start: mid+1, end: end, node: 2*node+1, index: index, val: val)
        tree[node] = (min(tree[2*node].0, tree[2*node+1].0), max(tree[2*node].1, tree[2*node+1].1))
    }
    mutating func change(a: Int, b: Int) {
        arr.swapAt(a, b)
        update(start: 0, end: arr.count-1, node: 1, index: a, val: arr[a])
        update(start: 0, end: arr.count-1, node: 1, index: b, val: arr[b])
    }
    func find(start: Int, end: Int, node: Int, left: Int, right: Int) -> (Int, Int) {
        if right < start || end < left {
            return (100000, 0)
        }
        if left <= start && end <= right {
            return tree[node]
        }
        let mid = (start+end)/2
        let l = find(start: start, end: mid, node: 2*node, left: left, right: right)
        let r = find(start: mid+1, end: end, node: 2*node+1, left: left, right: right)
        return (min(l.0, r.0), max(l.1, r.1))
    }
    mutating func makeTree(start: Int, end: Int, node: Int) -> (Int, Int) {
        if start == end {
            tree[node] = (arr[start], arr[start])
            return tree[node]
        }
        let mid = (start+end)/2
        let l = makeTree(start: start, end: mid, node: 2*node)
        let r = makeTree(start: mid+1, end: end, node: 2*node+1)
        tree[node] = (min(l.0, r.0), max(l.1, r.1))
        return tree[node]
    }
    init(n: Int) {
        self.arr = [Int](0..<n)
        self.tree = Array(repeating: (100000, 0), count: 4*n)
        makeTree(start: 0, end: n-1, node: 1)
    }
}
var str = ""
let t = Int(readLine()!)!
for _ in 0..<t {
    let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n = nm[0], m = nm[1]
    var seg = Segment(n: n)
    for _ in 0..<m {
        let query = readLine()!.split(separator: " ").map{Int(String($0))!}
        if query[0] == 0 {
            seg.change(a: query[1], b: query[2])
        }
        else {
            let result = seg.find(start: 0, end: n-1, node: 1, left: query[1], right: query[2])
            if result.0 == query[1] && result.1 == query[2] {
                str += "YES\n"
            }
            else {
                str += "NO\n"
            }
        }
    }
}
print(str)

