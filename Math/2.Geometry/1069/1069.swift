import Foundation
let line = readLine()!.split(separator: " ").map{Double(String($0))!}
let x = line[0], y = line[1], D = line[2], T = line[3]
let d = sqrt(x*x + y*y)
if D <= T {
    print(d)
}
else {
    var spentTime:Double = 0
    var lastLeng = d
    while lastLeng >= 2*D {
        lastLeng -= D
        spentTime += T
    }
    if lastLeng <= D {
        spentTime += min(2*T, lastLeng, D-lastLeng+T)
    }
    else {
        spentTime += min(2*T, T+lastLeng-D)
    }
    print(spentTime)
}
