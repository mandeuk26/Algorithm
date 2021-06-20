let nm = readLine()!.split(separator: " ").map{Int($0)!}
let n = nm[0], m = nm[1]
var board:[[Int]] = []
for _ in 1...n {
    board.append(readLine()!.map{Int(String($0))!})
}
BFS()
print(board[n-1][m-1])

func BFS() {
    var queue:[(y:Int, x:Int)] = [(0, 0)]
    let dx = [1, -1, 0, 0]
    let dy = [0, 0, 1, -1]
    
    while !queue.isEmpty {
        let node = queue.removeFirst()
        for i in 0...3 {
            let nextX = node.x + dx[i]
            let nextY = node.y + dy[i]
            if nextX < 0 || nextY < 0 || nextX == m || nextY == n {continue}
            else if board[nextY][nextX] == 1 {
                board[nextY][nextX] = board[node.y][node.x] + 1
                queue.append((y:nextY, x:nextX))
            }
        }
    }
}

