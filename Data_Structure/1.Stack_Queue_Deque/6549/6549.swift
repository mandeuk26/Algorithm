while true {
    var line = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n = line[0]
    if n == 0 {
        break
    }
    line.append(0)
    var stack:[(Int, Int)] = []
    var result = 0
    for i in 1...n+1 {
        if stack.isEmpty {
            stack.append((line[i], i))
        }
        else {
            while let tmp = stack.last {
                if tmp.0 <= line[i] {
                    stack.append((line[i], i))
                    break
                }
                else {
                    let lastElement = stack.removeLast()
                    if stack.isEmpty {
                        result = max(result, (i-1)*lastElement.0)
                        stack.append((line[i], i))
                        break
                    }
                    else {
                        let beforeLast = stack.last!
                        result = max(result, (i - beforeLast.1 - 1)*lastElement.0)
                    }
                }
            }
        }
    }
    print(result)
}

