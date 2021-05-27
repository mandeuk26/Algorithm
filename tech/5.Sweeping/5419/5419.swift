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
let t = fIO.readInt()
var str = ""
for _ in 0..<t {
    let n = fIO.readInt()
    var tree:[Int] = Array(repeating: 0, count: n+1)
    var island:[(Int, Int)] = Array(repeating: (0, 0), count: n)
    for i in 0..<n {
        island[i] = (fIO.readInt(), fIO.readInt())
    }
    island.sort(by: {$0.0 < $1.0})
    island.sort(by: {$0.1 > $1.1})
    let islandX = arrMapedX(arr: island)
    var result:CLongLong = 0
    for s in islandX {
        result += CLongLong(fenwickFind(fwk: tree, index: s))
        fenwickUpdate(fwk: &tree, index: s, val: 1, n: n)
    }
    str += "\(result)\n"
}
print(str)

func fenwickFind(fwk: [Int], index: Int) -> Int {
    var idx = index
    var rst = 0
    while idx > 0 {
        rst += fwk[idx]
        idx -= (idx & -idx)
    }
    return rst
}

func fenwickUpdate(fwk: inout [Int], index: Int, val: Int, n: Int) {
    var idx = index
    while idx <= n {
        fwk[idx] += val
        idx += (idx & -idx)
    }
}

func arrMapedX(arr: [(Int, Int)]) -> [Int] {
    let arr_sorted = arr.sorted(by: {$0.0 < $1.0})
    var index = 1
    var dict = Dictionary<Int, Int>()
    for i in arr_sorted {
        guard dict[i.0] != nil else {
            dict[i.0] = index
            index += 1
            continue
        }
    }
    var tmp = [Int]()
    for i in arr {
        tmp.append(dict[i.0]!)
    }
    return tmp
}

