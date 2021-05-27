/*
 fread를 위한 코드로는 JCSooHwanCho님의 FileIO.swift를 참조하였습니다.
 출처 : https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88
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

let fIO = FileIO()
let n = fIO.readInt()
var line:[(Int, Int)] = Array(repeating: (0,0), count: n)
for i in 0..<n {
    let x = fIO.readInt(), y = fIO.readInt()
    line[i] = (x, y)
}
line.sort(by: {$0.0 < $1.0})

var left = -1_000_000_000, right = -1_000_000_000, result = 0
for l in line {
    if right < l.0 {
        left = l.0
        right = l.1
        result += right-left
    }
    else if l.1 > right {
        result += l.1-right
        right = l.1
    }
}
print(result)
