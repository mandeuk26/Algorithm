let nm = readLine()!.split(separator: " ").map{Int($0)!}
let start = nm[0]
let end = nm[1]
var queue:[Int] = []
var visited = Array(repeating: false, count: 100001)
queue.append(start)
visited[start] = true

var time = -1
var index = 0
loop: while true {
    time += 1
    let k = index
    for i in k..<queue.count {
        let node = queue[i]
        if node == end {
            break loop
        }
        else {
            let a = 2*node
            let b = node-1
            let c = node+1
            if a <= 100000 && !visited[a] {
                visited[a] = true
                queue.append(a)
            }
            if b >= 0 && !visited[b]{
                visited[b] = true
                queue.append(b)
            }
            if c <= 100000 && !visited[c]{
                visited[c] = true
                queue.append(c)
            }
            index += 1
        }
    }
}
print(time)
