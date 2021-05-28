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

let fIO = FileIO()
let n = fIO.readInt(), sqrtN = Int(sqrt(Double(n)))
var A = Array(repeating: 0, count: n+1)
for i in 1...n {
    A[i] = fIO.readInt()
}
let m = fIO.readInt()
var query:[(Int, Int, Int)] = Array(repeating: (0, 0, 0), count: m)
var count:[Int] = Array(repeating: 0, count: 1_000_001)

func minus(s: Int, e: Int, val: inout Int) {
    for i in s...e {
        count[A[i]] -= 1
        if count[A[i]] == 0 {val -= 1}
    }
}

func plus(s: Int, e: Int, val: inout Int) {
    for i in s...e {
        if count[A[i]] == 0 {val += 1}
        count[A[i]] += 1
    }
}

for i in 0..<m {
    query[i] = (fIO.readInt(), fIO.readInt(), i)
}
query.sort(by: {$0.1 < $1.1})
query.sort(by: {$0.0/sqrtN < $1.0/sqrtN})

var queryResult = Array(repeating: 0, count: m)
var result = 0, ps = query[0].0, pe = query[0].1
plus(s: ps, e: pe, val: &result)
queryResult[query[0].2] = result
for i in 1..<query.count {
    let curr = query[i]
    if curr.0 < ps {plus(s: curr.0, e: ps-1, val: &result)}
    else if curr.0 > ps {minus(s: ps, e: curr.0-1, val: &result)}
    if curr.1 > pe {plus(s: pe+1, e: curr.1, val: &result)}
    else if curr.1 < pe {minus(s: curr.1+1, e: pe, val: &result)}
    ps = curr.0
    pe = curr.1
    queryResult[curr.2] = result
}

var str = ""
for i in 0..<queryResult.count {
    str += "\(queryResult[i])\n"
}
print(str)
