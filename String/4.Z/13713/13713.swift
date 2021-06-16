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

func Z(str: [Character]) -> [Int] {
    let n = str.count
    var l = -1, r = -1
    var F = Array(repeating: -1, count: n)
    F[0] = n-1
    for i in 1..<n {
        if i <= r {
            F[i] = min(F[i-l], r-i)
        }
        while i+F[i]+1 < n && str[i+F[i]+1] == str[F[i]+1] {
            F[i] += 1
        }
        if r < i+F[i] {
            r = i+F[i]
            l = i
        }
    }
    return F
}
    
let fIO = FileIO()
var line = fIO.readString().reversed().map{Character(String($0))}
var result = Z(str: line)
result.reverse()
let m = fIO.readInt()
var str = ""
for _ in 0..<m {
    let q = fIO.readInt()-1
    str += "\(result[q]+1)\n"
}
print(str)

