/*
 fread 코드는 JCSooHwanCho님의 FileIO.swift 를 참조하였습니다.
 <출처 : https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88>
*/

import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}

func ccw(a: (Int, Int), b: (Int, Int), c: (Int, Int)) -> Int {
    let result:CLongLong = CLongLong(b.0-a.0)*CLongLong(c.1-a.1) - CLongLong(b.1-a.1)*CLongLong(c.0-a.0)
    return result > 0 ? 1 : (result == 0 ? 0 : -1)
}

func ccw2(a: (Int, Int), b: (Int, Int), c: (Int, Int), d: (Int, Int)) -> Bool {
    let u = (b.0-a.0, b.1-a.1)
    let v = (d.0-c.0, d.1-c.1)
    return ccw(a: (0, 0), b: u, c: v) >= 0
}

func dist(a: (Int, Int), b: (Int, Int)) -> CLongLong {
    let dx = CLongLong(a.0-b.0)
    let dy = CLongLong(a.1-b.1)
    return dx*dx+dy*dy
}

func convecs(arr: inout [(Int, Int)]) {
    var tmp = arr
    tmp.sort(by: {$0.1 < $1.1})
    tmp.sort(by: {$0.0 < $1.0})
    let startP = tmp[0]
    tmp[1..<tmp.count].sort(by: {
        ccw(a: startP, b: $0, c: $1) == 0 && (dist(a: startP, b: $0) < dist(a: startP, b: $1))
    })
    tmp[1..<tmp.count].sort(by: {ccw(a: startP, b: $0, c: $1) > 0})
    var stack:[(Int, Int)] = []
    for i in 0..<tmp.count {
        let next = tmp[i]
        while stack.count >= 2 && (ccw(a: stack[stack.count-2], b: stack[stack.count-1], c: next) <= 0) {
            stack.removeLast()
        }
        stack.append(next)
    }
    arr = stack
}

func calipers(arr: [(Int, Int)]) {
    let count = arr.count
    var pt = 0
    var ret:CLongLong = 0
    var xx = (0, 0), yy = (0, 0)
    for i in 0..<count {
        var now:CLongLong = 0
        while (pt+1 < count) && ccw2(a: arr[i], b: arr[i+1], c: arr[pt], d: arr[pt+1]) {
            now = dist(a: arr[i], b: arr[pt])
            if now > ret {
                ret = now
                xx = arr[i]
                yy = arr[pt]
            }
            pt += 1
        }
        now = dist(a: arr[i], b: arr[pt])
        if now > ret {
            ret = now
            xx = arr[i]
            yy = arr[pt]
        }
    }
    print(xx.0, xx.1, yy.0, yy.1)
}

let fIO = FileIO()
let t = fIO.readInt()
for _ in 0..<t {
    let n = fIO.readInt()
    var arr:[(Int, Int)] = Array(repeating: (0, 0), count: n)
    for i in 0..<n {
        arr[i] = (fIO.readInt(), fIO.readInt())
    }
    convecs(arr: &arr)
    calipers(arr: arr)
}

