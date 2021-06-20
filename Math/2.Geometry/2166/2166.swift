import Foundation
func ccw(x1: Int, x2: Int, x3: Int, y1: Int, y2: Int, y3: Int, z1: Int, z2: Int, z3:Int) -> (Int, Int, Int){
    let A = (x:x2-x1, y:y2-y1, z:z2-z1)
    let B = (x:x3-x1, y:y3-y1, z:z3-z1)
    let AxB = (A.y*B.z - A.z*B.y, A.z*B.x - A.x*B.z, A.x*B.y - A.y*B.x)
    return AxB
}

let n = Int(readLine()!)!
var point:[(Int, Int, Int)] = []
for _ in 1...n {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    point.append((line[0], line[1], 0))
}

let A = point[0]
var result:Double = 0
for i in 1..<n-1 {
    let B = point[i], C = point[i+1]
    let calculate = ccw(x1: A.0, x2: B.0, x3: C.0, y1: A.1, y2: B.1, y3: C.1, z1: A.2, z2: B.2, z3: C.2)
    result += Double(calculate.2)
}
result = abs(result)/2
print(String(format: "%.1f", result))
