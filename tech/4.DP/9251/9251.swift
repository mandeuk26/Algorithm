let a = readLine()!.map{Character(String($0))}
let b = readLine()!.map{Character(String($0))}
var board: [[Int]] = Array(repeating: Array(repeating: 0, count: b.count+1), count: a.count+1)
var result = 0
for i in 1...a.count {
    for j in 1...b.count {
        if b[j-1] == a[i-1] {
            board[i][j] = board[i-1][j-1] + 1
        }
        else {
            board[i][j] = max(board[i][j-1], board[i-1][j])
        }
    }
}
print(board[a.count][b.count])
