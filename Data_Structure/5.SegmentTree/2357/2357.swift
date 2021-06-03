struct Segment {
    var arr:[Int]
    var tree:[Int]
    var isMax:Bool
    init(arr: [Int], isMax: Bool) {
        self.arr = arr
        self.isMax = isMax
        tree = Array(repeating: 0, count: 4*arr.count)
        makeTree(start: 0, end: arr.count-1, node: 1)
    }
    
    mutating func makeTree(start: Int, end: Int, node: Int) -> Int {
        if start == end {
            tree[node] = arr[start]
        }
        else {
            let mid = (start+end)/2
            if isMax {
                tree[node] = max(makeTree(start: start, end: mid, node: 2*node), makeTree(start: mid+1, end: end, node: 2*node+1))
            }
            else {
                tree[node] = min(makeTree(start: start, end: mid, node: 2*node), makeTree(start: mid+1, end: end, node: 2*node+1))
            }
        }
        return tree[node]
    }
    
    func find(start: Int, end: Int, node: Int, left: Int, right: Int) -> Int {
        if end < left || right < start {
            return isMax ? 0 : 1_000_000_001
        }
        if left <= start && end <= right {
            return tree[node]
        }
        let mid = (start+end)/2
        if isMax {
            return max(find(start: start, end: mid, node: 2*node, left: left, right: right), find(start: mid+1, end: end, node: 2*node+1, left: left, right: right))
        }
        else {
            return min(find(start: start, end: mid, node: 2*node, left: left, right: right), find(start: mid+1, end: end, node: 2*node+1, left: left, right: right))
        }
    }
}

let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0], m = nm[1]
var arr = Array(repeating: 0, count: n)
for i in 0..<n {
    arr[i] = Int(String(readLine()!))!
}
var maxTree = Segment(arr: arr, isMax: true)
var minTree = Segment(arr: arr, isMax: false)
var str = ""
for _ in 0..<m {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    str += "\(minTree.find(start: 0, end: n-1, node: 1, left: line[0]-1, right: line[1]-1)) \(maxTree.find(start: 0, end: n-1, node: 1, left: line[0]-1, right: line[1]-1))\n"
}
print(str)

