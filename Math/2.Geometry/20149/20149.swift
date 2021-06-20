import Foundation
func ccw(A: (Int, Int), B: (Int, Int), C: (Int, Int)) -> Int {
    let P = (B.0-A.0, B.1-A.1)
    let Q = (C.0-A.0, C.1-A.1)
    let S:CLongLong = CLongLong(P.0)*CLongLong(Q.1) - CLongLong(Q.0)*CLongLong(P.1)
    if S > 0 {
        return 1
    }
    else if S < 0 {
        return -1
    }
    else {
        return 0
    }
}

func intersection(A: (Int, Int), B: (Int, Int), C: (Int, Int), D: (Int, Int)) -> (Double, Double) {
    let x1 = A.0, y1 = A.1, x2 = B.0, y2 = B.1, x3 = C.0, y3 = C.1, x4 = D.0, y4 = D.1
    let px = (x1*y2-y1*x2)*(x3-x4) - (x1-x2)*(x3*y4 - y3*x4)
    let py = (x1*y2-y1*x2)*(y3-y4) - (y1-y2)*(x3*y4 - y3*x4)
    let p = (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4)
    return (Double(px)/Double(p), Double(py)/Double(p))
}

let line1 = readLine()!.split(separator: " ").map{Int(String($0))!}
let line2 = readLine()!.split(separator: " ").map{Int(String($0))!}
var result = -1
var inter:(Double, Double) = (1000001, 1000001)

var A = (line1[0], line1[1])
var B = (line1[2], line1[3])
var C = (line2[0], line2[1])
var D = (line2[2], line2[3])
let calc1 = ccw(A: A, B: B, C: C)
let calc2 = ccw(A: A, B: B, C: D)
let calc3 = ccw(A: C, B: D, C: A)
let calc4 = ccw(A: C, B: D, C: B)
if calc1 == 0 && calc2 == 0 && calc3 == 0 && calc4 == 0 {
    if B < A {swap(&A, &B)}
    if D < C {swap(&C, &D)}
    if C <= B && A <= D {
        result = 1
        if B == C {
            inter = (Double(B.0), Double(B.1))
        }
        else if A == D {
            inter = (Double(D.0), Double(D.1))
        }
    }
    else {
        result = 0
    }
}
else if calc1*calc2 <= 0 && calc3*calc4 <= 0 {
    result = 1
    inter = intersection(A: A, B: B, C: C, D: D)
}
else {
    result = 0
}
print(result)
if result == 1 && inter.0 <= 1000000 {
    print(inter.0, inter.1)
}

