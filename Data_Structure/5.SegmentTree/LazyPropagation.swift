struct Segment {
    var arr = [Int]()
    var seg = [Int]()
    var lazy = [Int]()
    mutating func makeTree(start: Int, end: Int, node: Int) -> Int {
        if start == end {
            seg[node] = arr[start]
            return seg[node]
        }
        let mid = (start+end)/2
        let l = makeTree(start: start, end: mid, node: 2*node)
        let r = makeTree(start: mid+1, end: end, node: 2*node+1)
        seg[node] = l+r
        return seg[node]
    }
    mutating func updateLazy(start: Int, end: Int, node: Int) {
        if lazy[node] != 0 {
            seg[node] += lazy[node]*(end-start+1)
            if start != end {
                lazy[2*node] += lazy[node]
                lazy[2*node+1] += lazy[node]
            }
            lazy[node] = 0
        }
    }
    mutating func find(start: Int, end: Int, node: Int, left: Int, right: Int) -> Int {
        updateLazy(start: start, end: end, node: node)
        if left > end || start > right {
            return 0
        }
        if left <= start && end <= right {
            return seg[node]
        }
        let mid = (start+end)/2
        let l = find(start: start, end: mid, node: 2*node, left: left, right: right)
        let r = find(start: mid+1, end: end, node: 2*node+1, left: left, right: right)
        return l+r
    }
    mutating func update(start: Int, end: Int, node: Int, left: Int, right: Int, val: Int) {
        updateLazy(start: start, end: end, node: node)
        if right < start || left > end {
            return
        }
        if left <= start && end <= right {
            lazy[node] += val
            updateLazy(start: start, end: end, node: node)
            return
        }
        let mid = (start+end)/2
        update(start: start, end: mid, node: 2*node, left: left, right: right, val: val)
        update(start: mid+1, end: end, node: 2*node+1, left: left, right: right, val: val)
        seg[node] = seg[2*node] + seg[2*node+1]
    }
    init(arr: [Int]) {
        self.arr = arr
        self.seg = Array(repeating: 0, count: 4*arr.count)
        self.lazy = Array(repeating: 0, count: 4*arr.count)
        makeTree(start: 0, end: arr.count-1, node: 1)
    }
}
