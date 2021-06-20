func updateTree(tree: inout [Int], start: Int, end: Int, node: Int, index: Int, val: Int) {
    if index < start || index > end {
        return
    }
    tree[node] += val
    if start == end {
        return
    }
    let mid = (start+end)/2
    updateTree(tree: &tree, start: start, end: mid, node: 2*node, index: index, val: val)
    updateTree(tree: &tree, start: mid+1, end: end, node: 2*node+1, index: index, val: val)
}

func findTree(tree: [Int], start: Int, end: Int, node: Int, left: Int, right: Int) -> Int {
    if right < start || left > end {
        return 0
    }
    if left <= start && end <= right {
        return tree[node]
    }
    let mid = (start+end)/2
    return findTree(tree: tree, start: start, end: mid, node: 2*node, left: left, right: right) + findTree(tree: tree, start: mid+1, end: end, node: 2*node+1, left: left, right: right)
}

let t = Int(readLine()!)!
for _ in 0..<t {
    let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n = nm[0], m = nm[1]
    var ydp:[[Int]] = Array(repeating: [], count: 100002)
    var arr:[(Int, Int, Int, Int)] = []
    var tree:[Int] = Array(repeating: 0, count: 2*131072)
    var paradeResult:[Int] = Array(repeating: -1, count: m)
    for _ in 0..<n {
        let xy = readLine()!.split(separator: " ").map{Int(String($0))!}
        let x = xy[0], y = xy[1]
        ydp[y+1].append(x+1)
    }
    for i in 0..<m {
        let parade = readLine()!.split(separator: " ").map{Int(String($0))!}
        arr.append((parade[0]+1, parade[1]+1, parade[2], i))
        arr.append((parade[0]+1, parade[1]+1, parade[3]+1, i))
    }
    arr.sort(by: {$0.2 < $1.2})
    var index = 0
    var result = 0
    for p in arr {
        while index <= p.2 {
            for i in ydp[index] {
                updateTree(tree: &tree, start: 1, end: 100001, node: 1, index: i, val: 1)
            }
            index += 1
        }
        let findresult = findTree(tree: tree, start: 1, end: 100001, node: 1, left: p.0, right: p.1)
        if paradeResult[p.3] == -1 {
            paradeResult[p.3] = findresult
        }
        else {
            result += findresult - paradeResult[p.3]
        }
    }
    print(result)
}

