let t = Int(readLine()!)!
for _ in 1...t {
    let n = Int(String(readLine()!))!
    var priCount = Array(repeating: 0, count: n+1)
    var edge:[[Int]] = Array(repeating: [], count: n+1)
    let order = readLine()!.split(separator: " ").map{Int(String($0))!}
    for i in 0..<order.count {
        for j in 0..<i {
            edge[order[j]].append(order[i])
        }
        priCount[order[i]] = i
    }
    let m = Int(String(readLine()!))!
    for _ in 0..<m {
        let line = readLine()!.split(separator: " ").map{Int(String($0))!}
        let S1 = line[0], S2 = line[1]
        if edge[S1].contains(S2) {
            edge[S2].append(S1)
            edge[S1].remove(at: edge[S1].firstIndex(of: S2)!)
            priCount[S1] += 1
            priCount[S2] -= 1
        }
        else {
            edge[S1].append(S2)
            edge[S2].remove(at: edge[S2].firstIndex(of: S1)!)
            priCount[S2] += 1
            priCount[S1] -= 1
        }
    }
    
    var result = 0
    var str = ""
    var queue:[Int] = []
    for i in 1...n {
        if priCount[i] == 0 {
            queue.append(i)
        }
    }
    if queue.count > 1 {
        result = -1
    }
    else if queue.count == 0 {
        result = -2
    }
    else {
        while !queue.isEmpty {
            let curr = queue.removeFirst()
            str += "\(curr) "
            result += 1
            for k in edge[curr] {
                priCount[k] -= 1
                if priCount[k] == 0 {
                    queue.append(k)
                }
            }
            if queue.count > 1 {
                result = -1
                break
            }
        }
    }
    switch result {
    case -1:
        print("?")
    case n:
        print(str)
    default:
        print("IMPOSSIBLE")
    }
}

