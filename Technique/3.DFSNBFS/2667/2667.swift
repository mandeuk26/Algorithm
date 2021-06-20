let n = Int(readLine()!)!
var isVisited = Array(repeating: Array(repeating: false, count: n), count: n)
var town:[Int] = []
for i in 0..<n {
    var j = 0
    for c in readLine()! {
        if c == "0" {
            isVisited[i][j] = true
        }
        j += 1
    }
}

for i in 0..<n {
    for j in 0..<n {
        if isVisited[i][j] {continue}
        else {
            var result = 1
            isVisited[i][j] = true
            DFS(result: &result, x: i, y: j)
            town.append(result)
        }
    }
}
var str = "\(town.count)\n"
for i in town.sorted() {
    str += "\(i)\n"
}
print(str)

func DFS(result: inout Int, x: Int, y: Int) {
    let dx = [0, 0, -1, 1]
    let dy = [-1, 1, 0, 0]
    for i in 0...3 {
        let calcX = x+dx[i]
        let calcY = y+dy[i]
        if calcX < 0 || calcX == n || calcY < 0 || calcY == n || isVisited[calcX][calcY] {continue}
        else {
            result += 1
            isVisited[calcX][calcY] = true
            DFS(result: &result, x: calcX, y: calcY)
        }
    }
}

