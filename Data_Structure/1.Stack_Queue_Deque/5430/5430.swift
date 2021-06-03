let n = Int(readLine()!)!
loop: for _ in 1...n {
    let order = readLine()!
    let length = Int(readLine()!)!
    var testcase = readLine()!.split(separator: ",")
    if length == 0 {
        testcase = []
    }
    else {
        testcase[0].removeFirst()
        testcase[length-1].removeLast()
    }
    var deque = Deque(testcase.map{Int($0)!})
    for c in order {
        if deque.RD(str:c) {
            print("error")
            continue loop
        }
    }
    if deque.first > deque.last {
        print("[]")
    }
    else {
        var result = Array(deque.enqueue[deque.first...deque.last])
        if deque.reversed {result = result.reversed()}
        var str = "["
        for i in result {
            str += "\(i),"
        }
        str.removeLast()
        str += "]"
        print(str)
    }
}

struct Deque {
    var reversed:Bool = false
    var enqueue:[Int]
    var first:Int
    var last:Int
    init(_ arr: [Int]) {
        enqueue = arr
        first = 0
        last = arr.count-1
    }
    mutating func RD(str:Character) -> Bool {
        if str == "R" {
            reversed = !reversed
        }
        else if str == "D" {
            if first > last {
                return true
            }
            else {
                if reversed {
                    last -= 1
                }
                else {
                    first += 1
                }
            }
        }
        return false
    }
}

