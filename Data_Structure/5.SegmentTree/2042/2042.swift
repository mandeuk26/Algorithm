struct Segment {
    private var arr:[CLongLong]
    private var seg:[CLongLong]
    public mutating func calcDiff(index: Int, value: CLongLong) -> CLongLong {
        let previous = arr[index]
        arr[index] = value
        return value - previous
    }
    public mutating func update(start: Int, end: Int, node: Int, index: Int, diff: CLongLong) {
        if index < start || index > end {
            return
        }
        seg[node] += diff
        if start == end {
            return
        }
        let mid = (start+end)/2
        update(start: start, end: mid, node: 2*node, index: index, diff: diff)
        update(start: mid+1, end: end, node: 2*node+1, index: index, diff: diff)
    }
    public func sum(start: Int, end: Int, node: Int, left: Int, right: Int) -> CLongLong {
        if left > end || right < start {
            return 0
        }
        if left <= start && end <= right {
            return seg[node]
        }
        let mid = (start+end)/2
        return sum(start: start, end: mid, node: 2*node, left: left, right: right) + sum(start: mid+1, end: end, node: 2*node+1, left: left, right: right)
    }
    private mutating func makeSeg(start: Int, end: Int, node: Int) -> CLongLong {
        if start == end {
            seg[node] = arr[start]
        }
        else {
            let mid = (start+end)/2
            seg[node] = makeSeg(start: start, end: mid, node: 2*node) + makeSeg(start: mid+1, end: end, node: 2*node+1)
        }
        return seg[node]
    }
    init(arr: [CLongLong]) {
        self.arr = arr
        seg = Array(repeating: 0, count: 4*arr.count)
        makeSeg(start: 0, end: arr.count-1, node: 1)
    }
}

let nmk = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nmk[0], m = nmk[1], k = nmk[2]
var arr:[CLongLong] = Array(repeating: -1, count: n)
for i in 0..<n {
    arr[i] = CLongLong(String(readLine()!))!
}
var segtree = Segment(arr: arr)
var str = ""
for _ in 1...m+k {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    if line[0] == 1 {
        let diff = segtree.calcDiff(index: line[1]-1, value: CLongLong(line[2]))
        segtree.update(start: 0, end: n-1, node: 1, index: line[1]-1, diff: diff)
    }
    else {
        str += "\(segtree.sum(start: 0, end: n-1, node: 1, left: line[1]-1, right: line[2]-1))\n"
    }
}
print(str)

