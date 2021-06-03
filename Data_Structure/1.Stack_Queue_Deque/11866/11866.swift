struct Queue {
    var enqueue:[Int] = []
    var dequeue:[Int] = []
    init(_ arr:[Int]) {
        enqueue = arr
    }
    mutating func push(_ a: Int) {
        enqueue.append(a)
    }
    mutating func pop() -> Int {
        if dequeue.isEmpty {
            dequeue = enqueue.reversed()
            enqueue.removeAll()
        }
        if dequeue.isEmpty {
            return -1
        }
        else {return dequeue.removeLast()}
    }
}
let nk = readLine()!.split(separator: " ").map{Int($0)!}
let n = nk[0]
let k = nk[1]
var queue = Queue([Int](1...n))
var str = "<"
for _ in 1...n {
    for _ in 1..<k {
        queue.push(queue.pop())
    }
    str += "\(queue.pop()), "
}
str.removeLast()
str.removeLast()
str += ">"
print(str)

