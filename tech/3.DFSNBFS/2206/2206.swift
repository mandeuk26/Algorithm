let nm = readLine()!.split(separator: " ").map{Int($0)!}
let n = nm[0]
let m = nm[1]
var board:[[(Int, Bool)]] = []
for _ in 1...n {
    board.append(readLine()!.map{(Int(String($0))!, false)})
}
var queue:[(y:Int, x:Int, broken:Bool)] = [(0, 0, false)]
board[0][0] = (2, false)

let dx = [1, -1, 0, 0]
let dy = [0, 0, 1, -1]
var dist = 0
var index = 0
var success = false
loop: while index < queue.count {
    dist += 1
    for i in index..<queue.count {
        let node = queue[i]
        if node.x == m-1 && node.y == n-1 {
            success = true
            break loop
        }
        for i in 0...3 {
            let X = node.x + dx[i]
            let Y = node.y + dy[i]
            if X < 0 || Y < 0 || X == m || Y == n {continue}
            let visited = board[Y][X].0
            let brokenSpace = board[Y][X].1
            if visited == 0 {
                board[Y][X] = (2, node.broken)
                queue.append((y: Y, x: X, broken: node.broken))
            }
            else if visited == 1 && !node.broken {
                board[Y][X] = (-1, true)
                queue.append((y: Y, x: X, broken: true))
            }
            else if visited == 2 && !node.broken && brokenSpace {
                board[Y][X] = (2, false)
                queue.append((y: Y, x: X, broken: false))
            }
        }
        index += 1
    }
}
print(success ? dist : -1)

